using SpreadsheetLight;
using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;

namespace ExcelReader
{
    class Program
    {
        static void Main(string[] args)
        {
            var fileName = Path.GetFullPath(@"C:\Users\Sam\Music\Messanger\Excel reader\all Countries.xlsx");
            
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
            using (var doc = new SLDocument(fileName,sheetName))
            {
                var sheetNames = doc.GetSheetNames(false);
                // does sheet exists
                if (!sheetNames.Contains(sheetName))
                {
                    throw new Exception("Sheet does not exists");
                }

                //Total Number of Rows in the table
                SLWorksheetStatistics totalRows = doc.GetWorksheetStatistics();

                string Country = "";
                string Alpha2Code = "";
                string Alpha3Code = "";
                int Numeric = 0;
                DateTime datetime = DateTime.Now;

               
                for (int rowIndex = 2; rowIndex < totalRows.EndRowIndex + 2; rowIndex++)
                {
                    Country = doc.GetCellValueAsString(rowIndex, 1);
                    Alpha2Code = doc.GetCellValueAsString(rowIndex, 2);
                    Alpha3Code = doc.GetCellValueAsString(rowIndex, 3);
                    Numeric = doc.GetCellValueAsInt32(rowIndex, 4);

                    using (SqlConnection conn = new SqlConnection("Server=localhost,1433;Database=Messenger;User Id=sa;Password=Orlando123;"))
                    {
                        //Console.WriteLine("Connected to sql");
                        SqlCommand command = new SqlCommand("Location.spInsertCountries", conn);
                        command.CommandType = CommandType.StoredProcedure;

                        command.Parameters.Add(new SqlParameter("@Country", Country));
                        command.Parameters.Add(new SqlParameter("@Alpha2Code", Alpha2Code));
                        command.Parameters.Add(new SqlParameter("@Alpha3Code", Alpha3Code));
                        command.Parameters.Add(new SqlParameter("@Numeric", Numeric));
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
