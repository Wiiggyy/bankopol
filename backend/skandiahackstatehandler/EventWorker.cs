
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
            _logger.LogInformation("Starting message sender worker");
            while (!stoppingToken.IsCancellationRequested)
            {
                if (State.EventQueue.TryDequeue(out var messageData))
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
                    }
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
