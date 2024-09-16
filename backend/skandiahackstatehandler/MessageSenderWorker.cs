
namespace skandiahackstatehandler
{
    public class MessageSenderWorker : BackgroundService
    {
        private readonly ILogger<MessageSenderWorker> _logger;

        public MessageSenderWorker(ILogger<MessageSenderWorker> logger)
        {
            _logger = logger;
        }
        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            _logger.LogInformation("Starting message sender worker");
            while (!stoppingToken.IsCancellationRequested)
            {
                if (State.OutgoingMessages.TryDequeue(out var messageData))
                {
                    var receivers = State.GetPlayerSnapshot();
                    var message = messageData.message;
                    var sendTasks = receivers
                        .Select(r =>
                        {
                            try
                            {
                                return r.SendAsync(
                                    message,
                                    System.Net.WebSockets.WebSocketMessageType.Text,
                                    true,
                                    CancellationToken.None  //TODO: consider using stoppingToken here
                                    );
                            }
                            catch (Exception)
                            {
                                //TODO: log, handle, remove faulty clients?
                                return Task.CompletedTask;
                            }
                        });
                    await Task.WhenAll(sendTasks.ToArray());
                }
                else
                {
                    await Task.Delay(100);
                }                
            }
            _logger.LogInformation("Stopping message sender worker");

        }
    }
}
