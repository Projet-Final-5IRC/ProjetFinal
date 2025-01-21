using data.Models.EntityFramework;
using data.Models.Repository;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace data.Models.DataManager
{
    public class EventsInviteManager : IDataRepositoryEventInvite<EventsInvite>
    {
        readonly EventDBContext? eventDBContext;

        public EventsInviteManager() { }
        public EventsInviteManager(EventDBContext eventDBContext)
        {
            this.eventDBContext = eventDBContext;
        }

        public async Task<ActionResult<IEnumerable<EventsInvite>>> GetAllAsync()
        {
            if (eventDBContext == null)
            {
                throw new ArgumentNullException(nameof(eventDBContext));
            }
            return await eventDBContext.EventInvite.ToListAsync();
        }

        public async Task<ActionResult<EventsInvite>> GetByIdAsync(int id)
        {
            if (eventDBContext == null)
            {
                throw new ArgumentNullException(nameof(eventDBContext));
            }

            var eventInviteEntity = await eventDBContext.EventInvite
                                            .FirstOrDefaultAsync(e => e.idEventsInvite == id);

            return eventInviteEntity != null ? eventInviteEntity : new NotFoundResult();
        }

        public async Task<ActionResult<Users>> GetByUserIdAsync(int idUser)
        {
            if (eventDBContext == null)
            {
                throw new ArgumentNullException(nameof(eventDBContext));
            }

            var userEntity = await eventDBContext.User.FirstOrDefaultAsync(e => e.IdUser == idUser);

            return userEntity != null ? userEntity : new NotFoundResult();
        }

        public async Task<ActionResult<EventsInvite>> AddAsync(EventsInvite newInvite)
        {
            if (eventDBContext == null)
            {
                throw new ArgumentNullException(nameof(eventDBContext));
            }

            if (newInvite == null)
            {
                return new BadRequestResult();
            }

            try
            {
                await eventDBContext.EventInvite.AddAsync(newInvite);
                await eventDBContext.SaveChangesAsync();
                return newInvite;
            }
            catch (Exception ex)
            {
                return new ObjectResult($"An error occurred while adding the invitation: {ex.Message}")
                {
                    StatusCode = StatusCodes.Status500InternalServerError
                };
            }
        }

        public async Task<ActionResult<EventsInvite>> UpdateAsync(EventsInvite inviteToUpdate, EventsInvite updatedInvite)
        {
            if (eventDBContext == null)
            {
                throw new ArgumentNullException(nameof(eventDBContext));
            }

            if (updatedInvite == null && inviteToUpdate == null)
            {
                return new BadRequestResult();
            }

            eventDBContext.Entry(inviteToUpdate).State = EntityState.Modified;
            inviteToUpdate.UpdateInviteValues(updatedInvite);

            try
            {
                await eventDBContext.SaveChangesAsync();
                return inviteToUpdate;
            }
            catch (Exception ex)
            {
                return new ObjectResult($"An error occurred while updating the invite: {ex.Message}")
                {
                    StatusCode = StatusCodes.Status500InternalServerError
                };
            }
        }

        public async Task<ActionResult> DeleteAsync(EventsInvite inviteToDelete)
        {
            if (eventDBContext == null)
            {
                throw new ArgumentNullException(nameof(eventDBContext));
            }

            if (inviteToDelete == null)
            {
                return new BadRequestResult();
            }

            try
            {
                eventDBContext.EventInvite.Remove(inviteToDelete);
                await eventDBContext.SaveChangesAsync();
                return new NoContentResult();
            }
            catch (Exception ex)
            {
                return new ObjectResult($"An error occurred while deleting the invite: {ex.Message}")
                {
                    StatusCode = StatusCodes.Status500InternalServerError // Retourne un 500 Internal Server Error en cas d'exception
                };
            }
        }
    }
}
