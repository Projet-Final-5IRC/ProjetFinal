namespace ms_evt.Models.Data
{
    public class MailData
    {
        public string EmailToId { get; set; }
        public string EmailToName { get; set; }
        public string EmailSubject { get; set; }
        public string EmailBody { get; set; }

        public MailData(string emailToId, string emailToName, string emailSubject, string emailBody)
        {
            EmailToId = emailToId;
            EmailToName = emailToName;
            EmailSubject = emailSubject;
            EmailBody = emailBody;
        }
    }
}
