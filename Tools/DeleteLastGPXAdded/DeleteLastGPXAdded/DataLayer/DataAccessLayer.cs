using System;
using System.Collections.Generic;
using System.Web;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

/// <summary>
/// Summary description for DataAccessLayer
/// </summary>
public static class DataAccessLayer
{
    static SqlConnection _Con;
    //static SqlCommand _Command;
    //static object obj;
    //static DataSet _Dataset;
    //static DataTable _DataTable;
    //static int Success;
    static DataAccessLayer()
    {

        _Con = new SqlConnection(ConfigurationManager.ConnectionStrings["BikeTourConnectionString"].ConnectionString);
    }

    public static object ExecuteScalar(string Query)
    {
        Object obj = null;
        try
        {
            SqlCommand _Command;
            OpenConnection();
            _Command = new SqlCommand(Query, _Con);
            obj = _Command.ExecuteScalar();
        }
        catch (Exception ex)
        {
            CloseConnection();
        }
        finally
        {
            CloseConnection();
        }
        return obj;
    }
    public static int ExecuteNonQuery(string Query)
    {
        int Success = 0;
        try
        {
            SqlCommand _Command;
            OpenConnection();
            _Command = new SqlCommand(Query, _Con);
            Success = _Command.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            Success = -1;
            CloseConnection();
        }
        finally
        {
            CloseConnection();
        }
        return Success;
    }
    public static DataSet ExecuteStoredProcedureToRetDataSet(SqlParameter[] ParamArray, string ProcedureName)
    {
        DataSet _Dataset = null;
        try
        {
            SqlCommand _Command;
            _Dataset = new DataSet();
            OpenConnection();
            _Command = new SqlCommand(ProcedureName, _Con);
            _Command.CommandType = CommandType.StoredProcedure;
            _Command.Parameters.AddRange(ParamArray);
            SqlDataAdapter _DataAdapter = new SqlDataAdapter(_Command);
            _DataAdapter.Fill(_Dataset);
        }
        catch (Exception)
        {
        }
        return _Dataset;
    }
    public static DataTable ExecuteStoredProcedureToRetDataTable(SqlParameter[] ParamArray, string ProcedureName)
    {
        DataTable _DataTable = null;
        _DataTable = new DataTable();
        try
        {
            SqlCommand _Command;
            OpenConnection();
            _Command = new SqlCommand(ProcedureName, _Con);
            _Command.CommandType = CommandType.StoredProcedure;
            _Command.Parameters.AddRange(ParamArray);
            SqlDataAdapter _DataAdapter = new SqlDataAdapter(_Command);
            _DataAdapter.Fill(_DataTable);
            return _DataTable;
        }
        catch (Exception ex)
        {
            return _DataTable = null;
        }

    }

    public static IDataReader ExecuteStoredProcedureToReturnDataReader(SqlParameter[] ParamArray, string ProcedureName)
    {
        try
        {
            SqlCommand _Command;
            OpenConnection();
            _Command = new SqlCommand(ProcedureName, _Con);
            _Command.CommandType = CommandType.StoredProcedure;
            _Command.Parameters.AddRange(ParamArray);

            IDataReader dataReader = _Command.ExecuteReader();

            return dataReader;
        }
        catch (Exception ex)
        {
            throw new Exception("EvaluatorMaster::SelectAll::Error occured.", ex);
        }
        finally
        {
            // CloseConnection();
        }
    }

    private static List<object> PopulateObjectsFromReader(IDataReader dataReader)
    {
        throw new NotImplementedException();
    }

    public static int ExecuteStoredProcedure(SqlParameter[] ParamArray, string ProcedureName)
    {
        int Success = 0;
        try
        {
            SqlCommand _Command;
            OpenConnection();
            _Command = new SqlCommand(ProcedureName, _Con);
            _Command.CommandType = CommandType.StoredProcedure;
            _Command.Parameters.AddRange(ParamArray);
            Success = _Command.ExecuteNonQuery();

        }
        catch (Exception ex)
        {
            if (_Con.State == ConnectionState.Open)
            {
                CloseConnection();
            }
        }
        finally
        {
            CloseConnection();
        }
        return Success;
    }

    public static int ExecuteStoredProcedure(SqlParameter[] ParamArray, string ProcedureName, string OutputParameterName)
    {
        int Success = 0;
        try
        {
            SqlCommand _Command;
            OpenConnection();
            _Command = new SqlCommand(ProcedureName, _Con);
            _Command.CommandType = CommandType.StoredProcedure;
            _Command.Parameters.AddRange(ParamArray);
            Success = _Command.ExecuteNonQuery();
            Success = Convert.ToInt32(_Command.Parameters[OutputParameterName].Value);
        }
        catch (Exception)
        {
            if (_Con.State == ConnectionState.Open)
            {
                CloseConnection();
            }
        }
        finally
        {
            CloseConnection();
        }
        return Success;
    }

    public static DataTable ExecuteStoredProcedure(string ProcedureName)
    {
        DataTable _DataTable = null;
        try
        {
            SqlCommand _Command;
            OpenConnection();
            _DataTable = new DataTable();
            _Command = new SqlCommand(ProcedureName, _Con);
            _Command.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter _DataAdapter = new SqlDataAdapter(_Command);
            _DataAdapter.Fill(_DataTable);
        }
        catch (Exception)
        { }
        return _DataTable;
    }

    public static void CloseConnection()
    {
        try
        {
            lock (o)
            {
                if (_Con.State == ConnectionState.Open)
                {
                    _Con.Close();

                }
            }
        }
        catch (Exception ex)
        { }
    }

    static object o = "Lock";

    private static void OpenConnection()
    {
        try
        {
            lock (o)
            {
                if (_Con.State != ConnectionState.Open)
                    _Con.Open();
            }

        }
        catch (Exception ex)
        {

        }
    }
    public static DataTable ReturnDataTable(string Query)
    {
        DataTable _DataTable = null;
        try
        {
            SqlDataAdapter _dataAdapter = new SqlDataAdapter(Query, _Con);
            _DataTable = new DataTable();
            _dataAdapter.Fill(_DataTable);
        }
        catch (Exception ex)
        { }
        return _DataTable;
    }

    public static DataSet ReturnDataSet(string Query)
    {
        DataSet _Dataset = null;
        try
        {
            SqlDataAdapter _dataAdapter = new SqlDataAdapter(Query, _Con);
            _Dataset = new DataSet();
            _dataAdapter.Fill(_Dataset);
        }
        catch (Exception ex)
        { }
        return _Dataset;
    }

    public static IDataReader ReturnDataReader(string Query)
    {
        try
        {
            SqlCommand _Command;
            OpenConnection();
            _Command = new SqlCommand(Query, _Con);
            _Command.CommandType = CommandType.Text;
            IDataReader dataReader = _Command.ExecuteReader();
            return dataReader;
        }
        catch (Exception ex)
        {
            throw new Exception("::SelectAll::Error occured.", ex);
        }
    }
}