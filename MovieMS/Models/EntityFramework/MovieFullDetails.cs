namespace MovieMS.Models.EntityFramework;

public class MovieFullDetails
{
    public MovieDetails Details { get; set; } // Détails du film
    public List<Actor> Actors { get; set; } // Liste des acteurs
}