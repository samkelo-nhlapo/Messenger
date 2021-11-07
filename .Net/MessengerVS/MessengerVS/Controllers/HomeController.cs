using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MessengerVS.Repo;
using MessengerVS.Models;

namespace MessengerVS.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            LocationModel model = new LocationModel();
            
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
            try
            {
                using (var db = GetContxt())
                {
                    var eventCountryList = db.Database.SqlQuery<LocationModel>(String.Format("Location.spGetCountries")).ToList();
                    return new JsonResult { Data = eventCountryList, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
                }
            }
            catch (Exception)
            {

                throw;
            }
            
        }

        public JsonResult GetCities()
        {
            try
            {
                using (var db = GetContxt())
                {
                    var eventCountryList = db.Database.SqlQuery<LocationModel>(String.Format("Location.spGetCities")).ToList();
                    return new JsonResult { Data = eventCountryList, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
                }
            }
            catch (Exception)
            {

                throw;
            }

        }

        public JsonResult GetProvinces()
        {
            try
            {
                using (var db = GetContxt())
                {
                    var eventCountryList = db.Database.SqlQuery<LocationModel>(String.Format("Location.spGetProvinces")).ToList();
                    return new JsonResult { Data = eventCountryList, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
                }
            }
            catch (Exception)
            {

                throw;
            }

        }

        public static Contxt GetContxt()
        {
            return new Contxt();
        }
    }
}