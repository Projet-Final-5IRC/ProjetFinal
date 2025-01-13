using data.Models.DTO;
using data.Models.EntityFramework;
using Microsoft.AspNetCore.Mvc;

namespace data.Models.Repository
{
    public interface IDataRepository<TEntity>
    {
        Task<ActionResult<IEnumerable<TEntity>>> GetAllAsync();
        Task<ActionResult<TEntity>> GetByIdAsync(int id);
        Task<ActionResult<TEntity>> AddAsync(TEntity entity);
        Task<ActionResult<TEntity>> UpdateAsync(TEntity entityToUpdate, TEntity entityUpdated);
        Task<ActionResult> DeleteAsync(TEntity entity);
    }

    public interface IDataRepositoryWithEmail<TEntity> : IDataRepository<TEntity>
    {
        Task<ActionResult<TEntity>> GetByEmailAsync(string email);
    }

    public interface IDataRepositoryWithPreference<TEntity> : IDataRepository<TEntity>
    {
        Task<List<PreferenceDTO>> GetByUserIdAsync(int id);
        Task<ActionResult<PreferenceDTO>> AddPreferenceAsync(PreferenceDTO entity);
        Task<ActionResult<List<PreferenceDTO>>> UpdateUserPreferenceAsync(int IdUser, List<PreferenceDTO> listPreferences);
        Task<ActionResult> DeleteUserPreferenceAsync(int IdUser);
    }
}
