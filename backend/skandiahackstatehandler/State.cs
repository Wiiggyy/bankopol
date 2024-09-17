using System;
using System.Collections.Concurrent;
using System.Net.WebSockets;
using System.Text;
using System.Text.Json;
using skandiahackstatehandler.Data;

namespace skandiahackstatehandler
{
    public static class State
    {
        private static object _lock = new object();
        private static List<(WebSocket socket, TaskCompletionSource socketFinishedTcs)> playerData = new();
        private static GameState gameState = new GameState();
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
        public static readonly ConcurrentQueue<OutEvent> OutgoingMessages = new();
        public static readonly ConcurrentQueue<Event> EventQueue = new();

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
                            EventQueue.Enqueue(e);
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

        internal static object AddPlayerToGame(GameState.Player player)
        {
            lock (_lock)
            {
                gameState = gameState with
                {
                    players = [.. gameState.players, player],
                };
                return gameState;
            }
        }
    }
}