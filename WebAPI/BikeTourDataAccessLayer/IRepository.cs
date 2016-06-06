using System;
using System.Collections.Generic;
using System.Linq.Expressions;

namespace BikeTourDataAccessLayer
{
    public interface IRepository<T>
    {
        IEnumerable<T> GetAll();
        IEnumerable<T> FindBy(Expression<Func<T, bool>> predicate);
        T Add(T entity);
        T Delete(T entity);
        void Edit(T entity);
        void Save();
    }
}
