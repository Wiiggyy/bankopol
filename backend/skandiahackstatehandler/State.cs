using System;
using System.Collections.Concurrent;
using System.Collections.Immutable;
using System.Diagnostics;
using System.Net.WebSockets;
using System.Text;
using System.Text.Json;
using skandiahackstatehandler.Data;
using skandiahackstatehandler.Data.Enums;

namespace skandiahackstatehandler
{
    public static class State
    {
        private static object _lock = new object();
        private static List<(WebSocket socket, TaskCompletionSource socketFinishedTcs)> playerData = new();
        private static InternalGameState gameState = new InternalGameState();
        private static string? latestMessage = null;
        public static string? LatestMessage
        {
            get
            {
                lock (_lock)
                {
                    return latestMessage;
                }
            }
        }

        /// <summary>
        /// Only to be used by the message sender worker service
        /// </summary>
        /// <returns></returns>
        public static IEnumerable<WebSocket> GetPlayerSnapshot()
        {
            lock (_lock)
            {
                return playerData.Select(d => d.socket).ToList();
            }
        }
        public static readonly ConcurrentQueue<(OutEvent eventData, IEnumerable<WebSocket> recipients)> OutgoingMessages = new();
        public static readonly ConcurrentQueue<(Event eventData, WebSocket sender)> EventQueue = new();
        private static ConcurrentDictionary<WebSocket, string> PlayerIdMapping = [];

        public static void WipeData()
        {
            lock (_lock)
            {
                foreach (var item in playerData)
                {
                    try
                    {
                        item.socket.CloseAsync(WebSocketCloseStatus.Empty, "Admin wipe of game state", CancellationToken.None)
                            .GetAwaiter().GetResult();
                    }
                    catch (Exception)
                    {
                    }
                    item.socketFinishedTcs.SetResult();

                }
                latestMessage = "{}";
                playerData.Clear();
            }
        }

        internal static string PlayerIdForSocket(WebSocket socket)
        {
            return PlayerIdMapping[socket];
        }

        internal static async Task AddPlayerAndPlay(WebSocket webSocket, TaskCompletionSource socketFinishedTcs)
        {
            try
            {
                lock (_lock)
                {
                    playerData.Add((webSocket, socketFinishedTcs));
                }

                var buffer = new byte[1024 * 1024];
                var receiveResult = await webSocket.ReceiveAsync(
                    new ArraySegment<byte>(buffer), CancellationToken.None);

                while (!receiveResult.CloseStatus.HasValue)
                {
                    if (receiveResult.MessageType != WebSocketMessageType.Text)
                        throw new NotImplementedException("Only text supported!");
                    if (!receiveResult.EndOfMessage)
                        throw new NotImplementedException("Only single part messages supported!");

                    //var shortbuffer = buffer[..receiveResult.Count]; //TODO: use this instead of cloning entire buffer

                    var outMessage = new ArraySegment<byte>((byte[])buffer.Clone(), 0, receiveResult.Count);
                    lock (_lock)
                    {
                        latestMessage = UTF8Encoding.UTF8.GetString(outMessage);
                    }

                    try
                    {
                        var text = Encoding.UTF8.GetString(buffer, 0, receiveResult.Count);
                        var e = System.Text.Json.JsonSerializer.Deserialize<Event>(text);
                        if (e != null)
                        {
                            EventQueue.Enqueue((e, webSocket));
                        }
                    }
                    catch (System.Exception)
                    {
                        // TODO(Samuel): Log this shizz!
                    }

                    receiveResult = await webSocket.ReceiveAsync(
                        new ArraySegment<byte>(buffer), CancellationToken.None);
                }

                await webSocket.CloseAsync(
                    receiveResult.CloseStatus.Value,
                    receiveResult.CloseStatusDescription,
                    CancellationToken.None
                );
            }
            finally
            {
                lock (_lock)
                {
                    playerData.Remove((webSocket, socketFinishedTcs));
                }
            }
        }

        internal static void ApplyInterestAndInformClients()
        {
            // var data = LatestMessage;
            // if (data == null) return;
            // var gameState = System.Text.Json.JsonSerializer.Deserialize<GameState>(data);
            // if (gameState == null) return;
            // foreach (var player in gameState.players)
            // {
            //     player.bankAccount.amount *= 1 + player.bankAccount.interest;
            //     foreach (var investment in player.investments)
            //     {
            //         investment.value *= 1 + investment.interest;
            //     }
            // }

            // var stringifiedState = System.Text.Json.JsonSerializer.Serialize(gameState);
            // lock (_lock)
            // {
            //     latestMessage = stringifiedState;
            // }
            // var buffer = UTF8Encoding.UTF8.GetBytes(stringifiedState);

            // var outMessage = new ArraySegment<byte>(buffer, 0, buffer.Length);

            throw new NotImplementedException();
        }

        /// <summary>
        /// Takes the socket of the user and a player id and adds it to the
        /// list of current active players.
        /// If the player id does not exist in the game, we add a new player
        /// with that id.
        /// </summary>
        /// <param name="socket"></param>
        /// <param name="playerId"></param>
        internal static void JoinGame(WebSocket socket, string playerId)
        {
            PlayerIdMapping.TryAdd(socket, playerId);

            if (!gameState.players.Exists((player) => player.id == playerId))
            {
                var suffix = DateTime.UtcNow.Ticks % 100_000;
                gameState = gameState with
                {
                    //TODO(Samuel): hitta på _bättre_ slumpning av namn
                    players = [.. gameState.players, new GameState.Player(
                        id: playerId,
                         name: "Player " + suffix
                         ) {
                        bankAccount = new GameState.BankAccount(amount: 2000, interest: 0.025)
                     }],
                };
            }
            BroadcastGameState();
        }

