using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ms_evt.Models.DTO;
using ms_evt.Services;
using Newtonsoft.Json;
using System.Text.Json.Nodes;

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

        [HttpGet("GetAllEvents")]
        public async Task<IActionResult> GetEvents()
        {
            try
            {
                var data = await _dataService.GetEventsAsync("api/Event");
                return Ok(data);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Erreur : {ex.Message}");
            }
        }

        [HttpGet("GetEventById")]
        public async Task<IActionResult> GetEventById(int id)
        {
            try
            {
                var data = await _dataService.GetEventByIdAsync("api/Event", id);
                return Ok(data);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Erreur : {ex.Message}");
            }
        }

        [HttpPost("AddEvent")]
        public async Task<IActionResult> PostEvent(EventDTO eventDTO)
        {
            try
            {
                var data = await _dataService.PostEventAsync("api/Event", eventDTO);
                return Ok(data);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Erreur : {ex.Message}");
            }
        }

        [HttpDelete("DeleteEvent")]
        public async Task<IActionResult> DeleteEvent(int id)
        {
            try
            {
                var data = await _dataService.DeleteEventAsync("api/Event", id);
                return Ok(data);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Erreur : {ex.Message}");
            }
        }

        [HttpPut("EditEvent")]
        public async Task<IActionResult> EditEvent(int id, EventDTO eventDTO)
        {
            try
            {
                var data = await _dataService.PutEventAsync("api/Event", id, eventDTO);
                return Ok(data);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Erreur : {ex.Message}");
            }
        }
    }
}
