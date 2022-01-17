using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MessengerVS.Repo;
using MessengerVS.Models;
using System.Threading;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
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
            ViewBag.Message = "This is a web application that allows users to send and recieve messages ";

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
            using (var db = GetContxt())
            {
                try
                {
                    var eventProvinces = db.Database.SqlQuery<LocationModel>(String.Format("Location.spGetProvinces")).ToList();
                    return new JsonResult { Data = eventProvinces, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
                }
                catch (Exception)
                {

                    throw;
                }
            }
        }

        //public JsonResult GetCities()
        //{
        //    using (var db = GetContxt())
        //    {
        //        try
        //        {
        //            var eventCities = db.Database.SqlQuery<LocationModel>(String.Format("Location.spGetCities")).ToList();
        //            return new JsonResult { Data = eventCities,JsonRequestBehavior = JsonRequestBehavior.AllowGet };
        //        }
        //        catch (Exception)
        //        {

        //            throw;
        //        }
        //    }
        //}
        public JsonResult SaveContacts(LocationModel locationModel)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["MessengerEntity"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("Contacts.spAddContacts", connection);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter("@PhoneNumber", locationModel.PhoneNumber));
                cmd.Parameters.Add(new SqlParameter("@PhoneTypeID", Int32.Parse(locationModel.PhonetypeId)));
                cmd.Parameters.Add(new SqlParameter("@Email", locationModel.Email));
                cmd.Parameters.Add(new SqlParameter("@EmailType", locationModel.EmailType));

                cmd.Parameters.Add(new SqlParameter("@Message", SqlDbType.VarChar, 250)).Direction = ParameterDirection.Output;

                connection.Open();

                cmd.ExecuteNonQuery();

                locationModel.Message = Convert.ToString(cmd.Parameters["@Message"].Value);

                connection.Close();
            }
            return new JsonResult { Data = locationModel, JsonRequestBehavior=JsonRequestBehavior.AllowGet };
        }

        public static Contxt GetContxt()
        {

            return new Contxt();
        }
    }
}