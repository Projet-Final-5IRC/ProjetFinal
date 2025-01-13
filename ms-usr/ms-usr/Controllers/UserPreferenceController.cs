using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Diagnostics;
using ms_usr.Models.DTO;
using ms_usr.Services;
using System.Net;

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

        [HttpPost("PostPreferenceToUser")]
        public async Task<IActionResult> PostPreferenceToUser(List<PreferenceDTO> preferences)
        {

            if (preferences == null)
            {
                return BadRequest("No PreferenceDTO Input");
            }
            try
            {
                var data = await _dataService.PostUserPreferences("api/Preference/PostUserPreference", preferences);
                if (data.StatusCode == HttpStatusCode.Created)
                {
                    return Ok(data.Data);
                }
                else
                {
                    return BadRequest(data.ErrorMessage);
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}
