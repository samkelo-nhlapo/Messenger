using SpreadsheetLight;
using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;

namespace InsertCities
{
    class Program
    {
        static void Main(string[] args)
        {
            var fileName = Path.GetFullPath(@"C:\Users\Sam\Music\Messanger\Excel reader\SouthAfricanCities.xlsx");

            //check if file exists
            if (fileName is null)
            {
                Console.WriteLine("where is the file");
            }
            else
            {
                Console.WriteLine("found file");
            }
            string sheetName = "all";

            //SLDocument file and sheet name
            using (var doc = new SLDocument(fileName, sheetName))
            {
                var sheetNames = doc.GetSheetNames(false);
                // does sheet exists
                if (!sheetNames.Contains(sheetName))
                {
                    throw new Exception("Sheet does not exists");
                }

                //Total Number of Rows in the table
                SLWorksheetStatistics totalRows = doc.GetWorksheetStatistics();

                string City = "";
                string Province= "";
                DateTime datetime = DateTime.Now;


                for (int rowIndex = 2; rowIndex < totalRows.EndRowIndex + 2; rowIndex++)
                {
                    City = doc.GetCellValueAsString(rowIndex, 1);
                    Province = doc.GetCellValueAsString(rowIndex, 2);
                    

                    using (SqlConnection conn = new SqlConnection("Server=localhost,1433;Database=Messenger;User Id=sa;Password=GDGp4NJec2T3WhpH;"))
                    {
                        //Console.WriteLine("Connected to sql");
                        SqlCommand command = new SqlCommand("Location.spInsertCities", conn);
                        command.CommandType = CommandType.StoredProcedure;

                        command.Parameters.Add(new SqlParameter("@City", City));
                        command.Parameters.Add(new SqlParameter("@Province", Province));
                        command.Parameters.Add(new SqlParameter("@Message", SqlDbType.VarChar, 250)).Direction = ParameterDirection.Output;

                        conn.Open();
                        command.ExecuteNonQuery();
                        if (Convert.ToString(command.Parameters["@Message"].Value) != "")
                        {
                            Console.WriteLine(Convert.ToString(command.Parameters["@Message"].Value));
                        }

                        conn.Close();
                    }

                }
            }
        }
    }
}
