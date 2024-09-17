using System.Text.Json;

namespace skandiahackstatehandler.Data.Events;

public class RenamePlayerEvent
{
    required public string id { get; init; }
    required public string name { get; init; }
}

