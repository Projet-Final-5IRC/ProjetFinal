using data.Models.DTO;
using data.Models.EntityFramework;
using data.Models.Repository;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace data.Models.DataManager
{
    public class PreferenceManager : IDataRepositoryWithPreference<Preference>
    {
        readonly EventDBContext? eventDBContext;

        public PreferenceManager() { }
        public PreferenceManager(EventDBContext eventDBContext)
        {
            this.eventDBContext = eventDBContext;
        }

        public async Task<ActionResult<IEnumerable<Preference>>> GetAllAsync()
        {
            if (eventDBContext == null)
            {
                throw new ArgumentNullException(nameof(eventDBContext));
            }
            return await eventDBContext.Preference.ToListAsync();
        }

        public async Task<ActionResult<Preference>> GetByIdAsync(int id)
        {
            if (eventDBContext == null)
            {
                throw new ArgumentNullException(nameof(eventDBContext));
            }
            var preferenceEntity = await eventDBContext.Preference.FirstOrDefaultAsync(d => d.IdUser == id);

            return preferenceEntity != null ? preferenceEntity : new NotFoundResult();
        }

        public async Task<List<PreferenceDTO>> GetByUserIdAsync(int id)
        {
            if (eventDBContext == null)
            {
                throw new ArgumentNullException(nameof(eventDBContext));
            }
            var listPreferences = await eventDBContext.Preference.Where(d => d.IdUser == id).ToListAsync();

            List<PreferenceDTO> listPreferenceDTO = new List<PreferenceDTO>();

            foreach (Preference preference in listPreferences)
            {
                listPreferenceDTO.Add(new PreferenceDTO(preference));
            }

            return listPreferenceDTO;
        }

        public async Task<ActionResult<Preference>> AddAsync(Preference newPreference)
        {
            if (eventDBContext == null)
            {
                throw new ArgumentNullException(nameof(eventDBContext));
            }

            if(newPreference == null)
            {
                return new BadRequestResult();
            }

            try
            {
                await eventDBContext.Preference.AddAsync(newPreference);
                await eventDBContext.SaveChangesAsync();
                return newPreference;
            }
            catch (Exception ex)
            {
                return new ObjectResult($"An error occurred while adding the preference: {ex.Message}")
                {
                    StatusCode = StatusCodes.Status500InternalServerError
                };
            }
        }

        public async Task<ActionResult<PreferenceDTO>> AddPreferenceAsync(PreferenceDTO newPreference)
        {
            if (eventDBContext == null)
            {
                throw new ArgumentNullException(nameof(eventDBContext));
            }

            if (newPreference == null)
            {
                return new BadRequestResult();
            }

            try
            {
                await eventDBContext.Preference.AddAsync(new Preference(newPreference));
                await eventDBContext.SaveChangesAsync();
                return newPreference;
            }
            catch (Exception ex)
            {
                return new ObjectResult($"An error occurred while adding the preference: {ex.Message}")
                {
                    StatusCode = StatusCodes.Status500InternalServerError
                };
            }
        }

        public async Task<ActionResult> DeleteAsync(Preference preferenceToDelete)
        {
            if (eventDBContext == null)
            {
                throw new ArgumentNullException(nameof(eventDBContext));
            }

            if (preferenceToDelete == null)
            {
                return new BadRequestResult();
            }

            try
            {
                eventDBContext.Preference.Remove(preferenceToDelete);
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

        public async Task<ActionResult<Preference>> UpdateAsync(Preference preferenceToUpdate, Preference preferenceUpdated)
        {
            if (eventDBContext == null)
            {
                throw new ArgumentNullException(nameof(eventDBContext));
            }

            if (preferenceUpdated == null && preferenceToUpdate == null)
            {
                return new BadRequestResult();
            }

            eventDBContext.Entry(preferenceToUpdate).State = EntityState.Modified;
            preferenceToUpdate.UpdatePreferenceValue(preferenceUpdated);

            try
            {
                await eventDBContext.SaveChangesAsync();
                return preferenceToUpdate;
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
