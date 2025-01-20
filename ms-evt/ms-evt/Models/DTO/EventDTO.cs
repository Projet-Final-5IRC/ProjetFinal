namespace ms_evt.Models.DTO
{
    public class EventDTO
    {
        public int idEvent { get; set; }
        public string eventName { get; set; }
        public string eventDate { get; set; }
        public string eventHour { get; set; }
        public string eventLocation { get; set; }
        public string? eventDescription { get; set; }
        public int? idGenre { get; set; }
        public string? genreName { get; set; }
        public int IdUser { get; set; }
        public string? ownerName { get; set; }
        public List<int>? eventInvitationId { get; set; }
    }
}
