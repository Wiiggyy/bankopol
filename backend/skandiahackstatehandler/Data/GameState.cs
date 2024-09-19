
using System.Collections.Immutable;
using skandiahackstatehandler.Data.Enums;

namespace skandiahackstatehandler.Data;
record GameState
{
    required public Player player { get; init; }
    required public ImmutableDictionary<string, double> highScore { get; init; }

    public record BankAccount(double amount, double interest);

    public record Investment(
        InvestmentType investmentType,
        double value,
        int quantity,
        double interest
        );

    public record Player(string id, string name)
    {
        required public BankAccount bankAccount { get; init; } = new(0, 0);
        public ImmutableList<Investment> investments { get; init; } = [];
        public ImmutableList<int> scannedCodes { get; init; } = [];

        public double totalAssetsValue
        {
            get
            {
                var total = bankAccount.amount;
                foreach (var investment in investments)
                {
                    total += investment.value;
                }
                return total;
            }
        }
    }
}

record InternalGameState
{
    public ImmutableList<GameState.Player> players { get; init; } = [];

    public GameState ForPlayer(string id)
    {
        Dictionary<string, double> highScore = new();

        foreach (var player in players)
        {
            highScore.Add(player.name, player.totalAssetsValue);
        }

        return new GameState
        {
            player = players.First((player) => player.id == id),
            highScore = highScore.ToImmutableDictionary(),
        };
    }
}