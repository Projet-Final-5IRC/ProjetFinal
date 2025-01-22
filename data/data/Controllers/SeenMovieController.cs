using data.Models.DTO;
using data.Models.EntityFramework;
using data.Models.Repository;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace data.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SeenMovieController : ControllerBase
    {
        private readonly IDataRepositoryWithMovies<SeenMovies> dataRepository;

        public SeenMovieController(IDataRepositoryWithMovies<SeenMovies> dataRepo)
        {
            dataRepository = dataRepo;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<SeenMovieDTO>>> GetAllLikedMovieByUser(int userId)
        {
            var result = await dataRepository.GetMoviesByUserId(userId);

            List<SeenMovieDTO> seenMovieDTOs = new List<SeenMovieDTO>();

            foreach (SeenMovies seenMovies  in result)
            { 
                seenMovieDTOs.Add(new SeenMovieDTO(seenMovies));
            }

            return Ok(seenMovieDTOs);
        }

        [HttpPost]
        public async Task<ActionResult<SeenMovieDTO>> AddLikedMovieForUser(SeenMovieDTO seenMovie)
        {
            if (seenMovie == null)
            {
                return BadRequest();
            }

            var result = await dataRepository.AddAsync(new SeenMovies(seenMovie));

            return Ok(result.Value);
        }

        [HttpDelete]
        public async Task<ActionResult> DeleteLikedMovieForUser(int IdUser, int IdMovieTmdb)
        {
            if (IdUser == null && IdMovieTmdb == null)
            {
                return BadRequest();
            }

            var result = await dataRepository.DeleteMoviesByUserAndMovieId(IdUser, IdMovieTmdb);

            return Ok(result);
        }
    }
}
