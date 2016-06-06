using BikeTourCore.Entity;
using BikeTourDataAccessLayer.EF.Mapping;
using System.Data.Entity;

namespace BikeTourDataAccessLayer.EF
{
    public partial class DBContext : DbContext, IDBContext
    {
        static DBContext()
        {
            Database.SetInitializer<DBContext>(null);
        }

        public DBContext()
            : base("Name=BikeTourContext")
        {
        }
        public virtual DbSet<Login> Logins { get; set; }
        
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {            
            modelBuilder.Configurations.Add(new LoginMap());            
        }
    }
}
