using BikeTourCore.Entity.Base;
using System;

namespace BikeTourDataAccessLayer
{
    public interface IUnitOfWork : IDisposable
    {
        /// <summary>
        /// Saves all pending changes
        /// </summary>
        /// <returns>The number of objects in an Added, Modified, or Deleted state</returns>
        /// 
        int Commit();
        IRepository<TEntity> GetRepository<TEntity>() where TEntity : BaseEntity;
    }
}
