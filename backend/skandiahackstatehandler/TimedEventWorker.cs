
using System.Net.WebSockets;
using System.Text.Json;
using skandiahackstatehandler;
using skandiahackstatehandler.Data;
using skandiahackstatehandler.Data.Enums;
using skandiahackstatehandler.Data.Events;

namespace skandiahackstatehandler
{
    public class TimedEventWorker : BackgroundService
    {
        private readonly ILogger<TimedEventWorker> _logger;

        public TimedEventWorker(ILogger<TimedEventWorker> logger)
        {
            _logger = logger;
        }
        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            _logger.LogInformation("Starting timed event worker");
            try
            {
                while (true)
                {
                    var now = new TimeOnly(DateTime.UtcNow.TimeOfDay.Ticks);
                    var nextEvent = timedEvents.Where(e => e.time > now).OrderBy(e => e.time).FirstOrDefault();
                    if (nextEvent == default)
                    { // TODO: sleep til´ end of day
                        await Task.Delay(1000, stoppingToken);
                    }
                    else
                    {
                        var timeToSleep = nextEvent.time - now;
                        await Task.Delay(timeToSleep, stoppingToken);

                        switch (nextEvent.eventType)
                        {
                            case "veckopeng":
                                _logger.LogInformation("Giving everyone veckopeng");
                                break;
                        }
                    }
                }
            }
            catch (OperationCanceledException)
            {
                _logger.LogInformation("Stopping timed event worker");
            }
        }

        List<(TimeOnly time, string eventType)> timedEvents = [
            (new TimeOnly(hour: 12, minute: 0), "veckopeng")
        ];
    }
}
