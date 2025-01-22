namespace ms_badge.Models
{
    public class UserBadge
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int BadgeId { get; set; }
        public DateTime AssignedDate { get; set; }
    }
}
