﻿
using System.Net.WebSockets;
using System.Text.Json;
using skandiahackstatehandler;
using skandiahackstatehandler.Data;
using skandiahackstatehandler.Data.Enums;
using skandiahackstatehandler.Data.Events;

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
                    var eventData = messageData.eventData;
                    try
                    {
                        InvestmentType investmentType;
                        switch (eventData.action)
                        {
                            case "joinGame":
                                State.JoinGame(
                                    messageData.sender,
                                    eventData.data.GetString()!
                                );
                                break;
                            case "updatePlayerName":
                                State.UpdatePlayerName(messageData.sender, eventData.data.GetString()!);
                                break;
                            case "fetchInvestment":
                                // TODO: Deserialize name instead of index
                                investmentType = eventData.data.Deserialize<InvestmentType>();
                                State.FetchInvestment(messageData.sender, investmentType);
                                break;
                            case "buyInvestment":
                                var investment = eventData.data.Deserialize<GameState.Investment>()!;
                                State.BuyInvestment(messageData.sender, investment);
                                break;
                            case "sellInvestment":
                                investmentType = eventData.data.Deserialize<InvestmentType>();
                                State.SellInvestment(messageData.sender, investmentType);
                                break;
                            case "generateEventCard":
                                State.DrawEventCard(messageData.sender);
                                break;
                            case "activateEventCard":
                                var eventCard = eventData.data.Deserialize<EventCard>()!;
                                State.ActivateEventCard(messageData.sender, eventCard);
                                break;
                            default:
                                _logger.LogWarning("Unhandled event type: {eventType}", eventData.action);
                                break;
                        }
                    }
                    catch (Exception ex)
                    {
                        _logger.LogError(ex, "Failed to handle event of type: {eventType} with data: {data}", eventData.action, eventData.data);
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
