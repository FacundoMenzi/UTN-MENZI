using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace _1._1_Carreras
{
    internal class Carrera
    {
        private string nombre;
        private string titulo;
        public int IdCarrera { get; set; }
        public string Nombre { get => nombre; set => nombre = value; }
        public string Titulo { get => titulo; set => titulo = value; }
        public List<DetalleCarrera> Detalles { get; set; }
        public int Estado { get; set; }
        public Carrera()
        {
            Detalles=new List<DetalleCarrera>();
        }
        public Carrera(string nombre,string titulo,List<DetalleCarrera> detalle,int estado)
        {
            Nombre = nombre;
            Titulo = titulo;
            Detalles= detalle;
            estado = 1;
        }
        public override string ToString()
        {
            return Nombre;
        }
        public void AgregarDetalle(DetalleCarrera detalle)
        {
            Detalles.Add(detalle);
        }
        public void QuitarDetalle(int index)
        {
            Detalles.RemoveAt(index);
        }
        public bool Confirmar()
        {
            bool result = true;
            SqlConnection conn = new SqlConnection();
            SqlTransaction trs = null;
            
            try
            {
                conn.ConnectionString= Properties.Resources.cnnString;
                conn.Open();
                SqlCommand cmd = new SqlCommand("SP_INSERTAR_MAESTRO",conn);
                cmd.CommandType = CommandType.StoredProcedure;
                //Transaccion
                trs = conn.BeginTransaction();
                cmd.Transaction=trs;
                
                cmd.Parameters.AddWithValue("@nombre",this.Nombre);
                cmd.Parameters.AddWithValue("@titulo", this.Titulo);
                
                //parametro de salida
                SqlParameter param = new SqlParameter("id_carrera", SqlDbType.Int);
                param.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(param);
                cmd.ExecuteNonQuery();
                
                int id_carrera=Convert.ToInt32(param.Value);
                int cDetalles = 1;

                foreach(DetalleCarrera det in Detalles)
                {
                    SqlCommand cmdDet = new SqlCommand("SP_INSERTAR_DETALLE",conn);
                    cmdDet.CommandType = CommandType.StoredProcedure;
                    
                    cmdDet.Transaction=trs;            
                    cmdDet.Parameters.AddWithValue("@id_detalle", cDetalles);
                    cmdDet.Parameters.AddWithValue("id_carrera", id_carrera);
                    cmdDet.Parameters.AddWithValue("@anioCursado",det.AnioCursado);
                    cmdDet.Parameters.AddWithValue("@cuatrimestre", det.Cuatrimestre);
                    cmdDet.Parameters.AddWithValue("@id_asignatura", det.Asignatura.Id);
                    cmdDet.ExecuteNonQuery();
                    cDetalles++;
                
                }
                trs.Commit();
            }
            catch (Exception)
            {
                result = false;
                trs.Rollback();
            }
            finally
            {
                if(conn!=null && conn.State==ConnectionState.Open)
                    conn.Close();
            }
            return result;
        }

    }
}
