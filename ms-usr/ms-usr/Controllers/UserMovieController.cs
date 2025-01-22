using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ms_usr.Models.DTO;
using ms_usr.Services;
using System.Net;
using System.Security.Cryptography.Xml;

namespace ms_usr.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserMovieController : ControllerBase
    {
        private readonly DataService _dataService;

        public UserMovieController(DataService dataService)
        {
            _dataService = dataService;
        }

        [HttpGet("GetAllLikedMovieByUser")]
        public async Task<IActionResult> GetAllLikedMovieByUser(int userId)
        {
            if (userId == null)
            {
                return BadRequest("No userId input");
            }
            try
            {
                var data = await _dataService.GetAllLikedMovieByUser($"api/LikedMovie?userId={userId}");
                if (data.StatusCode == HttpStatusCode.OK)
                {
                    return Ok(data.Data);
                }
                else
                {
                    return BadRequest(data.ErrorMessage);
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet("GetAllSeenMovieByUser")]
        public async Task<IActionResult> GetAllSeenMovieByUser(int userId)
        {
            if (userId == null)
            {
                return BadRequest("No userId input");
            }
            try
            {
                var data = await _dataService.GetAllSeenMovieByUser($"api/SeenMovie?userId={userId}");
                if (data.StatusCode == HttpStatusCode.OK)
                {
                    return Ok(data.Data);
                }
                else
                {
                    return BadRequest(data.ErrorMessage);
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPost("AddLikedMovie")]
        public async Task<IActionResult> AddLikedMovie(LikedMovieDTO likedMovie)
        {
            if (likedMovie == null)
            {
                return BadRequest("No likedMovie Input");
            }
            try
            {
                var data = await _dataService.AddLikedMovie("api/LikedMovie", likedMovie);
                if (data.StatusCode == HttpStatusCode.OK)
                {
                    return Ok(data.Data);
                }
                else
                {
                    return BadRequest(data.ErrorMessage);
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPost("AddSeenMovie")]
        public async Task<IActionResult> AddSeenMovie(SeenMovieDTO seenMovie)
        {
            if (seenMovie == null)
            {
                return BadRequest("No seenMovie Input");
            }
            try
            {
                var data = await _dataService.AddSeenMovie("api/SeenMovie", seenMovie);
                if (data.StatusCode == HttpStatusCode.OK)
                {
                    return Ok(data.Data);
                }
                else
                {
                    return BadRequest(data.ErrorMessage);
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpDelete("RemoveLikedMovie")]
        public async Task<IActionResult> RemoveLikedMovie(int IdUser, int IdMovieTmdb)
        {
            if (IdUser == null && IdMovieTmdb == null)
            {
                return BadRequest("No Input");
            }
            try
            {
                var data = await _dataService.DeleteLikedMovie($"api/LikedMovie?IdUser={IdUser}&IdMovieTmdb={IdMovieTmdb}");
                if (data.StatusCode == HttpStatusCode.NoContent)
                {
                    return Ok(data.Data);
                }
                else
                {
                    return BadRequest(data.ErrorMessage);
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpDelete("RemoveSeenMovie")]
        public async Task<IActionResult> RemoveSeenMovie(int IdUser, int IdMovieTmdb)
        {
            if (IdUser == null && IdMovieTmdb == null)
            {
                return BadRequest("No Input");
            }
            try
            {
                var data = await _dataService.DeleteSeenMovie($"api/SeenMovie?IdUser={IdUser}&IdMovie={IdMovieTmdb}");
                if (data.StatusCode == HttpStatusCode.NoContent)
                {
                    return Ok(data.Data);
                }
                else
                {
                    return BadRequest(data.ErrorMessage);
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}
