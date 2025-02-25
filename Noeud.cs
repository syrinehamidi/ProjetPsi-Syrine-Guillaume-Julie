using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PSI_Rendu_1
{
    public class Noeud
    {
        #region Instances

        /// <summary>
        /// Un noeud est caractérisé par son identifiant et l'ensemble de ses liens.
        /// </summary>
        private int id;
        private List<Lien> liens;

        #endregion

        #region Constructeur
        public Noeud (int id)
        {
            this.id = id;
            liens = new List<Lien>();
        }

        #endregion

        #region Propriétés
        public int Id
        { get { return id; } }

        public List<Lien> Liens 
        { get {  return liens; } }

        #endregion
    }
}
