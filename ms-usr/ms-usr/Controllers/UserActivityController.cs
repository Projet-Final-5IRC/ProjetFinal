using Microsoft.AspNetCore.Mvc;
using ms_usr.Models.DTO;
using ms_usr.Services;
using System;
using System.Threading.Tasks;

namespace ms_usr.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserActivityController : ControllerBase
    {
        private readonly UserActivityService _userActivityService;

        public UserActivityController(UserActivityService userActivityService)
        {
            _userActivityService = userActivityService;
        }

        // Log a user action
        [HttpPost("LogAction")]
        public async Task<IActionResult> LogUserAction([FromBody] UserActionDTO action)
        {
            var result = await _userActivityService.LogUserAction(action);

            if (!result.Success)
            {
                return BadRequest(result.Message);
            }

            return Ok(new
            {
                Message = result.Message
            });
        }

        // Get user activities by user ID
        [HttpGet("GetUserActivity/{userId}")]
        public async Task<IActionResult> GetUserActivity(int userId)
        {
            try
            {
                var userActivity = await _userActivityService.GetUserActivity(userId);

                if (userActivity == null)
                {
                    return NotFound("User activities not found.");
                }

                return Ok(userActivity);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error: {ex.Message}");
            }
        }
    }
}
