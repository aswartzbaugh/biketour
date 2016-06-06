using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BikeTourCore.Entity
{
    public class Login:Base.BaseEntity
    {
        public int LoginId { get; set; }

        public int RoleId { get; set; }

        public string LoginName { get; set; }
        public string Password { get; set; }

        public bool IsActive { get; set; }

        public bool IsFirstLogin { get; set; }

        public Nullable<DateTime> DeActiveDate { get; set; }

        public Nullable<int> DeActiveBy { get; set; }

    }
}
