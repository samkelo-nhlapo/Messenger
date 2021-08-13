using SpreadsheetLight;
using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;

namespace ConsoleApp2
{
    class Program
    {
        static void Main(string[] args)
        {
            var fileName = Path.GetFullPath(@"C:\Users\Sam\Documents\Messanger\MessangerDB\Excel reader\all Countries.xlsx");

            if(fileName is null)
            {
                Console.WriteLine("where is the file");
            }
            else
            {
                Console.WriteLine("found file");
            }

            using (var doc = new SLDocument(fileName))
            {
                SLWorksheetStatistics count = doc.GetWorksheetStatistics();

                string Country = "";
                string Alpha2Code = "";
                string Alpha3Code = "";
                string Numeric = "";
                string isActive = "0";
                DateTime datetime = DateTime.Now;
                string message = "";

                if (count.NumberOfColumns is 0) 
                {

                }
                for (int rowIndex = 0; rowIndex < count.NumberOfColumns + 1; rowIndex++)
                {
                    Country = doc.GetCellValueAsString(rowIndex, 1);
                    Alpha2Code = doc.GetCellValueAsString(rowIndex, 2);
                    Alpha3Code = doc.GetCellValueAsString(rowIndex, 3);
                    Numeric = doc.GetCellValueAsString(rowIndex, 4);

                    using (SqlConnection conn = new SqlConnection("Server=localhost,1433;Database=Messanger;User Id=sa;Password=Orlando123;"))
                    {
                        //Console.WriteLine("Connected to sql");
                        SqlCommand command = new SqlCommand("Location.spInsertCountries", conn);
                        command.CommandType = CommandType.StoredProcedure;

                        command.Parameters.Add(new SqlParameter("@Country", Country));
                        command.Parameters.Add(new SqlParameter("@Alpha2Code", Alpha2Code));
                        command.Parameters.Add(new SqlParameter("@Alpha3Code", Alpha3Code));
                        command.Parameters.Add(new SqlParameter("@Numeric", Numeric));
                        command.Parameters.Add(new SqlParameter("@IsActive", isActive));
                        command.Parameters.Add(new SqlParameter("@DateTime", datetime));
                        command.Parameters.Add(new SqlParameter("@Message", SqlDbType.VarChar,250)).Direction = ParameterDirection.Output;

                        conn.Open();
                        command.ExecuteNonQuery();
                        if(Convert.ToString(command.Parameters["@Message"].Value) != "")
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
