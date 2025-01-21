namespace ms_badge.Models
{
    public class Badge
    {
        public int Id { get; set; }
        public required string Name { get; set; }
        public required string Description { get; set; }
        public required string Criteria { get; set; }
    }
}
