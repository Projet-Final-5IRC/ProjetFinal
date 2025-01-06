using data.Models.EntityFramework;
using data.Models.Repository;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace data.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class GenreController : ControllerBase
    {
        private readonly IDataRepository<Genres> dataRepository;

        public GenreController(IDataRepository<Genres> dataRepo)
        {
            dataRepository = dataRepo;
        }

        // GET: api/Genres
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Genres>>> GetGenres()
        {
            return await dataRepository.GetAllAsync();
        }

        // GET: api/Genres/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Genres>> GetGenreById(int id)
        {
            var genre = await dataRepository.GetByIdAsync(id);

            return genre;
        }

        // PUT: api/Genres/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<ActionResult<Genres>> PutGenres(int id, Genres genreUpdated)
        {
            if (id != genreUpdated.IdGenre)
            {
                return BadRequest();
            }

            var genreToUpdate = await dataRepository.GetByIdAsync(id);
            if (genreToUpdate.Value == null)
            {
                return NotFound();
            }
            else
            {
                var result = await dataRepository.UpdateAsync(genreToUpdate.Value, genreUpdated);
                return result;
            }
        }

        // POST: api/Genres
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Genres>> PostGenre(Genres genre)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            await dataRepository.AddAsync(genre);

            return CreatedAtAction("GetGenres", new { id = genre.IdGenre }, genre);
        }

        // DELETE: api/Genre/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteGenre(int id)
        {
            var genre = await dataRepository.GetByIdAsync(id);
            if (genre.Value == null)
            {
                return NotFound("Genre not found!");
            }

            await dataRepository.DeleteAsync(genre.Value);

            return NoContent();
        }
    }
}
