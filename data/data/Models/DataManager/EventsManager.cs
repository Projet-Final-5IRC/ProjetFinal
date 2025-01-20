using data.Models.DTO;
using data.Models.EntityFramework;
using data.Models.Repository;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System.Security.Cryptography.X509Certificates;

namespace data.Models.DataManager
{
    public class EventsManager : IDataRepository<Events>
    {
        readonly EventDBContext? eventDBContext;
        public EventsManager() { }
        public EventsManager(EventDBContext eventDBContext)
        {
            this.eventDBContext = eventDBContext;
        }

        public async Task<ActionResult<IEnumerable<Events>>> GetAllAsync()
        {
            if (eventDBContext == null)
            {
                throw new ArgumentNullException(nameof(eventDBContext));
            }
            return await eventDBContext.Event.ToListAsync();
        }

        public async Task<ActionResult<Events>> GetByIdAsync(int id)
        {
            if (eventDBContext == null)
            {
                throw new ArgumentNullException(nameof(eventDBContext));
            }

            var eventEntity = await eventDBContext.Event.FirstOrDefaultAsync(e => e.IdEvent == id);
            Console.WriteLine(eventEntity);

            return eventEntity != null ? eventEntity : new NotFoundResult();
        }

        public async Task<ActionResult<Events>> AddAsync(Events newEvent)
        {
            if (eventDBContext == null)
            {
                throw new ArgumentNullException(nameof(eventDBContext));
            }

            if (newEvent == null)
            {
                return new BadRequestResult();
            }

            try
            {
                await eventDBContext.Event.AddAsync(newEvent);
                await eventDBContext.SaveChangesAsync();
                return newEvent;
            }
            catch (Exception ex)
            {
                return new ObjectResult($"An error occurred while adding the event: {ex.Message}")
                {
                    StatusCode = StatusCodes.Status500InternalServerError
                };
            }
        }

        public async Task<ActionResult<Events>> UpdateAsync(Events eventToUpdate, Events updatedEvent)
        {
            if (eventDBContext == null)
            {
                throw new ArgumentNullException(nameof(eventDBContext));
            }

            if (updatedEvent == null && eventToUpdate == null)
            {
                return new BadRequestResult();
            }

            eventDBContext.Entry(eventToUpdate).State = EntityState.Modified;
            eventToUpdate.UpdateEventValues(updatedEvent);

            try
            {
                await eventDBContext.SaveChangesAsync();
                return eventToUpdate;
            }
            catch (Exception ex)
            {
                return new ObjectResult($"An error occurred while updating the event: {ex.Message}")
                {
                    StatusCode = StatusCodes.Status500InternalServerError
                };
            }
        }

        public async Task<ActionResult> DeleteAsync(Events eventToDelete)
        {
            if (eventDBContext == null)
            {
                throw new ArgumentNullException(nameof(eventDBContext));
            }

            if(eventToDelete == null)
            {
                return new BadRequestResult();
            }

            try
            {
                eventDBContext.Event.Remove(eventToDelete);
                await eventDBContext.SaveChangesAsync();
                return new NoContentResult();
            }
            catch (Exception ex)
            {
                return new ObjectResult($"An error occurred while deleting the event: {ex.Message}")
                {
                    StatusCode = StatusCodes.Status500InternalServerError // Retourne un 500 Internal Server Error en cas d'exception
                };
            }
        }
    }
}
