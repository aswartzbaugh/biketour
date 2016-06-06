using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BikeTourDataAccessLayer
{
    public interface IDBContext
    {
          int SaveChanges();
    }
}
