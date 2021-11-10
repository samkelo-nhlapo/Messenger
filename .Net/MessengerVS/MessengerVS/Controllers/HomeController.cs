using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MessengerVS.Repo;
using MessengerVS.Models;
using System.Threading;

namespace MessengerVS.Controllers
{
    public class HomeController : Controller
    {
        public Object thislock = new object();

        public ActionResult Index()
        {
            LocationModel model = new LocationModel();
            //return Index();
            return View("Index", model);
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        public JsonResult GetCountries()
        {
            
            using (var db = GetContxt())
            {
                try
                {
                    System.Diagnostics.Trace.WriteLine(String.Format("Im in Thread #{0}", System.Threading.Thread.CurrentThread.ManagedThreadId));
                    var eventCountryList = db.Database.SqlQuery<LocationModel>(String.Format("Location.spGetCountries")).ToList();
                    return new JsonResult { Data = eventCountryList, JsonRequestBehavior = JsonRequestBehavior.AllowGet };

                }
                catch (Exception)
                {

                    throw;
                }
            }

        }

        public JsonResult GetProvinces()
        {
            Thread.Sleep(1000);

            using (var db = GetContxt())
            {
                try
                {

                    System.Diagnostics.Trace.WriteLine(String.Format("Im in Thread #{0}", System.Threading.Thread.CurrentThread.ManagedThreadId));

                    var eventProvinceList = db.Database.SqlQuery<LocationModel>(String.Format("Location.spGetProvinces")).ToList();
                    return new JsonResult { Data = eventProvinceList, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
                }
                catch (Exception)
                {

                    throw;
                }
            }
        }

        public JsonResult GetCites()
        {
            Thread.Sleep(1000);

            using (var db = GetContxt())
            {
                try
                {

                    System.Diagnostics.Trace.WriteLine(String.Format("Im in Thread #{0}", System.Threading.Thread.CurrentThread.ManagedThreadId));

                    var eventCityList = db.Database.SqlQuery<LocationModel>(String.Format("Location.spGetCities")).ToList();
                    return new JsonResult { Data = eventCityList, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
                }
                catch (Exception)
                {

                    throw;
                }
            }

        }

        public static Contxt GetContxt()
        {

            System.Diagnostics.Trace.WriteLine(String.Format("Im in Thread #{0}", System.Threading.Thread.CurrentThread.ManagedThreadId));

            return new Contxt();
        }
    }
}