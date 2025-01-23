﻿using MailKit.Net.Smtp;
using Microsoft.Extensions.Options;
using MimeKit;
using ms_evt.Models.Data;

namespace ms_evt.Services
{
    public class MailService : IMailService
    {
        MailSettings Mail_Settings = null;
        public MailService(IOptions<MailSettings> options)
        {
            Mail_Settings = options.Value;
        }
        public bool SendMail(MailData Mail_Data)
        {
            try
            {
                //MimeMessage - a class from Mimekit
                MimeMessage email_Message = new MimeMessage();
                MailboxAddress email_From = new MailboxAddress(Mail_Settings.SenderName, Mail_Settings.SenderEmail);
                email_Message.From.Add(email_From);
                MailboxAddress email_To = new MailboxAddress(Mail_Data.EmailToName, Mail_Data.EmailToId);
                email_Message.To.Add(email_To);
                email_Message.Subject = Mail_Data.EmailSubject;
                BodyBuilder emailBodyBuilder = new BodyBuilder();
                emailBodyBuilder.TextBody = Mail_Data.EmailBody;
                email_Message.Body = emailBodyBuilder.ToMessageBody();
                //this is the SmtpClient class from the Mailkit.Net.Smtp namespace, not the System.Net.Mail one
                SmtpClient MailClient = new SmtpClient();
                MailClient.Connect(Mail_Settings.Server, Mail_Settings.Port);
                MailClient.Authenticate(Mail_Settings.UserName, Mail_Settings.Password);
                MailClient.Send(email_Message);
                MailClient.Disconnect(true);
                MailClient.Dispose();
                return true;
            }
            catch (Exception ex)
            {
                // Exception Details
                return false;
            }
        }
    }
}
