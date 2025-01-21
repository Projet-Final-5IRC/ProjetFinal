namespace ms_usr.Models.DTO
{
    public class UserActivityDTO
    {
        public int UserId { get; set; }
        public int LoginCount { get; set; }
        public int QuizScore { get; set; }
        public int MoviesWatchedInMonth { get; set; }
        public int EventsAttended { get; set; }
        public int DaysActive { get; set; }
        public int ReviewsWritten { get; set; }
        public int UniqueGenresWatched { get; set; }
    }
}
