using ms_recommend_net.Models;

namespace ms_recommend_net.Interfaces
{
    public interface IRecommendationService
    {
        Task<IEnumerable<Films>> GetRecommendationsAsync(int userId);
    }
}
