namespace ms_auth.Models.DTO
{
    public class UserEndDTO
    {
        public int idUser { get; set; }
        public string UserName { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string DateCreation { get; set; }

        public UserEndDTO(UserDTO userDTO)
        {
            idUser = userDTO.IdUser;
            UserName = userDTO.UserName;
            FirstName = userDTO.FirstName;
            LastName = userDTO.LastName;
            Email = userDTO.Email;
            DateCreation = userDTO.DateCreation;
        }
    }
}
