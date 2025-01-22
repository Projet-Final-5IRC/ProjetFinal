using ms_evt.Models.Data;

namespace ms_evt.Services
{
    public interface IMailService
    {
        bool SendMail(MailData Mail_Data);
    }
}
