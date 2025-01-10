using data.Models.EntityFramework;
using data.Models.Repository;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace data.Models.DataManager
{
    public class GenresManager : IDataRepository<Genres>
    {
        readonly EventDBContext? eventDBContext;

        public GenresManager() { }
        public GenresManager(EventDBContext eventDBContext)
        {
            this.eventDBContext = eventDBContext;
        }

        public async Task<ActionResult<IEnumerable<Genres>>> GetAllAsync()
        {
            if (eventDBContext == null)
            {
                throw new ArgumentNullException(nameof(eventDBContext));
            }
            return await eventDBContext.Genre.ToListAsync();
        }

        public async Task<ActionResult<Genres>> GetByIdAsync(int id)
        {
            if (eventDBContext == null)
            {
                throw new ArgumentNullException(nameof(eventDBContext));
            }

            var genreEntity = await eventDBContext.Genre.FirstOrDefaultAsync(e => e.IdGenre == id);

            return genreEntity != null ? genreEntity : new NotFoundResult();
        }

        public async Task<ActionResult<Genres>> AddAsync(Genres newGenre)
        {
            if (eventDBContext == null)
            {
                throw new ArgumentNullException(nameof(eventDBContext));
            }

            if (newGenre == null)
            {
                return new BadRequestResult();
            }

            try
            {
                await eventDBContext.Genre.AddAsync(newGenre);
                await eventDBContext.SaveChangesAsync();
                return newGenre;
            }
            catch (Exception ex)
            {
                return new ObjectResult($"An error occurred while adding the genre: {ex.Message}")
                {
                    StatusCode = StatusCodes.Status500InternalServerError
                };
            }
        }

        public async Task<ActionResult<Genres>> UpdateAsync(Genres genreToUpdate, Genres updatedGenre)
        {
            if (eventDBContext == null)
            {
                throw new ArgumentNullException(nameof(eventDBContext));
            }

            if (updatedGenre == null && genreToUpdate == null)
            {
                return new BadRequestResult();
            }

            eventDBContext.Entry(genreToUpdate).State = EntityState.Modified;
            genreToUpdate.UpdateGenreValues(updatedGenre);

            try
            {
                await eventDBContext.SaveChangesAsync();
                return genreToUpdate;
            }
            catch (Exception ex)
            {
                return new ObjectResult($"An error occurred while updating the genre: {ex.Message}")
                {
                    StatusCode = StatusCodes.Status500InternalServerError
                };
            }
        }

        public async Task<ActionResult> DeleteAsync(Genres genreToDelete)
        {
            if (eventDBContext == null)
            {
                throw new ArgumentNullException(nameof(eventDBContext));
            }

            if (genreToDelete == null)
            {
                return new BadRequestResult();
            }

            try
            {
                eventDBContext.Genre.Remove(genreToDelete);
                await eventDBContext.SaveChangesAsync();
                return new NoContentResult();
            }
            catch (Exception ex)
            {
                return new ObjectResult($"An error occurred while deleting the genre: {ex.Message}")
                {
                    StatusCode = StatusCodes.Status500InternalServerError // Retourne un 500 Internal Server Error en cas d'exception
                };
            }
        }
    }
}
