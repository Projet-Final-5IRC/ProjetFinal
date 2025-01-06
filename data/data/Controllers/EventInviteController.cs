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
        private readonly IDataRepository<EventsInvite> dataRepository;

        public EventInviteController(IDataRepository<EventsInvite> dataRepo)
        {
            dataRepository = dataRepo;
        }

        // GET: api/Invites
        [HttpGet]
        public async Task<ActionResult<IEnumerable<EventsInvite>>> GetInvites()
        {
            return await dataRepository.GetAllAsync();
        }

        // GET: api/Invites/5
        [HttpGet("{id}")]
        public async Task<ActionResult<EventsInvite>> GetInviteById(int id)
        {
            var invite = await dataRepository.GetByIdAsync(id);

            return invite;
        }

        // PUT: api/Invites/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<ActionResult<EventsInvite>> PutInvite(int id, EventsInvite inviteUpdated)
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
                return result;
            }
        }

        // POST: api/Invites
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<EventsInvite>> PostInvite(EventsInvite invite)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            await dataRepository.AddAsync(invite);

            return CreatedAtAction("GetInvites", new { id = invite.idEventsInvite }, invite);
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
    }
}
