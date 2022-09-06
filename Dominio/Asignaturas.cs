using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _1._1_Carreras
{
    internal class Asignaturas
    {
        private int id;
        private string name;

        public int Id { get => id; set => id = value; }
        public string Name { get => name; set => name = value; }

        public override string ToString()
        {
            return Name;
        }
        public Asignaturas (int id,string name)
        {
            this.id = id;
            this.name = name;
        }
    }
}