        internal static void AddPlayerToGame(GameState.Player player)
        {
            lock (_lock)
            {
                gameState = gameState with
                {
                    players = [.. gameState.players, player],
                };
            }
            BroadcastGameState();
        }

        internal static void UpdatePlayerName(WebSocket socket, String name)
        {
            lock (_lock)
            {
                var id = PlayerIdForSocket(socket);
                var newPlayerState = gameState.players.Select(player =>
                {
                    if (player.id == id)
                    {
                        return player with
                        {
                            name = name,
                        };
                    }
                    return player;
                });

                gameState = gameState with
                {
                    players = [.. newPlayerState],
                };
            }
            BroadcastGameState();
        }

        private static void BroadcastGameState()
        {
            lock (_lock)
            {
                var newEvent = new OutEvent
                {
                    action = "newGameState",
                    data = gameState,
                };
                State.OutgoingMessages.Enqueue((newEvent, Array.Empty<WebSocket>()));
            }
        }

        internal static void FetchInvestment(WebSocket sender, InvestmentType investmentType)
        {

            var investment = generateInvestment();

            var newEvent = new OutEvent
            {
                action = "investmentOpportunity",
                data = investment,
            };

            State.OutgoingMessages.Enqueue((newEvent, [sender]));

            GameState.Investment generateInvestment()
            {
                var value = System.Random.Shared.Next(1, 1000);
                var quantity = 1; //random.nextInt(100) + 1;
                var interest = System.Random.Shared.NextDouble() * 0.2;

                return new GameState.Investment(
                    quantity: quantity,
                    value: value,
                    interest: interest,
                    investmentType: investmentType
                );
            }
        }

        internal static void BuyInvestment(WebSocket sender, GameState.Investment investment)
        {
            var id = PlayerIdForSocket(sender);
            var newPlayerState = gameState.players.Select(player =>
            {
                if (player.id == id)
                {
                    List<GameState.Investment> newInvestmentList = new List<GameState.Investment>(player.investments.Count + 1);

                    var didExist = false;
                    foreach (var ownedInvestment in player.investments)
                    {
                        if (ownedInvestment.investmentType == investment.investmentType)
                        {
                            newInvestmentList.Add(ownedInvestment with
                            {
                                quantity = ownedInvestment.quantity + investment.quantity,
                                value = ownedInvestment.value + investment.quantity,
                                interest = (ownedInvestment.interest * ownedInvestment.quantity
                                + investment.interest * investment.quantity)
                                / (ownedInvestment.quantity + investment.quantity)
                            });
                            didExist = true;
                        }
                        else
                        {
                            newInvestmentList.Add(ownedInvestment);
                        }
                    }
                    if (!didExist)
                    {
                        newInvestmentList.Add(investment);
                    }

                    return player with
                    {
                        bankAccount = player.bankAccount with
                        {
                            amount = player.bankAccount.amount - investment.value
                        },
                        investments = newInvestmentList.ToImmutableList(),
                    };
                }
                return player;
            });

            gameState = gameState with
            {
                players = [.. newPlayerState],
            };

            BroadcastGameState();
            DrawEventCard(sender);
        }

        internal static void DrawEventCard(WebSocket sender)
        {
            var investmentTypes = gameState.players.SelectMany(player =>
                    player.investments.Select(investment => investment.investmentType)
            ).ToHashSet().ToList();

            if (investmentTypes.Count == 0) return;

            var randomIndex = System.Random.Shared.Next(investmentTypes.Count);
            var randomType = investmentTypes[randomIndex];

            var eventCardsForType = EventCards.events
            .Where((e) => e.eventAction.investmentType == randomType)
            .ToList();

            var eventCard = eventCardsForType[Random.Shared.Next(eventCardsForType.Count)];

            var newEvent = new OutEvent
            {
                action = "eventCardDrawn",
                data = eventCard,
            };
            State.OutgoingMessages.Enqueue((newEvent, [sender]));
        }

        internal static void ActivateEventCard(WebSocket sender, EventCard eventCard)
        {
            var amount = eventCard.eventAction.amount ?? 0;
            var amountValue = eventCard.eventAction.amountValue ?? 0;
            var percentValue = 1 + (eventCard.eventAction.percentValue ?? 0);

            gameState = gameState with
            {
                players = [..gameState.players.Select((player) => {

                    List<GameState.Investment> newInvestmentList = new List<GameState.Investment>(player.investments.Count);

                    foreach (var investment in player.investments)
                    {
                        if (investment.investmentType == eventCard.eventAction.investmentType)
                        {
                            var newQuantity = investment.quantity + amount;
                            var newValue = investment.value * percentValue + amountValue;
                            if(newQuantity != 0 && newValue != 0){
                            newInvestmentList.Add(investment with
                            {
                                quantity = newQuantity,
                                value = newValue,
                            });
                            }
                        }
                        else
                        {
                            newInvestmentList.Add(investment);
                        }
                    }

                    return player with
                    {
                        investments = newInvestmentList.ToImmutableList(),
                    };
                })],
            };

            BroadcastGameState();
        }
    }
}