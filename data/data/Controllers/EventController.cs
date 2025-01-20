using data.Models.DTO;
using data.Models.EntityFramework;
using data.Models.Repository;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics.CodeAnalysis;

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
        public async Task<ActionResult<IEnumerable<EventDTO>>> GetEvent()
        {

            var result = await dataRepository.GetAllAsync();

            List<EventDTO> listEvents = new List<EventDTO>();

            foreach (Events events in result.Value)
            {
                listEvents.Add(new EventDTO(events));
            }

            return listEvents;
        }

        // GET: api/Events/5
        [HttpGet("{id}")]
        public async Task<ActionResult<EventDTO>> GetEventById(int id)
        {
            var events = await dataRepository.GetByIdAsync(id);

            if(events.Value == null)
            {
                return NotFound();
            }
            return new EventDTO(events.Value);
        }

        // PUT: api/Events/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<ActionResult<EventDTO>> PutEvents(int id, Events eventUpdated)
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
                await dataRepository.UpdateAsync(eventToUpdate.Value, eventUpdated);

                var result = await dataRepository.GetByIdAsync(eventToUpdate.Value.IdEvent);
                return new EventDTO(result.Value);
            }
        }

        // POST: api/Events
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<EventDTO>> PostEvents(Events eventDTO)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            await dataRepository.AddAsync(eventDTO);

            return CreatedAtAction("GetEventById", new { id = eventDTO.IdEvent }, eventDTO);
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
