using data.Models.EntityFramework;

namespace data.Models.DTO
{
    public class PreferenceDTO
    {
        public int? IdPreference { get; set; }
        public int IdUser { get; set; }
        public int IdGenre { get; set; }

        public PreferenceDTO() { }
        public PreferenceDTO(Preference preference)
        {
            IdPreference = preference.IdPreference;
            IdUser = preference.IdUser;
            IdGenre = preference.IdGenre;
        }
    }
}
