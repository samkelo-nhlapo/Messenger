using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;

namespace MessengerVS.Repo
{
    public partial class Contxt : DbContext
    {
        public Contxt () : base("name = MessengerEntity")
        {
        }
    }
}