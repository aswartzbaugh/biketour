using BikeTourCore.Entity;
using System.Data.Entity.ModelConfiguration;

namespace BikeTourDataAccessLayer.EF.Mapping
{
    public class LoginMap : EntityTypeConfiguration<Login>
    {
        public LoginMap()
        {
            // Primary Key
            this.HasKey(t => t.LoginId);

            //// Properties
            ////this.Property(t => t.Name).HasMaxLength(100);
            //this.Property(t => t).HasMaxLength(100);            

            // Table & Column Mappings
            this.ToTable("LoginDtls");
            this.Property(t => t.LoginId).HasColumnName("LoginId");            
            this.Property(t => t.RoleId).HasColumnName("RoleId");
            this.Property(t => t.LoginName).HasColumnName("LoginName");
            this.Property(t => t.Password).HasColumnName("Password");
            this.Property(t => t.IsActive).HasColumnName("IsActive");
            this.Property(t => t.IsFirstLogin).HasColumnName("IsFirstLogin");
            this.Property(t => t.DeActiveDate).HasColumnName("DeActiveDate");
            this.Property(t => t.DeActiveBy).HasColumnName("DeActiveBy");           
        }
    }
}
