using System.Diagnostics;

namespace PSI_Rendu_1
{
    public class Program
    {
        static void Main(string[] args)
        {
            Graphe karate = new Graphe();



            Console.WriteLine("\n\nMatrice d'adjacence : \n");

            for (int i = 0; i < karate.Noeuds.Count; i++)
            {
                for (int j = 0; j < karate.Noeuds.Count; j++)
                {
                    Console.Write(karate.MatriceAdjacence[i, j] + " ");
                }
                Console.WriteLine();
            }




            Console.WriteLine("\n\nListe d'adjacence : \n");

            for (int i = 0; i < karate.Noeuds.Count; i++)
            {
                for (int j = 0; j < karate.Noeuds[i].Liens.Count; j++)
                {
                    Console.Write(karate.ListeAdjacence[i][j] + " ");
                }
                Console.WriteLine();
            }


            karate.DFS(1);

            karate.BFS(4);

            Console.WriteLine("\n\nLe graph karaté contient des cycle ? -> " + karate.ContientCycle());


            Console.WriteLine("\n\n");


            

            VisualisationGraphe visualisationKarate = new VisualisationGraphe(karate);


            visualisationKarate.DessinerGraphe("graphe.png");

            Console.WriteLine("\nLe graphe a été enregistré sous 'graphe.png'");

            
            Process.Start(new ProcessStartInfo("graphe.png") { UseShellExecute = true });
        }
    }
}
