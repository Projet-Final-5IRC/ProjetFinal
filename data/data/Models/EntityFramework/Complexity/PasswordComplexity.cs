using System.ComponentModel.DataAnnotations;
using System.Text.RegularExpressions;

namespace data.Models.EntityFramework.Complexity
{
    public class PasswordComplexity : ValidationAttribute
    {
        public override bool IsValid(object? value)
        {
            var password = value as string;

            if (string.IsNullOrWhiteSpace(password)) return false;

            // Check length
            if (password.Length < 6 || password.Length > 10)
            {
                ErrorMessage = "Le mot de passe doit contenir entre 6 et 10 caractères.";
                return false;
            }

            // Check special char
            bool hasUpperCase = Regex.IsMatch(password, @"[A-Z]");
            bool hasDigit = Regex.IsMatch(password, @"\d");
            bool hasSpecialChar = Regex.IsMatch(password, @"[^\w\d]");

            if (!hasUpperCase || !hasDigit || !hasSpecialChar)
            {
                ErrorMessage = "Le mot de passe doit contenir au moins 1 lettre en majuscule, 1 chiffre et 1 caractère spécial.";
                return false;
            }

            return true;
        }
    }

}