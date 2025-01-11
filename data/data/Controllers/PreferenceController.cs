using data.Models.DTO;
using data.Models.EntityFramework;
using data.Models.Repository;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace data.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PreferenceController : ControllerBase
    {
        private readonly IDataRepositoryWithPreference<Preference> dataRepository;

        public PreferenceController(IDataRepositoryWithPreference<Preference> dataRepo)
        {
            dataRepository = dataRepo;
        }

        // GET: api/Preference
        [HttpGet]
        public async Task<ActionResult<IEnumerable<PreferenceDTO>>> GetPreferences()
        {
            var preferences = await dataRepository.GetAllAsync();

            List<PreferenceDTO> listPreferences = new List<PreferenceDTO>();

            foreach (Preference preference in preferences.Value)
            {
                listPreferences.Add(new PreferenceDTO(preference));
            }

            return listPreferences;
        }

        // GET: api/Preference/5
        [HttpGet("{id}")]
        public async Task<ActionResult<List<PreferenceDTO>>> GetPreferenceByUserId(int id)
        {
            var preference = await dataRepository.GetByUserIdAsync(id);

            if (preference == null)
            {
                return NotFound();
            }

            return Ok(preference);
        }

        // PUT: api/Preference/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<ActionResult<PreferenceDTO>> PutPreference(int id, Preference preferenceUpdated)
        {
            if (id != preferenceUpdated.IdPreference)
            {
                return BadRequest();
            }

            var preferenceToUpdate = await dataRepository.GetByIdAsync(id);
            if (preferenceToUpdate.Value == null)
            {
                return NotFound();
            }
            else
            {
                var result = await dataRepository.UpdateAsync(preferenceToUpdate.Value, preferenceUpdated);
                return new PreferenceDTO(result.Value);
            }
        }

        // POST: api/Preference
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<PreferenceDTO>> PostPreference(Preference preference)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            await dataRepository.AddAsync(preference);

            return CreatedAtAction("GetPreferenceByUserId", new { id = preference.IdUser }, new PreferenceDTO(preference));
        }

        // POST api/Preference
        [HttpPost("PostUserPreference")]
        public async Task<ActionResult<PreferenceDTO>> PostUserPreference(List<PreferenceDTO> preferences)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            foreach (PreferenceDTO preference in preferences)
            {
                await dataRepository.AddPreferenceAsync(preference);
            }

            return CreatedAtAction("GetPreferenceByUserId", new { id = preferences[0].IdUser }, preferences);
        }

        // DELETE: api/Preference/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeletePreference(int id)
        {
            var preference = await dataRepository.GetByIdAsync(id);
            if (preference.Value == null)
            {
                return NotFound("Preference not found!");
            }

            await dataRepository.DeleteAsync(preference.Value);
            return NoContent();
        }
    }
}
