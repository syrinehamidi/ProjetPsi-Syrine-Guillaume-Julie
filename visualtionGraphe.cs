using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Vraipsi
{
    public class VisualisationGraphe
    {
        private Graphe graphe;
        private int largeur = 1000;  // Plus large pour plus d'espacement
        private int hauteur = 1000;
        private int rayonNoeud = 35; // Taille augmentée pour plus de clarté

        public VisualisationGraphe(Graphe graphe)
        {
            this.graphe = graphe;
        }

        public void DessinerGraphe(string filePath)
        {
            Bitmap bitmap = new Bitmap(largeur, hauteur);
            Graphics g = Graphics.FromImage(bitmap);

            // Améliorer la qualité de rendu
            g.SmoothingMode = SmoothingMode.AntiAlias;
            g.Clear(Color.White);

            // Placement circulaire des nœuds avec un rayon plus large
            PointF[] positions = new PointF[graphe.Noeuds.Count];
            double angle = 2 * Math.PI / graphe.Noeuds.Count;
            int centreX = largeur / 2;
            int centreY = hauteur / 2;
            int rayon = Math.Min(largeur, hauteur) / 2 - 100; // Espace plus grand

            for (int i = 0; i < graphe.Noeuds.Count; i++)
            {
                float x = centreX + (float)(rayon * Math.Cos(i * angle));
                float y = centreY + (float)(rayon * Math.Sin(i * angle));
                positions[i] = new PointF(x, y);
            }

            // Dessiner les liens (en arrière-plan, plus fins et transparents)
            Pen pen = new Pen(Color.LightGray, 1.5f); // Couleur plus claire et plus fine
            pen.DashStyle = DashStyle.Solid; // Style de ligne (peut être Dash pour des pointillés)

            foreach (var lien in graphe.Lien)
            {
                PointF p1 = positions[lien.Source.Id - 1];
                PointF p2 = positions[lien.Cible.Id - 1];
                g.DrawLine(pen, p1, p2);
            }

            // Dessiner les nœuds en noir
            Font font = new Font("Arial", 12, FontStyle.Bold);
            Brush brushNoeud = Brushes.Black;
            Brush brushTexte = Brushes.White;

            for (int i = 0; i < graphe.Noeuds.Count; i++)
            {
                PointF p = positions[i];

                // Dessiner le cercle du nœud
                g.FillEllipse(brushNoeud, p.X - rayonNoeud / 2, p.Y - rayonNoeud / 2, rayonNoeud, rayonNoeud);

                // Dessiner l'ID du nœud (centré)
                string texte = (i + 1).ToString();
                SizeF textSize = g.MeasureString(texte, font);
                g.DrawString(texte, font, brushTexte, p.X - textSize.Width / 2, p.Y - textSize.Height / 2);
            }

            // Sauvegarde de l'image
            bitmap.Save(filePath, ImageFormat.Png);
            g.Dispose();
            bitmap.Dispose();

            Console.WriteLine($"Le graphe a été dessiné et enregistré sous {filePath}");
        }
    }
}



