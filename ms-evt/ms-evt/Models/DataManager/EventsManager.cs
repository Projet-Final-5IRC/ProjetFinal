using data.Models.EntityFramework;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ms_evt.Models.Repository;

namespace ms_evt.Models.DataManager
{
    public class EventsManager : IDataRepository<Events>
    {
        readonly EventDBContext? eventDBContext;
        public EventsManager() { }
        public EventsManager(EventDBContext context)
        {
            this.eventDBContext = context;
        }

        public async Task<ActionResult<IEnumerable<Events>>> GetAllAsync()
        {
                return await eventDBContext.Event.ToListAsync();
        }

        public async Task<ActionResult<Events>> GetByIdAsync(int id)
        {
            return await eventDBContext.Event.FirstOrDefaultAsync(e => e.IdEvent == id);
        }

        public async Task AddAsync(Events entity)
        {
            await eventDBContext.Event.AddAsync(entity);
            await eventDBContext.SaveChangesAsync();
        }

        public async Task UpdateAsync(Events events, Events entity)
        {
            eventDBContext.Entry(events).State = EntityState.Modified;
            events.EventName = entity.EventName;
            events.EventDescription = entity.EventDescription;
            events.EventDate = entity.EventDate;
            events.EventHour = entity.EventHour;
            events.EventLocation = entity.EventLocation;
            events.EventInvitation = entity.EventInvitation;
            events.IdGenre = entity.IdGenre;
            events.GenreEvent = entity.GenreEvent;

            eventDBContext.SaveChanges();
        }

        public async Task DeleteAsync(Events events)
        {
            eventDBContext.Event.Remove(events);
            await eventDBContext.SaveChangesAsync();
        }
    }
}
