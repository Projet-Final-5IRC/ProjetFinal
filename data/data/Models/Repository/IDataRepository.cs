using data.Models.DTO;
using data.Models.EntityFramework;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ActionConstraints;

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
        Task<ActionResult<TEntity>> GetByUsernameAsync(string username);
    }

    public interface IDataRepositoryEventMore<TEntity> : IDataRepository<TEntity>
    {
        Task<ActionResult<List<UserDTO>>> GetAllUsersByEvent(int id);
    }

    public interface IDataRepositoryEventInvite<TEntity> : IDataRepository<TEntity>
    {
        Task<ActionResult<Users>> GetByUserIdAsync(int idUser);
        Task<ActionResult<EventsInvite>> JoinEvent(int idEvent, int idUser);
        Task<ActionResult<List<Events>>> GetEventJoinByUser(int idUser);
    }

    public interface IDataRepositoryWithPreference<TEntity> : IDataRepository<TEntity>
    {
        Task<List<PreferenceDTO>> GetByUserIdAsync(int id);
        Task<ActionResult<PreferenceDTO>> AddPreferenceAsync(PreferenceDTO entity);
        Task<ActionResult<List<PreferenceDTO>>> UpdateUserPreferenceAsync(int IdUser, List<PreferenceDTO> listPreferences);
        Task<ActionResult> DeleteUserPreferenceAsync(int IdUser);
    }
}
