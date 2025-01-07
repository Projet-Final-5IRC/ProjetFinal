using data.Models.EntityFramework;

namespace data.Models.DTO
{
    public class EventInviteDTO
    {
        public int IdEventsInvite { get; set; }
        public int IdEvent { get; set; }
        public int IdUser { get; set; }
        public bool IsPending { get; set; }
        public string? EventName { get; set; }
        public string? UserName { get; set; }

        public EventInviteDTO(EventsInvite invite)
        {
            this.IdEventsInvite = invite.idEventsInvite;
            this.IdEvent = invite.IdEvent;
            this.IdUser = invite.IdUser;
            this.IsPending = invite.IsPending;
            this.EventName = invite.EventReference?.EventName;
            this.UserName = invite.UserReference?.UserName;
        }
    }
}
