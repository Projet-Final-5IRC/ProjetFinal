using data.Models.DTO;
using data.Models.EntityFramework;
using data.Models.Repository;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace data.Models.DataManager
{
    public class SeenMoviesManager : IDataRepositoryWithMovies<SeenMovies>
    {

        readonly EventDBContext? eventDBContext;

        public SeenMoviesManager(EventDBContext eventDBContext)
        {
            this.eventDBContext = eventDBContext;
        }


        public async Task<ActionResult<SeenMovies>> AddAsync(SeenMovies entity)
        {
            if (eventDBContext == null)
            {
                throw new NullReferenceException(nameof(eventDBContext));
            }
            if (entity == null)
            {
                return new BadRequestResult();
            }

            try
            {
                await eventDBContext.SeenMovies.AddAsync(entity);
                await eventDBContext.SaveChangesAsync();
                return entity;
            }
            catch (Exception ex)
            {
                return new ObjectResult($"An error occurred while adding the preference: {ex.Message}")
                {
                    StatusCode = StatusCodes.Status500InternalServerError
                };
            }
        }

        public async Task<ActionResult> DeleteAsync(SeenMovies entity)
        {
            if (eventDBContext == null)
            {
                throw new NullReferenceException(nameof(eventDBContext));
            }
            if (entity == null)
            {
                return new BadRequestResult();
            }

            try
            {
                eventDBContext.SeenMovies.Remove(entity);
                await eventDBContext.SaveChangesAsync();
                return new NoContentResult();
            }
            catch (Exception ex)
            {
                return new ObjectResult($"An error occurred while deleting the preference: {ex.Message}")
                {
                    StatusCode = StatusCodes.Status500InternalServerError
                };
            }
        }

        public async Task<ActionResult> DeleteMoviesByUserAndMovieId(int IdUser, int movieTmdbId)
        {
            if (eventDBContext == null)
            {
                throw new NullReferenceException(nameof(eventDBContext));
            }
            if (IdUser == null && movieTmdbId == null)
            {
                return new BadRequestResult();
            }

            try
            {
                var entity = await eventDBContext.SeenMovies.FirstOrDefaultAsync(e => e.IdUser == IdUser && e.IdTmdbMovie == movieTmdbId);
                eventDBContext.SeenMovies.Remove(entity);
                await eventDBContext.SaveChangesAsync();
                return new NoContentResult();
            }
            catch (Exception ex)
            {
                return new ObjectResult($"An error occurred while deleting the preference: {ex.Message}")
                {
                    StatusCode = StatusCodes.Status500InternalServerError
                };
            }
        }

        public async Task<ActionResult<IEnumerable<SeenMovies>>> GetAllAsync()
        {
            if (eventDBContext == null)
            {
                throw new NullReferenceException(nameof(eventDBContext));
            }
            try
            {
                return await eventDBContext.SeenMovies.ToListAsync();
            }
            catch (Exception ex)
            {
                return new ObjectResult($"An error occurred while deleting the preference: {ex.Message}")
                {
                    StatusCode = StatusCodes.Status500InternalServerError
                };
            }
        }

        public async Task<ActionResult<SeenMovies>> GetByIdAsync(int id)
        {
            if (eventDBContext == null)
            {
                throw new NullReferenceException(nameof(eventDBContext));
            }

            try
            {
                var result = await eventDBContext.SeenMovies.FirstOrDefaultAsync(e => e.IdSeenMovies == id);
                return result != null ? result : new NotFoundResult();
            }
            catch (Exception ex)
            {
                return new ObjectResult($"An error occurred while deleting the preference: {ex.Message}")
                {
                    StatusCode = StatusCodes.Status500InternalServerError
                };
            }
        }

        public async Task<List<SeenMovies>> GetMoviesByUserId(int IdUser)
        {
            if (eventDBContext == null)
            {
                throw new NullReferenceException(nameof(eventDBContext));
            }

            return await eventDBContext.SeenMovies.Where(e => e.IdUser == IdUser).ToListAsync();
        }

        public async Task<ActionResult<SeenMovies>> UpdateAsync(SeenMovies entityToUpdate, SeenMovies entityUpdated)
        {
            if (eventDBContext == null)
            {
                throw new NullReferenceException(nameof(eventDBContext));
            }

            if (entityUpdated == null && entityToUpdate == null)
            {
                return new BadRequestResult();
            }

            eventDBContext.Entry(entityToUpdate).State = EntityState.Modified;
            entityToUpdate.UpdateSeenMovieValue(entityUpdated);

            try
            {
                await eventDBContext.SaveChangesAsync();
                return entityToUpdate;
            }
            catch (Exception ex)
            {
                return new ObjectResult($"An error occurred while updating the preference: {ex.Message}")
                {
                    StatusCode = StatusCodes.Status500InternalServerError
                };
            }
        }
    }
}
