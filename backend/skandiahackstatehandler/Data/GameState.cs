
namespace skandiahackstatehandler.Data;
record GameState
{
    public List<Player> players { get; init; } = new();

    public record BankAccount
    {
        public double amount { get; init; }
        public double interest { get; init; }
    }

    public record Investment
    {
        public int investmentType { get; init; }
        public double value { get; init; }
        public int quantity { get; init; }
        public double interest { get; init; }
    }

    public record Player
    {
        public string id { get; init; }
        public string name { get; init; }
        public BankAccount bankAccount { get; init; } = new();
        public List<Investment> investments { get; init; } = new();
        public List<int> scannedCodes { get; init; } = new();
    }
}