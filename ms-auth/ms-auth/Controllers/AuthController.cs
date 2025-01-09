using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ms_auth.Models.DTO;
using ms_auth.Services;
using System.Net;

namespace ms_auth.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly DataService _dataService;

        public AuthController(DataService dataService)
        {
            _dataService = dataService;
        }

        [HttpPost("register")]
        public async Task<IActionResult> RegisterUser(UserDTO userDTO)
        {
            if (userDTO == null)
            {
                return BadRequest("No UserDTO Input");
            }
            try
            {
                var data = await _dataService.PostUserAsync("/api/User", userDTO);
                if (data.Item1 == HttpStatusCode.Created)
                {
                    return Ok("["+data.Item2+"]");
                }
                else
                {
                    return BadRequest(data.Item2);
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}
