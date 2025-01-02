using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using data.Models.EntityFramework;
using ms_evt.Models.Repository;

namespace ms_evt.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EventsController : ControllerBase
    {
        private readonly IDataRepository<Events> dataRepository;

        public EventsController(IDataRepository<Events> dataRepo)
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

            if (events == null)
            {
                return NotFound();
            }

            return events;
        }

        // PUT: api/Events/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutEvents(int id, Events events)
        {
            if (id != events.IdEvent)
            {
                return BadRequest();
            }

            var eventToUpdate = dataRepository.GetByIdAsync(id);
            if (eventToUpdate == null)
            {
                return NotFound();
            }
            else
            {
                await dataRepository.UpdateAsync(eventToUpdate.Result.Value, events);
                return NoContent();
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

            return CreatedAtAction("GetEvents", new { id = events.IdEvent }, events);
        }

        // DELETE: api/Events/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteEvents(int id)
        {
            var events = await dataRepository.GetByIdAsync(id);
            if (events == null)
            {
                return NotFound("Event not found!");
            }

            dataRepository.DeleteAsync(events.Value);

            return NoContent();
        }
    }
}
