namespace data.Models.DTO
{
    public class UserDTO
    {
        public int IdUser { get; set; }
        public string UserName { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string DateCreation { get; set; }
        public List<int> userInvitationId {  get; set; }
    }
}
