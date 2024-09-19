using System.Text.Json;

namespace skandiahackstatehandler.Data;

public class Event
{
    required public string action { get; set; }
    required public JsonElement data { get; set; }
}

