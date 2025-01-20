using data.Models.DTO;
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
                var data = await _dataService.GetAllAsync<EventDTO>("api/Event");
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
                var data = await _dataService.GetByIdAsync<EventDTO>("api/Event", id);
                return Ok(data);
            }
            catch (Exception ex)
            {
                return StatusCode(404, $"Event not found : {ex.Message}");
            }
        }

        [HttpGet("GetInvitedUserByEvent")]
        public async Task<ActionResult<List<UserDTO>>> GetInvitedUserByEvent(int id)
        {
            try
            {
                var data = await _dataService.GetAllUserByEvent("api/Event/invite", id);
                return Ok(data);
            }
            catch (Exception ex)
            {
                return StatusCode(404, $"Event not found : {ex.Message}");
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

        [HttpPost("InviteUser")]
        public async Task<IActionResult> InviteUser(InviteDTO inviteDTO)
        {
            try
            {
                var data = await _dataService.PostInviteAsync("api/EventInvite", inviteDTO);
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
                var data = await _dataService.DeleteAsync("api/Event", id);
                return Ok(data);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Erreur : {ex.Message}");
            }
        }

        [HttpDelete("DeleteInvite")]
        public async Task<IActionResult> DeleteInvite(int id)
        {
            try
            {
                var data = await _dataService.DeleteAsync("api/EventInvite", id);
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
