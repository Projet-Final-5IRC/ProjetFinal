using System.ComponentModel.DataAnnotations;
using System.Text.RegularExpressions;

namespace ms_evt.Models.EntityFramework.Complexity
{
    public class HourComplexity : ValidationAttribute
    {
        public override bool IsValid(object? value)
        {
            var time = value as string;

            if (string.IsNullOrWhiteSpace(time))
            {
                ErrorMessage = "L'heure ne peut pas être vide.";
                return false;
            }

            // Regex pour valider le format HH:mm
            var regex = new Regex(@"^(?:[01]\d|2[0-3]):[0-5]\d$");

            if (!regex.IsMatch(time))
            {
                ErrorMessage = "L'heure doit être au format HH:mm (par exemple, 14:30).";
                return false;
            }

            return true;
        }
    }
}
