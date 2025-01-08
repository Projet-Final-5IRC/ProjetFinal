namespace ms_evt.Models.DTO
{
    public class InviteDTO
    {
        public int IdEventsInvite { get; set; }
        public int IdEvent { get; set; }
        public int IdUser { get; set; }
        public bool IsPending { get; set; }
        public string? EventName { get; set; }
        public string? UserName { get; set; }
    }
}
