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



            Console.WriteLine();
        }
    }
}
