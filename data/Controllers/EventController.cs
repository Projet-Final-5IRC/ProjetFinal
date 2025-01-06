using data.Models.EntityFramework;
using data.Models.Repository;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace data.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EventController : ControllerBase
    {
        private readonly IDataRepository<Events> dataRepository;

        public EventController(IDataRepository<Events> dataRepo)
        {
            dataRepository = dataRepo;
        }

        // GET: api/Events
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Events>>> GetEvent()
        {
            return await dataRepository.GetAllAsync();
        }

        // GET: api/Events/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Events>> GetEventById(int id)
        {
            var events = await dataRepository.GetByIdAsync(id);

            return events;
        }

        // PUT: api/Events/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<ActionResult<Events>> PutEvents(int id, Events eventUpdated)
        {
            if (id != eventUpdated.IdEvent)
            {
                return BadRequest();
            }

            var eventToUpdate = await dataRepository.GetByIdAsync(id);
            if (eventToUpdate.Value == null)
            {
                return NotFound();
            }
            else
            {
                var result = await dataRepository.UpdateAsync(eventToUpdate.Value, eventUpdated);
                return result;
            }
        }

        // POST: api/Events
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Events>> PostEvents(Events events)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            await dataRepository.AddAsync(events);

            return CreatedAtAction("GetEvent", new { id = events.IdEvent }, events);
        }

        // DELETE: api/Events/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteEvents(int id)
        {
            var events = await dataRepository.GetByIdAsync(id);
            if (events.Value == null)
            {
                return NotFound("Event not found!");
            }

            await dataRepository.DeleteAsync(events.Value);

            return NoContent();
        }
    }
}
