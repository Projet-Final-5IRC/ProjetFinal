using data.Models.EntityFramework.Complexity;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using data.Models.EntityFramework;

namespace data.Models.DTO
{
    public class EventDTO
    {
        public int IdEvent { get; set; }
        public string EventName { get; set; }
        public string EventHour { get; set; }
        public string? EventDate { get; set; }
        public string? EventLocation { get; set; }
        public string? EventDescription { get; set; }
        public int? IdGenre { get; set; }
        public string genreName { get; set; }
        public List<int> eventInvitationId { get; set; }

        public EventDTO(Events events)
        {
            this.IdEvent = events.IdEvent;
            this.EventName = events.EventName;
            this.EventHour = events.EventHour;
            this.EventDate = events.EventDate;
            this.EventLocation = events.EventLocation;
            this.EventDescription = events.EventDescription;
            this.IdGenre = events.IdGenre;
            this.genreName = events.GenreEvent?.GenreName;
            this.eventInvitationId = events.EventInvitation
                                        .Select(invite => invite.idEventsInvite)
                                        .ToList();
        }
    }
}
