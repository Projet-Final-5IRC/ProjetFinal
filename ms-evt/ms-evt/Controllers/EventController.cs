using data.Models.DTO;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ms_evt.Models.Data;
using ms_evt.Models.DTO;
using ms_evt.Services;
using Newtonsoft.Json;
using System.Net;
using System.Text.Json.Nodes;

namespace ms_evt.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EventController : ControllerBase
    {
        private readonly DataService _dataService;
        private readonly IMailService _mailService;

        public EventController(DataService dataService, IMailService mailService)
        {
            _dataService = dataService;
            _mailService = mailService;
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
                //Compte de démo pour le mail donc le mail maxime.brossard5@gmail.com est renseigné en dur.
                if (data != HttpStatusCode.Conflict)
                {
                    var user = await _dataService.GetByIdAsync<UserDTO>("api/User", inviteDTO.IdUser);
                    var events = await _dataService.GetByIdAsync<EventDTO>("api/Event", inviteDTO.IdEvent);
                    var eventOwner = await _dataService.GetByIdAsync<UserDTO>("api/User", events.IdUser);
                    MailData mail = new MailData("maxime.brossard5@gmail.com", $"{user.UserName}", $"{eventOwner.UserName} has invited {user.UserName} to {events.eventName} !", $"{user.UserName} is invited to {events.eventName} who takes place the {events.eventDate} {events.eventHour} at {events.eventLocation}");
                    _mailService.SendMail(mail);
                    return Ok(data);
                }else
                {
                    return Conflict("Invitation already exist");
                }
                
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

        [HttpDelete("DeleteInviteByUsername")]
        public async Task<IActionResult> DeleteInviteByUsername(int id,int idUser)
        {
            try
            {
                var data = await _dataService.DeleteAsyncUsername($"/api/EventInvite/event/{id}/user/{idUser}");
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

        [HttpPut("JoinEvent")]
        public async Task<IActionResult> JoinEvent(int idUser, int idEvent)
        {
            try
            {
                var data = await _dataService.PutStateOfEvent($"api/EventInvite/update/{idEvent}/user/{idUser}");
                return Ok(data);
            }
            catch(Exception ex)
            {
                return StatusCode(500, $"Erreur : {ex.Message}");
            }
        }

        [HttpGet("GetEventJoinedByUser")]
        public async Task<IActionResult> GetEventJoinedByUser (int idUser)
        {
            try
            {
                var data = await _dataService.GetAllAsync<EventDTO>($"api/EventInvite/invited/{idUser}");
                return Ok(data);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Erreur : {ex.Message}");
            }
        }
    }
}
