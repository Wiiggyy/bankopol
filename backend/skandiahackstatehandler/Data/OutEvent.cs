using System.Text.Json;

namespace skandiahackstatehandler.Data;

public class OutEvent
{
    required public string action { get; set; }
    required public object data { get; set; }
}
