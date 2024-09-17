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
        public static readonly ConcurrentQueue<(ArraySegment<byte> message, WebSocket? recipient)> OutgoingMessages = new();
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
                CancellationToken.None);
            lock (_lock)
            {
                playerData.Remove((webSocket, socketFinishedTcs));
            }
        }

        internal static void ApplyInterestAndInformClients()
        {
            var data = LatestMessage;
            if (data == null) return;
            var gameState = System.Text.Json.JsonSerializer.Deserialize<GameState>(data);
            if (gameState == null) return;
            foreach (var player in gameState.players)
            {
                player.bankAccount.amount *= 1 + player.bankAccount.interest;
                foreach (var investment in player.investments)
                {
                    investment.value *= 1 + investment.interest;
                }
            }

            var stringifiedState = System.Text.Json.JsonSerializer.Serialize(gameState);
            lock (_lock)
            {
                latestMessage = stringifiedState;
            }
            var buffer = UTF8Encoding.UTF8.GetBytes(stringifiedState);

            var outMessage = new ArraySegment<byte>(buffer, 0, buffer.Length);

            SendToAllPlayers(null, outMessage);
        }

        private static void SendToAllPlayers(WebSocket? sender, ArraySegment<byte> message)
        {
            OutgoingMessages.Enqueue((message, null));

        }


        private class GameState
        {
            public List<Player> players { get; set; }

            public class BankAccount
            {
                public double amount { get; set; }
                public double interest { get; set; }
            }

            public class Investment
            {
                public int investmentType { get; set; }
                public double value { get; set; }
                public int quantity { get; set; }
                public double interest { get; set; }
            }

            public class Player
            {
                public string id { get; set; }
                public string name { get; set; }
                public BankAccount bankAccount { get; set; }
                public List<Investment> investments { get; set; }
                public List<int> scannedCodes { get; set; }
            }
        }
    }
}