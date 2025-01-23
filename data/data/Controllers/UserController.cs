using data.Models.DTO;
using data.Models.EntityFramework;
using data.Models.Repository;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace data.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly IDataRepositoryWithEmail<Users> dataRepository;

        public UserController(IDataRepositoryWithEmail<Users> dataRepo)
        {
            dataRepository = dataRepo;
        }

        // GET: api/Users
        [HttpGet]
        public async Task<ActionResult<IEnumerable<UserDTO>>> GetUsers()
        {
            var result = await dataRepository.GetAllAsync();

            List<UserDTO> listUsers = new List<UserDTO>();

            foreach (Users user in result.Value) 
            {
                listUsers.Add(new UserDTO(user));   
            }

            return listUsers;
        }

        // GET: api/Users/5
        [HttpGet("{id}")]
        public async Task<ActionResult<UserDTO>> GetUserById(int id)
        {
            var user = await dataRepository.GetByIdAsync(id);

            if (user.Value == null)
            {
                return NotFound();
            }

            return new UserDTO(user.Value);
        }

        //GET: api/Users/email/{email}
        [HttpGet("email/{email}")]
        public async Task<ActionResult<Users>> GetUserByEmail(string email)
        {
            var user = await dataRepository.GetByEmailAsync(email);

            if (user == null)
            {
                return NotFound();
            }

            return user.Value;
        }

        //GET: api/Users/username/{username}
        [HttpGet("username/{username}")]
        public async Task<ActionResult<Users>> GetUserByUsername(string username)
        {
            var user = await dataRepository.GetByUsernameAsync(username);

            if (user == null)
            {
                return NotFound();
            }

            return user.Value;
        }

        // PUT: api/Users/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<ActionResult<UserDTO>> PutUsers(int id, Users userUpdated)
        {
            if (id != userUpdated.IdUser)
            {
                return BadRequest();
            }

            var userToUpdate = await dataRepository.GetByIdAsync(id);
            if (userToUpdate.Value == null)
            {
                return NotFound();
            }
            else
            {
                var result = await dataRepository.UpdateAsync(userToUpdate.Value, userUpdated);
                return new UserDTO(result.Value);
            }
        }

        // POST: api/Users
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Users>> PostUser(Users user)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var check = await dataRepository.GetByEmailAsync(user.Email);

            if( check != null)
            {
                if(check.Value != null)
                {
                    return BadRequest("Email déjà présent");
                }
            }
            
            await dataRepository.AddAsync(user);

            return CreatedAtAction("GetUserById", new { id = user.IdUser }, new UserDTO(user));
        }

        // DELETE: api/Users/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteUser(int id)
        {
            var user = await dataRepository.GetByIdAsync(id);
            if (user.Value == null)
            {
                return NotFound("User not found!");
            }

            await dataRepository.DeleteAsync(user.Value);

            return NoContent();
        }
    }
}