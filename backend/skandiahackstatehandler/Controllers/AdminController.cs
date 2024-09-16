using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace skandiahackstatehandler.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AdminController : ControllerBase
    {
        // GET: api/<AdminController>
        [HttpPost("WipeDate")]
        public void Wipe()
        {
            State.WipeData();
            return;
        }

        [HttpPost("applyinterest")]
        public async Task ApplyInterest()
        {
            await State.ApplyInterestAndInformClients();
        }

    }
}
