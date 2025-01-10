using data.Models.EntityFramework;

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

        public UserDTO(Users user)
        {
            this.IdUser = user.IdUser;
            this.UserName = user.UserName;
            this.FirstName = user.FirstName;
            this.LastName = user.LastName;
            this.Email = user.Email;
            this.DateCreation = user.DateCreation;

            this.userInvitationId = user.UserInvitation
                                        .Select(invite => invite.idEventsInvite)
                                        .ToList();
        }
    }
}
