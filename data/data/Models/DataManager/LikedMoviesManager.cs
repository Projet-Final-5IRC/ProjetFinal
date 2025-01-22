using data.Models.DTO;
using data.Models.EntityFramework;
using data.Models.Repository;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace data.Models.DataManager
{
    public class LikedMoviesManager : IDataRepositoryWithMovies<LikedMovies>
    {

        readonly EventDBContext? eventDBContext;

        public LikedMoviesManager(EventDBContext eventDBContext)
        {
            this.eventDBContext = eventDBContext;
        }


        public async Task<ActionResult<LikedMovies>> AddAsync(LikedMovies entity)
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
                var verif = eventDBContext.LikedMovies.FirstOrDefault(e => e.IdTmdbMovie == entity.IdTmdbMovie && e.IdUser == entity.IdUser);
                if (verif == null)
                {
                    await eventDBContext.LikedMovies.AddAsync(entity);
                    await eventDBContext.SaveChangesAsync();
                    return entity;
                }
                else
                {
                    return new ObjectResult($"Liked Movie already present in db !")
                    {
                        StatusCode = StatusCodes.Status500InternalServerError
                    };
                }
            }
            catch (Exception ex)
            {
                return new ObjectResult($"An error occurred while adding the Liked Movie: {ex.Message}")
                {
                    StatusCode = StatusCodes.Status500InternalServerError
                };
            }
        }

        public async Task<ActionResult> DeleteAsync(LikedMovies entity)
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
                eventDBContext.LikedMovies.Remove(entity);
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
                var entity = await eventDBContext.LikedMovies.FirstOrDefaultAsync(e => e.IdUser == IdUser && e.IdTmdbMovie == movieTmdbId);
                eventDBContext.LikedMovies.Remove(entity);
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

        public async Task<ActionResult<IEnumerable<LikedMovies>>> GetAllAsync()
        {
            if (eventDBContext == null)
            {
                throw new NullReferenceException(nameof(eventDBContext));
            }
            try
            {
                return await eventDBContext.LikedMovies.ToListAsync();
            }
            catch (Exception ex)
            {
                return new ObjectResult($"An error occurred while deleting the preference: {ex.Message}")
                {
                    StatusCode = StatusCodes.Status500InternalServerError
                };
            }
        }

        public async Task<ActionResult<LikedMovies>> GetByIdAsync(int id)
        {
            if (eventDBContext == null)
            {
                throw new NullReferenceException(nameof(eventDBContext));
            }

            try
            {
                var result = await eventDBContext.LikedMovies.FirstOrDefaultAsync(e => e.IdLikedMovies == id);
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

        public async Task<List<LikedMovies>> GetMoviesByUserId(int IdUser)
        {
            if (eventDBContext == null)
            {
                throw new NullReferenceException(nameof(eventDBContext));
            }

            return await eventDBContext.LikedMovies.Where(e => e.IdUser == IdUser).ToListAsync();
        }

        public async Task<ActionResult<LikedMovies>> UpdateAsync(LikedMovies entityToUpdate, LikedMovies entityUpdated)
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
            entityToUpdate.UpdateLikeMovieValue(entityUpdated);

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
