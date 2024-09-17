
using System.Text.Json;
using skandiahackstatehandler.Data;

namespace skandiahackstatehandler
{
    public class EventWorker : BackgroundService
    {
        private readonly ILogger<EventWorker> _logger;

        public EventWorker(ILogger<EventWorker> logger)
        {
            _logger = logger;
        }
        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            _logger.LogInformation("Starting event worker");
            while (!stoppingToken.IsCancellationRequested)
            {
                if (State.EventQueue.TryDequeue(out var messageData))
                {
                    try
                    {

                        switch (messageData.action)
                        {
                            case "addPlayer":
                                var newGameState = State.AddPlayerToGame(
                                    messageData.data.Deserialize<GameState.Player>()!
                                );
                                var newEvent = new OutEvent
                                {
                                    action = "newGameState",
                                    data = newGameState,
                                };
                                State.OutgoingMessages.Enqueue(newEvent);
                                break;
                            default:
                                _logger.LogWarning("Unhandled event type: {eventType}", messageData.action);
                                break;
                        }
                    }
                    catch (Exception ex)
                    {
                        _logger.LogError(ex, "Failed to handle event of type: {eventType} with data: {data}", messageData.action, messageData.data);
                    }
                }
                else
                {
                    await Task.Delay(100);
                }
            }
            _logger.LogInformation("Stopping event worker");

        }
    }
}
