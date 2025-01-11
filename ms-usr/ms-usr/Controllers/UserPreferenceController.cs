using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Diagnostics;
using ms_usr.Services;

namespace ms_usr.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserPreferenceController : ControllerBase
    {
        private readonly DataService _dataService;

        public UserPreferenceController(DataService dataService)
        {
            _dataService = dataService;
        }

        [HttpGet("GetPrefereneceByUserId")]
        public async Task<IActionResult> GetPreferenceByUserId(int id)
        {
            try
            {
                var data = await _dataService.GetAllUserPreferences("api/Preference",id);
                return Ok(data);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Erreur : {ex.Message}");
            }
        }
    }
}
