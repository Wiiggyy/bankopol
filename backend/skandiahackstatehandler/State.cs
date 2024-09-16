using System;
using System.Net.WebSockets;
using System.Text;

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


        public static void WipeData()
        {
            lock (_lock)
            {
                foreach (var item in playerData)
                {
                    try
                    {
                        item.socket.CloseAsync(WebSocketCloseStatus.Empty, "Admin wipe of game state", CancellationToken.None).GetAwaiter().GetResult();
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

                var outMessage = new ArraySegment<byte>((byte[])buffer.Clone(), 0, receiveResult.Count);
                lock (_lock)
                {
                    latestMessage = UTF8Encoding.UTF8.GetString(outMessage);
                }
                await SendToAllPlayers(webSocket, outMessage);

                //await webSocket.SendAsync(
                //    new ArraySegment<byte>(buffer, 0, receiveResult.Count),
                //    receiveResult.MessageType,
                //    receiveResult.EndOfMessage,
                //    CancellationToken.None);

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

        internal static async Task ApplyInterestAndInformClients()
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

            await SendToAllPlayers(null, outMessage);
        }

        private static async Task SendToAllPlayers(WebSocket? sender, ArraySegment<byte> message)
        {
            WebSocket[] recipients;
            lock (_lock)
            {
                recipients = playerData.Select(s => s.socket).ToArray();
            }
            foreach (var recipient in recipients)
            {
                //if (recipient == sender) continue;

                try
                {
                    await recipient.SendAsync(
                    message,
                    WebSocketMessageType.Text,
                    true,
                    CancellationToken.None);
                }
                catch (Exception)
                {
                    // TODO: probably should log or handle this.....
                }
            }
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