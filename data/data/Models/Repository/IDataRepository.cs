﻿using data.Models.EntityFramework;
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
}