using System.ComponentModel.DataAnnotations;
using System.Text.RegularExpressions;

namespace data.Models.EntityFramework.Complexity
{
    public class DateComplexity : ValidationAttribute
    {
        public override bool IsValid(object? value)
        {
            var date = value as string;

            if (string.IsNullOrWhiteSpace(date))
            {
                ErrorMessage = "La date ne peut pas être vide.";
                return false;
            }

            // Regex pour valider le format dd:mm:YYYY
            var regex = new Regex(@"^(0[1-9]|[12][0-9]|3[01]):(0[1-9]|1[0-2]):(\d{4})$");

            if (!regex.IsMatch(date))
            {
                ErrorMessage = "La date doit être au format dd:mm:YYYY (par exemple, 31:12:2025).";
                return false;
            }

            // Validation des jours en fonction des mois (exemple : 30 février est invalide)
            if (!DateTime.TryParseExact(date, "dd:MM:yyyy", null, System.Globalization.DateTimeStyles.None, out _))
            {
                ErrorMessage = "La date est invalide ou n'existe pas.";
                return false;
            }

            return true;
        }
    }
}
