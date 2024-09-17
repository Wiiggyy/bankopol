
namespace skandiahackstatehandler.Data;
record GameState
{
    public List<Player> players { get; init; } = new();

    public record BankAccount(double amount, double interest);

    public record Investment(
        int investmentType, double value,
        int quantity, double interest);

    public record Player(string id, string name)
    {
        public BankAccount bankAccount { get; init; } = new(0, 0);
        public List<Investment> investments { get; init; } = new();
        public List<int> scannedCodes { get; init; } = new();
    }
}