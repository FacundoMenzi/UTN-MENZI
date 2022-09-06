using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace _1._1_Carreras
{
    internal class DBHelper
    {
        SqlConnection conn = new SqlConnection(Properties.Resources.cnnString);
        SqlCommand cmd = new SqlCommand();
        SqlTransaction trs = null;

        private void Conectar()
        {
            conn.Open();
            cmd.Connection = conn;
        }
        public void Desconectar()
        {
            conn.Close();
        }

        public DataTable LeerBD(string SP)
        {
            cmd.Parameters.Clear();
            DataTable tabla=new DataTable();
            Conectar();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = SP;
            tabla.Load(cmd.ExecuteReader());
            Desconectar();
            return tabla;
        }
        public int CantidadCarreras()
        {
            Conectar();
            cmd.Parameters.Clear();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "SP_CANTIDAD_CARRERAS";
            
            SqlParameter cant = new SqlParameter();
            cant.ParameterName = "@cant";
            cant.DbType = DbType.Int32;
            cant.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(cant);
            
            cmd.ExecuteReader();
            Desconectar();
            
            return (int)cant.Value;
        }
        public DataTable Detalles(int idcarrera)
        {
            DataTable table = new DataTable();
            Conectar();
            cmd.Parameters.Clear();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@idCarrera",idcarrera);
            cmd.CommandText = "SP_VER_DETALLES";
            table.Load(cmd.ExecuteReader());
            Desconectar();
            return table;
        }
       public bool ModificarCarrera(Carrera c)
       {
            bool result = true;
            try
            {
                Conectar();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "SP_MODIFICAR_CARRERAS";
                cmd.Parameters.Clear();
                trs = conn.BeginTransaction();
                cmd.Transaction = trs;
                cmd.Parameters.AddWithValue("@id_Carrera", c.IdCarrera);
                cmd.Parameters.AddWithValue("@nombre", c.Nombre);
                cmd.Parameters.AddWithValue("@titulo", c.Titulo);

                cmd.ExecuteNonQuery();

                int cDetalles = 1;
                foreach (DetalleCarrera det in c.Detalles)
                {
                    SqlCommand cmdDet = new SqlCommand("SP_INSERTAR_DETALLE", conn);
                    cmdDet.CommandType = CommandType.StoredProcedure;

                    cmdDet.Transaction = trs;
                    cmdDet.Parameters.Clear();
                    cmdDet.Parameters.AddWithValue("@id_detalle", cDetalles);
                    cmdDet.Parameters.AddWithValue("id_carrera", c.IdCarrera);
                    cmdDet.Parameters.AddWithValue("@anioCursado", det.AnioCursado);
                    cmdDet.Parameters.AddWithValue("@cuatrimestre", det.Cuatrimestre);
                    cmdDet.Parameters.AddWithValue("@id_asignatura", det.Asignatura.Id);
                    cmdDet.ExecuteNonQuery();
                    cDetalles++;

                }
                trs.Commit();    
            }
            catch (Exception)
            {
                trs.Rollback();
                result=false;   
            }
            finally
            {
                if (conn != null && conn.State == ConnectionState.Open)
                    conn.Close();
            }
            return result;

       }
        
      
    }
}
