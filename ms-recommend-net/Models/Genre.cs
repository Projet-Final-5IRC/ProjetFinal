namespace ms_recommend_net.Models
{
    public class Genre
    {
        public int GenId { get; set; } // Primary key
        public string GenName { get; set; } // Genre name
        public int GenTmid { get; set; } // TMDb ID (optional)
    }

}
