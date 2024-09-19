using System.Text.Json;

namespace skandiahackstatehandler.Data;

public record OutEvent
{
    required public string action { get; init; }
    required public object data { get; init; }
}
