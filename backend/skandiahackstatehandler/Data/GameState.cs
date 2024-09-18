
using skandiahackstatehandler.Data.Enums;

namespace skandiahackstatehandler.Data;
record GameState
{
    required public Player player { get; init; }

    public record BankAccount(double amount, double interest);

    public record Investment(
        InvestmentType investmentType, double value,
        int quantity, double interest
        );

    public record Player(string id, string name)
    {
        public BankAccount bankAccount { get; init; } = new(0, 0);
        public List<Investment> investments { get; init; } = [];
        public List<int> scannedCodes { get; init; } = [];
    }
}

record InternalGameState
{
    public List<GameState.Player> players { get; init; } = [];
}