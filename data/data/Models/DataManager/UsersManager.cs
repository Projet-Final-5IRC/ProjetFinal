using data.Models.DTO;
using data.Models.EntityFramework;
using data.Models.Repository;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace data.Models.DataManager
{
    public class UsersManager : IDataRepositoryWithEmail<Users>
    {
        readonly EventDBContext? eventDBContext;

        public UsersManager() { }
        public UsersManager(EventDBContext eventDBContext)
        {
            this.eventDBContext = eventDBContext;
        }

        public async Task<ActionResult<IEnumerable<Users>>> GetAllAsync()
        {
            if (eventDBContext == null)
            {
                throw new ArgumentNullException(nameof(eventDBContext));
            }
            return await eventDBContext.User.ToListAsync();
        }

        public async Task<ActionResult<Users>> GetByIdAsync(int id)
        {
            if (eventDBContext == null)
            {
                throw new ArgumentNullException(nameof(eventDBContext));
            }

            var userEntity = await eventDBContext.User.FirstOrDefaultAsync(e => e.IdUser == id);

            return userEntity != null ? userEntity : new NotFoundResult();
        }

        public async Task<ActionResult<Users>> GetByEmailAsync(string email)
        {
            if (eventDBContext == null)
            {
                throw new ArgumentNullException(nameof(eventDBContext));
            }

            var userEntity = await eventDBContext.User.FirstOrDefaultAsync(e => e.Email == email);

            return userEntity != null ? userEntity : new NotFoundResult();
        }

        public async Task<ActionResult<Users>> GetByUsernameAsync(string username)
        {
            if (eventDBContext == null)
            {
                throw new ArgumentNullException(nameof(eventDBContext));
            }

            var userEntity = await eventDBContext.User.FirstOrDefaultAsync(e => e.UserName == username);

            return userEntity != null ? userEntity : new NotFoundResult();
        }

        public async Task<ActionResult<Users>> AddAsync(Users newUser)
        {
            if (eventDBContext == null)
            {
                throw new ArgumentNullException(nameof(eventDBContext));
            }

            if (newUser == null)
            {
                return new BadRequestResult();
            }

            try
            {
                await eventDBContext.User.AddAsync(newUser);
                await eventDBContext.SaveChangesAsync();
                return newUser;
            }
            catch (Exception ex)
            {
                return new ObjectResult($"An error occurred while adding the user: {ex.Message}")
                {
                    StatusCode = StatusCodes.Status500InternalServerError
                };
            }
        }

        public async Task<ActionResult<Users>> UpdateAsync(Users userToUpdate, Users updatedUser) 
        { 
            if (eventDBContext == null)
            {
                throw new ArgumentNullException(nameof(eventDBContext));
            }

            if (updatedUser == null && userToUpdate == null)
            {
                return new BadRequestResult();
            }

            eventDBContext.Entry(userToUpdate).State = EntityState.Modified;
            userToUpdate.UpdateUserValues(updatedUser);

            try
            {
                await eventDBContext.SaveChangesAsync();
                return userToUpdate;
            }
            catch (Exception ex)
            {
                return new ObjectResult($"An error occurred while updating the user: {ex.Message}")
                {
                    StatusCode = StatusCodes.Status500InternalServerError
                };
            }
        }

        public async Task<ActionResult> DeleteAsync(Users userToDelete)
        {
            if (eventDBContext == null)
            {
                throw new ArgumentNullException(nameof(eventDBContext));
            }

            if (userToDelete == null)
            {
                return new BadRequestResult();
            }

            try
            {
                eventDBContext.User.Remove(userToDelete);
                await eventDBContext.SaveChangesAsync();
                return new NoContentResult();
            }
            catch (Exception ex)
            {
                return new ObjectResult($"An error occurred while deleting the user: {ex.Message}")
                {
                    StatusCode = StatusCodes.Status500InternalServerError
                };
            }
        }
    }
}
