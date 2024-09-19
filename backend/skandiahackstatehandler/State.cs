using System;
using System.Collections.Concurrent;
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
                // Send GameState immediately to a new player
                var message = UTF8Encoding.UTF8.GetBytes(
                        System.Text.Json.JsonSerializer.Serialize(
                            new OutEvent
                            {
                                action = "newGameState",
                                data = gameState,
                            }
                        )
                    );

                await webSocket.SendAsync(
                                    message,
                                    System.Net.WebSockets.WebSocketMessageType.Text,
                                    true,
                                    CancellationToken.None  //TODO: consider using stoppingToken here
                                    );

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
                gameState = gameState with
                {
                    //TODO(Samuel): hitta på slumpning av namn
                    players = [.. gameState.players, new GameState.Player(playerId, "random name") {
                        bankAccount = new GameState.BankAccount(amount: 2000, interest: 0.025)
                     }],
                };
            }
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

        internal static void UpdatePlayerName(String id, String name)
        {
            lock (_lock)
            {
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

        }

        internal static void GenerateEventCard(WebSocket sender)
        {
            /*
            final gameState = state.requireValue;
            final investmentTypes = <InvestmentType>{
            for (final Player player in gameState.players)
                for (final Investment investment in player.investments)
                investment.investmentType,
            };

            if (investmentTypes.isEmpty) return;
            final randomIndex = Random().nextInt(investmentTypes.length);

            final randomCardIndex = Random().nextInt(2);

            final eventCard = eventCards
                .where(
                (eventCard) =>
                    eventCard.eventAction.investmentType ==
                    investmentTypes.elementAt(randomIndex),
                )
                .elementAt(randomCardIndex);

            ref.read(currentEventCardProvider.notifier).eventCard = eventCard;
            */

            var investmentTypes = gameState.players.SelectMany(player =>
                    player.investments.Select(investment => investment.investmentType)
            ).ToHashSet();

            var temp = "";
        }
    }
}