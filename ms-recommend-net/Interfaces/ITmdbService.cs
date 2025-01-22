using System.Threading.Tasks;

namespace ms_recommend_net.Services
{
    public interface ITmdbService
    {
        Task<int?> GetMovieIdAsync(string movieTitle);
        Task<string> GetMovieDetailsAsync(int movieId);
    }
}
