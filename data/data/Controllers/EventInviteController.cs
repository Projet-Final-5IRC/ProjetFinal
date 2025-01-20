using data.Models.DTO;
using data.Models.EntityFramework;
using data.Models.Repository;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace data.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EventInviteController : ControllerBase
    {
        private readonly IDataRepositoryEventInvite<EventsInvite> dataRepository;

        public EventInviteController(IDataRepositoryEventInvite<EventsInvite> dataRepo)
        {
            dataRepository = dataRepo;
        }

        // GET: api/Invites
        [HttpGet]
        public async Task<ActionResult<IEnumerable<EventInviteDTO>>> GetInvites()
        {
            var result = await dataRepository.GetAllAsync();

            List<EventInviteDTO> listInvite = new List<EventInviteDTO>();

            foreach (EventsInvite invite in result.Value)
            {
                listInvite.Add(new EventInviteDTO(invite));
            }

            return listInvite;
        }

        // GET: api/Invites/5
        [HttpGet("{id}")]
        public async Task<ActionResult<EventInviteDTO>> GetInviteById(int id)
        {
            var invite = await dataRepository.GetByIdAsync(id);

            if (invite.Value == null)
            {
                return NotFound();
            }

            return new EventInviteDTO(invite.Value);
        }

        // PUT: api/Invites/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<ActionResult<EventInviteDTO>> PutInvite(int id, EventsInvite inviteUpdated)
        {
            if (id != inviteUpdated.idEventsInvite)
            {
                return BadRequest();
            }

            var inviteToUpdate = await dataRepository.GetByIdAsync(id);
            if (inviteToUpdate.Value == null)
            {
                return NotFound();
            }
            else
            {
                var result = await dataRepository.UpdateAsync(inviteToUpdate.Value, inviteUpdated);
                return new EventInviteDTO(result.Value);
            }
        }

        // POST: api/Invites
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<EventInviteDTO>> PostInvite(EventsInvite invite)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var existingInvite = await dataRepository
                                        .GetAllAsync()
                                        .ContinueWith(task => task.Result.Value.FirstOrDefault(e => e.IdEvent == invite.IdEvent && e.IdUser == invite.IdUser));

            if (existingInvite != null)
            {
                return Conflict(new { message = "L'utilisateur est déjà invité à cet événement." });
            }

            await dataRepository.AddAsync(invite);

            return CreatedAtAction("GetInviteById", new { id = invite.idEventsInvite }, new EventInviteDTO(invite));
        }

        // DELETE: api/Invites/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteInvite(int id)
        {

            var invite = await dataRepository.GetByIdAsync(id);
            if (invite.Value == null)
            {
                return NotFound("Invite not found!");
            }

            await dataRepository.DeleteAsync(invite.Value);

            return NoContent();
        }

        [HttpDelete("event/{idEvent}/user/{username}")]
        public async Task<IActionResult> DeleteInviteByEventAndUser(int idEvent, string username)
        {
            var user = await dataRepository.GetByUsernameAsync(username);
            if (user.Value == null)
            {
                return NotFound($"Utilisateur avec le nom '{username}' introuvable.");
            }

            var invite = await dataRepository
                .GetAllAsync()
                .ContinueWith(task => task.Result.Value
                    .FirstOrDefault(e => e.IdEvent == idEvent && e.IdUser == user.Value.IdUser));

            if (invite == null)
            {
                return NotFound("Invitation non trouvée pour cet événement et cet utilisateur.");
            }

            await dataRepository.DeleteAsync(invite);

            return NoContent();
        }
    }
}
