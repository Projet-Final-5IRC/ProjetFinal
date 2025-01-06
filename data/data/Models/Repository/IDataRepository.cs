using data.Models.EntityFramework;
using Microsoft.AspNetCore.Mvc;

namespace data.Models.Repository
{
    public interface IDataRepository<TEntity>
    {
        Task<ActionResult<IEnumerable<TEntity>>> GetAllAsync();
        Task<ActionResult<TEntity>> GetByIdAsync(int id);
        Task<ActionResult<Events>> AddAsync(TEntity entity);
        Task<ActionResult<Events>> UpdateAsync(TEntity entityToUpdate, TEntity entityUpdated);
        Task<ActionResult> DeleteAsync(TEntity entity);
    }
}
