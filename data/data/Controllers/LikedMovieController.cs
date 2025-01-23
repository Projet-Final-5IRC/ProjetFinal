using data.Models.DTO;
using data.Models.EntityFramework;
using data.Models.Repository;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace data.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LikedMovieController : ControllerBase
    {
        private readonly IDataRepositoryWithMovies<LikedMovies> dataRepository;

        public LikedMovieController(IDataRepositoryWithMovies<LikedMovies> dataRepo)
        {
            dataRepository = dataRepo;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<LikedMovieDTO>>> GetAllLikedMovieByUser(int userId)
        {
            var result = await dataRepository.GetMoviesByUserId(userId);

            List<LikedMovieDTO> likedMovieDTOs = new List<LikedMovieDTO>();

            foreach (LikedMovies likedMovies in result)
            {
                likedMovieDTOs.Add(new LikedMovieDTO(likedMovies));
            }

            return Ok(likedMovieDTOs);
        }

        [HttpPost]
        public async Task<ActionResult<LikedMovieDTO>> AddLikedMovieForUser(LikedMovieDTO likedMovie)
        {
            if (likedMovie == null)
            {
                return BadRequest();
            }

            var result = await dataRepository.AddAsync(new LikedMovies(likedMovie));

            return Ok(result.Value);
        }

        [HttpDelete]
        public async Task<ActionResult> DeleteLikedMovieForUser(int IdUser, int IdMovieTmdb)
        {
            if (IdUser == null && IdMovieTmdb == null)
            {
                return BadRequest();
            }

            var result = await dataRepository.DeleteMoviesByUserAndMovieId(IdUser,IdMovieTmdb);

            return Ok(result);
        }
    }
}
