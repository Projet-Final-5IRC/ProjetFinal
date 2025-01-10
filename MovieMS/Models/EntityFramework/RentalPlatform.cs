namespace MovieMS.Models.EntityFramework;

public class RentalPlatform
{
    public string ProviderName { get; set; }
    public string LogoPath { get; set; }
    public string Type { get; set; } // rent, buy, flatrate
    public string TmdbLink { get; set; } // Lien vers TMDb pour le contenu
    
}