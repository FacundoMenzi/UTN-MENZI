using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _1._1_Carreras
{
    internal class DetalleCarrera
    {
        private Asignaturas asignatura;
        private int anioCursado;
        private int cuatrimestre;

        public int AnioCursado { get => anioCursado; set => anioCursado = value; }
        public int Cuatrimestre { get => cuatrimestre; set => cuatrimestre = value; } 
        internal Asignaturas Asignatura { get => asignatura; set => asignatura = value; }

        public DetalleCarrera(Asignaturas asig,int cuatrimestre,int anio)
        {
            this.asignatura = asig;
            this.anioCursado = anio;
            this.cuatrimestre = cuatrimestre;
        }
        public DetalleCarrera()
        {

        }

    }
}
