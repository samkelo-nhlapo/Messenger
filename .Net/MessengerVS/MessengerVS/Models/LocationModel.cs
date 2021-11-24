using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MessengerVS.Models
{
    public class LocationModel
    {
        //spGetCountries
        public string CountryId { get; set; }
        public string CountryDescripition { get; set; }

        //spGetProvinces
        public string ProvinceId { get; set; }
        public string ProvinceDescription { get; set; }

        //spGetCities
        public string CityID { get; set; }
        public string CityName { get; set; }
    }
}