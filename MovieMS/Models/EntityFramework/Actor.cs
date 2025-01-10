namespace MovieMS.Models.EntityFramework;

public class Actor
{
    public int Id { get; set; } // Identifiant de l'acteur
    public string Name { get; set; } // Nom de l'acteur
    public string Character { get; set; } // Rôle joué dans le film
    public string ProfilePath { get; set; } // Photo de profil de l'acteur
    public double Popularity { get; set; } // Popularité de l'acteur
}