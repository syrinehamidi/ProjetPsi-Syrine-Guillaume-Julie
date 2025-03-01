using System;
using System.Collections.Generic;
using System.Collections.Immutable;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace PSI_Rendu_1
{
    public class Graphe
    {
        #region Instances

        /// <summary>
        /// Un graph est caractérisé par un ensemble de Noeuds et un ensemble de Liens
        /// sous forme de listes.
        /// Une matrice d'adjacence sous forme de matrice d'entiers.
        /// Une liste d'adjacence sous forme de liste de listes d'entiers.
        /// </summary>
        private List<Noeud> noeuds;
        private List<Lien> liens;

        private int[,] matriceAdjacence;
        private List<List<int>> listeAdjacence;

        #endregion

        #region Constructeur

        /// <summary>
        /// Le graph est peuplé des noeuds et liens dans la méthode 
        /// LectureFichierAssociation.
        /// 
        /// Ainsi sa matrice d'adjacence (sous forme de matrice d'entiers) et liste d'adjacence 
        /// (sous forme de liste de listes d'entiers) sont remplies via "ConstructionMatriceAdj"
        /// et "ConstructionListeAdj".
        /// </summary>
        public Graphe()
        {
            noeuds = new List<Noeud>();
            liens = new List<Lien>();

            LectureFichierAssociation("soc-karate.mtx");

            ConstructionMatriceAdj();

            ConstructionListeAdj();
        }

        #endregion

        #region Propriétés
        public List<Noeud> Noeuds
        { get { return noeuds; } }

        public List <Lien> Lien 
        { get {  return liens; } }

        public int[,] MatriceAdjacence
        {  get { return matriceAdjacence; } }

        public List<List<int>> ListeAdjacence 
        { get {  return listeAdjacence; } }

        #endregion

        #region Méthodes de classe

        /// <summary>
        /// Ajoute un lien a la liste des liens du graph
        /// </summary>
        /// <param name="idSource">identifiant du noeud source du lien</param>
        /// <param name="idCible">identifiant du noeud cible du lien</param>
        private void AjouterLien(int idSource, int idCible)
        {            
            Noeud source = noeuds[idSource - 1];
            Noeud cible = noeuds[idCible - 1];

            source.Liens.Add(new Lien(source, cible));
            cible.Liens.Add(new Lien(cible, source));

            liens.Add(new Lien(source, cible));
            liens.Add(new Lien(cible, source));
        }
        /// <summary>
        /// permet d'avoir accès à la methode AjouterLien pour les tests unitaires
        /// </summary>
        /// <param name="idSource"></param>
        /// <param name="idCible"></param>
        public void AjouterLienPublic(int idSource, int idCible)
        {
            AjouterLien(idSource, idCible);
        }

        /// <summary>
        /// Lis le fichier qui permet de peupler le graph. 
        /// 
        /// Ici la méthode est adaptée au fichier de Association.zip :
        /// - les lignes commentées commençant par un % ne sont pas prises en compte
        /// - la ligne 34 34 78 est exclue également
        /// - stocke tout le texte utile dans la chaine de caractères "tempTexte"
        /// 
        /// Avec la fonction "split" utilisée sur "tempTexte" le tableau "tempLiens" contenant toutes les paires de noeuds est rempli.
        /// 
        /// Puis l'ensemble des 34 noeuds sont crées avant d'ajouter chaque lien au graph
        /// </summary>
        /// <param name="filename">nom du fichier de peuplement</param>
        private void LectureFichierAssociation(string filename)
        {
            StreamReader st = null;

            try
            {
                st = new StreamReader(filename);
                string tempLigne = "";
                string tempTexte = "";
                string exeption = "34 34 78";

                while ((tempLigne = st.ReadLine()) != null)
                {
                    if (tempLigne[0] != '%' && tempLigne.Trim() != exeption)
                    {
                        tempTexte += tempLigne + " ";
                    }
                }
                tempTexte = tempTexte.Substring(0, tempTexte.Length - 1);

                string[] tempLiens = tempTexte.Split();

                for (int i = 0; i < 34; i++)
                {
                    noeuds.Add(new Noeud (i + 1));  
                }

                for (int i = 0 ; i < tempLiens.Length ; i += 2)
                {
                    AjouterLien(Convert.ToInt32(tempLiens[i]), Convert.ToInt32(tempLiens[i + 1]));
                }
            }
            catch (FileNotFoundException e)
            {
                Console.WriteLine("Fichier " + filename + " introuvable.");
            }
            catch (IOException e)
            {
                Console.WriteLine(e.Message);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            finally
            {
                if (st != null) st.Close();
            }
        }

        /// <summary>
        /// A partir de l'ensemble des noeuds et des liens du graph, la matrice d'adjacence est crée.
        /// 
        /// On vient remplacer les 0 par défaut de la matrice par des 1 là où
        /// il y a un lien entre le noeud source i et le noeud cible j.
        /// </summary>
        private void ConstructionMatriceAdj()
        {
            matriceAdjacence = new int[noeuds.Count, noeuds.Count];

            for (int i = 0; i < noeuds.Count; i++)
            {
                for (int j = 0; j < noeuds[i].Liens.Count; j++)
                {
                    matriceAdjacence[i, noeuds[i].Liens[j].Cible.Id - 1] = 1;
                }
            }
        }

        /// <summary>
        /// A partir de l'ensemble des noeuds et des liens du graph, la liste d'adjacence est crée.
        /// 
        /// On vient ajouter l'identifiant des cibles dans la liste correspondant au noeud source.
        /// </summary>
        private void ConstructionListeAdj()
        {
            listeAdjacence = new List<List<int>>(noeuds.Count);
            
            for (int i = 0; i < noeuds.Count; i++)
            {
                listeAdjacence.Add(new List<int>(noeuds[i].Liens.Count));

                for (int j = 0; j < noeuds[i].Liens.Count; j++)
                {
                    ListeAdjacence[i].Add(noeuds[i].Liens[j].Cible.Id);
                }
            }
        }

        #endregion

        #region Methodes d'instance

        /// <summary>
        /// Algorithme récursif de parcours en profondeur d'un graph.
        /// Adaptation du pseudo code donné dans le cours d'Algorithmique.
        /// 
        /// Le DFS est relancé à partir de chaque sommet non visité s'il se termine sans avoir tout découvert.
        /// Affiche "Relancement" pour indiquer que le graph n'est donc pas connexe.
        /// 
        /// </summary>
        /// <param name="idDepart">Noeud à partir duquel le DFS est lancé</param>
        public void DFS(int idDepart)
        {
            int n = noeuds.Count;
            int[] couleur = new int[n];  
            int[] dateDecouverte = new int[n];  
            int[] dateFin = new int[n];
            Noeud[] predecesseurs = new Noeud[n];    
            int date = 1;               

            Console.WriteLine("\n\nDébut du parcours en profondeur à partir du noeud " + idDepart + " :");
            DFS_rec(noeuds[idDepart - 1], date, couleur, dateDecouverte, dateFin, predecesseurs);

            for (int i = idDepart; i < n; i++)
            {
                if (couleur[i] == 0) 
                {
                    DFS_rec(noeuds[i], date, couleur, dateDecouverte, dateFin, predecesseurs);
                    Console.WriteLine("Relancement");
                }
            }
            for (int i = 0; i < idDepart - 1; i++)
            {
                if (couleur[i] == 0)
                {
                    DFS_rec(noeuds[i], date, couleur, dateDecouverte, dateFin, predecesseurs);
                    Console.WriteLine("Relancement");
                }
            }

            Console.WriteLine("Fin");
        }
        private void DFS_rec(Noeud s, int date, int[] couleur, int[] dateDecouverte, int[]dateFin, Noeud[] predecesseurs)
        {
            couleur[s.Id-1] = 1;    
            dateDecouverte[s.Id-1] = date;
            date++;

            Console.WriteLine("Visite du noeud " + s.Id);

            for (int i = 0; i < s.Liens.Count; i++)
            {
                Noeud v = s.Liens[i].Cible;

                if (couleur[v.Id - 1] == 0) 
                {
                    predecesseurs[v.Id - 1] = s; 
                    DFS_rec(v, date, couleur, dateDecouverte, dateFin, predecesseurs);    
                }
            }

            couleur[s.Id-1] = 2;
            dateFin[s.Id-1] = date;
            date++;
        }


        /// <summary>
        /// Algorithme de parcours en largeur d'un graph. Adaptation du pseudo code donné
        /// dans le cours d'algorithmique.
        /// 
        /// Affiche l'ensemble des noeuds connexes au noeud de départ dans l'ordre de découverte.
        /// </summary>
        /// <param name="idDepart">Noeud à partir duquel le BFS est lancé</param>
        public void BFS(int idDepart)
        {
            Console.WriteLine("\n\nParcours en largeur à partir du noeud " + idDepart + " :");

            
            int n = noeuds.Count;
            int[] couleur = new int[n];
            Noeud[] predecesseurs = new Noeud[n];
            Queue<Noeud> file = new Queue<Noeud>();


            for (int i = 0; i < n; i++)
            {
                predecesseurs[i] = null;
            }

            Noeud depart = noeuds[idDepart - 1];

            couleur[idDepart - 1] = 1;
            file.Enqueue(depart);

            while (file.Count > 0)
            {
                Noeud y = file.Dequeue();
                Console.Write(y.Id + " ");

                for (int i = 0; i < y.Liens.Count; i++)
                {
                    Noeud z = y.Liens[i].Cible;
                    if (couleur[z.Id - 1] == 0)
                    {
                        file.Enqueue(z);
                        couleur[z.Id - 1] = 1;
                        predecesseurs[z.Id - 1] = y;
                    }
                }

                couleur[y.Id - 1] = 2;
            }
        }

        #endregion
    }
}
