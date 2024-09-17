using System.Text.Json;

namespace skandiahackstatehandler.Data;

public class Event
{
    public string action { get; set; }
    public JsonElement data { get; set; }
}

