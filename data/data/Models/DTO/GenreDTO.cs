using data.Models.EntityFramework;
using Microsoft.Extensions.Logging;

namespace data.Models.DTO
{
    public class GenreDTO
    {
        public int IdGenre { get; set; }
        public int IdTMDBGenre { get; set; }
        public string GenreName { get; set; }
        public List<int> EventsId { get; set; }

        public GenreDTO(Genres genre)
        {
            this.IdGenre = genre.IdGenre;
            this.IdTMDBGenre = genre.IdTMDBGenre;
            this.GenreName = genre.GenreName;
            this.EventsId = genre.EventsGenre
                                    .Select(events => events.IdEvent)
                                    .ToList();
        }
    }
}
