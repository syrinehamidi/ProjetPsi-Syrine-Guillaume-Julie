using System;
using System.Collections.Generic;
using System.IO;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace PSI_Rendu_1
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void TestMethodLien()
        {
            Graphe graphe = new Graphe();
            graphe.Noeuds.Clear();
            graphe.Lien.Clear();

            graphe.Noeuds.Add(new Noeud(1));
            graphe.Noeuds.Add(new Noeud(2));

            graphe.AjouterLien(1, 2);

            bool lienSourceCible = false;
            bool lienCibleSource = false;

            foreach (Lien lien in graphe.Lien)
            {
                if (lien.Source.Id == 1 && lien.Cible.Id == 2)
                {
                    lienSourceCible = true;
                }
                if (lien.Source.Id == 2 && lien.Cible.Id == 1)
                {
                    lienCibleSource = true;
                }
            }

            Assert.IsTrue(lienSourceCible);
            Assert.IsTrue(lienCibleSource);

            Assert.AreEqual(2, graphe.Lien.Count);
        }


        [TestMethod]
        public void TestMethodDFS()
        {
            Graphe graphe = new Graphe();
            graphe.Noeuds.Clear();
            graphe.Lien.Clear();

            graphe.Noeuds.Add(new Noeud(1));
            graphe.Noeuds.Add(new Noeud(2));
            graphe.Noeuds.Add(new Noeud(3));
            graphe.Noeuds.Add(new Noeud(4));

            graphe.AjouterLien(1, 2);
            graphe.AjouterLien(1, 3);
            graphe.AjouterLien(1, 4);
            graphe.AjouterLien(3, 4);


            StringWriter sortieConsole = new StringWriter();
            Console.SetOut(sortieConsole);

            graphe.DFS(3);

            string test = sortieConsole.ToString().Replace("\n", " ").Trim();

            Console.WriteLine(test);

            Assert.IsTrue(test.Contains("Début du parcours en profondeur à partir du noeud 3 :"));
            Assert.IsTrue(test.Contains("Visite du noeud 3"));
            Assert.IsTrue(test.Contains("Visite du noeud 1"));
            Assert.IsTrue(test.Contains("Visite du noeud 2"));
            Assert.IsTrue(test.Contains("Visite du noeud 4"));
            Assert.IsTrue(test.Contains("Fin"));
        }


        [TestMethod]

        public void TestMethodBFS()
        {
            Graphe graphe = new Graphe();
            graphe.Noeuds.Clear();
            graphe.Lien.Clear();

            graphe.Noeuds.Add(new Noeud(1));
            graphe.Noeuds.Add(new Noeud(2));
            graphe.Noeuds.Add(new Noeud(3));
            graphe.Noeuds.Add(new Noeud(4));

            graphe.AjouterLien(1, 2);
            graphe.AjouterLien(1, 3);
            graphe.AjouterLien(1, 4);
            graphe.AjouterLien(3, 4);



            StringWriter sortieConsole = new StringWriter();
            Console.SetOut(sortieConsole);

            graphe.BFS(3);

            string test = sortieConsole.ToString();

            Assert.IsTrue(test.Contains("\n\nParcours en largeur à partir du noeud 3 :"));
            Assert.IsTrue(test.Contains("3 1 4 2 "));
        }
    }
}
