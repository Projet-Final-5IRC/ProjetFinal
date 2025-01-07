using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ms_evt.Models.DTO;
using ms_evt.Services;

namespace ms_evt.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EventController : ControllerBase
    {
        private readonly DataService _dataService;

        public EventController(DataService dataService)
        {
            _dataService = dataService;
        }

        [HttpGet("GetEvent")]
        public async Task<IActionResult> GetEvent()
        {
            try
            {
                var data = await _dataService.GetEventAsync<EventDTO>("api/Event");
                return Ok(data);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Erreur : {ex.Message}");
            }
        }
    }
}
