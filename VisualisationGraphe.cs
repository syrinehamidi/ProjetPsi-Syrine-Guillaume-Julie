using PSI_Rendu_1;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PSI_Rendu_1
{
    public class VisualisationGraphe
    {
        /// <summary>
        /// Classe permettant la visualisation et le dessin d'un graphe sous forme d'image
        /// </summary>
        private Graphe graphe;
        private int largeur = 1000;
        private int hauteur = 1000;
        private int rayonNoeud = 35;

        /// <summary>
        /// Initialise une nouvelle instance de la classe VisualisationGraphe avec un graphe donné.
        /// </summary>
        /// <param name="graphe">Le graphe à visualiser.</param>
        public VisualisationGraphe(Graphe graphe)
        {
            this.graphe = graphe;
        }

        /// <summary>
        ///  Dessine le graphe et l'enregistre sous forme d'image etant générée sous un chemin spécifique.
        ///  Améliore la qualité du rendu pour un meilleur affichage.
        ///  Calcule les positions des nœuds en les disposant en cercle.
        ///  Dessine les liens entre les nœuds et les nœuds sous forme de cercles colorés.
        ///  Dessine le cercle représentant le nœud et affiche l'ID du nœud au centre du cercle.
        /// </summary>
        /// <param name="filePath">Le chemin où enregistrer l'image.</param>
        public void DessinerGraphe(string filePath)
        {
            Bitmap bitmap = new Bitmap(largeur, hauteur);
            Graphics g = Graphics.FromImage(bitmap);


            g.SmoothingMode = SmoothingMode.AntiAlias;
            g.Clear(Color.White);


            PointF[] positions = new PointF[graphe.Noeuds.Count];
            double angle = 2 * Math.PI / graphe.Noeuds.Count;
            int centreX = largeur / 2;
            int centreY = hauteur / 2;
            int rayon = Math.Min(largeur, hauteur) / 2 - 100;

            for (int i = 0; i < graphe.Noeuds.Count; i++)
            {
                float x = centreX + (float)(rayon * Math.Cos(i * angle));
                float y = centreY + (float)(rayon * Math.Sin(i * angle));
                positions[i] = new PointF(x, y);
            }


            Pen pen = new Pen(Color.LightGray, 1.5f);
            pen.DashStyle = DashStyle.Solid;

            foreach (var lien in graphe.Lien)
            {
                PointF p1 = positions[lien.Source.Id - 1];
                PointF p2 = positions[lien.Cible.Id - 1];
                g.DrawLine(pen, p1, p2);
            }


            Font font = new Font("Arial", 12, FontStyle.Bold);
            Brush brushNoeud = Brushes.Pink;
            Brush brushTexte = Brushes.White;

            for (int i = 0; i < graphe.Noeuds.Count; i++)
            {
                PointF p = positions[i];


                g.FillEllipse(brushNoeud, p.X - rayonNoeud / 2, p.Y - rayonNoeud / 2, rayonNoeud, rayonNoeud);


                string texte = (i + 1).ToString();
                SizeF textSize = g.MeasureString(texte, font);
                g.DrawString(texte, font, brushTexte, p.X - textSize.Width / 2, p.Y - textSize.Height / 2);
            }


            bitmap.Save(filePath, ImageFormat.Png);
            g.Dispose();
            bitmap.Dispose();

            Console.WriteLine($"Le graphe a été dessiné et enregistré sous {filePath}");
        }
    }
}
