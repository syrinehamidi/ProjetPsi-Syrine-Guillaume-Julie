using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PSI_Rendu_1
{
    public class Lien
    {
        #region Instances

        /// <summary>
        /// Un lien (orienté par défaut) est caractérise par son noeud source et son noeud cible
        /// pour caractériser le sens dans lequel on peut le parcourir (de la source vers la cible)
        /// </summary>
        private Noeud source;
        private Noeud cible;

        #endregion

        #region Constructeur

        public Lien (Noeud source, Noeud cible)
        {
            this.source = source;
            this.cible = cible;
        }

        #endregion

        #region Propriétés

        public Noeud Source
        { get { return source; } }
        
        public Noeud Cible
        { get { return cible; } }

        #endregion
    }
}
