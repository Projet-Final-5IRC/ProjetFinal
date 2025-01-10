namespace ms_recommend_net.Services
{
    using Apache.NMS;
    using Apache.NMS.ActiveMQ;

    public class ActiveMqService
    {
        private readonly string _brokerUri;
        private readonly string _queueName;

        public ActiveMqService(string brokerUri, string queueName)
        {
            _brokerUri = brokerUri;
            _queueName = queueName;
        }

        public void SendMessage(string messageText)
        {
            IConnectionFactory factory = new ConnectionFactory(_brokerUri);
            using (IConnection connection = factory.CreateConnection())
            using (ISession session = connection.CreateSession())
            {
                IDestination destination = session.GetQueue(_queueName);
                using (IMessageProducer producer = session.CreateProducer(destination))
                {
                    ITextMessage message = session.CreateTextMessage(messageText);
                    producer.Send(message);
                    Console.WriteLine($"Message envoyé : {messageText}");
                }
            }
        }

        public void StartReceivingMessages()
        {
            IConnectionFactory factory = new ConnectionFactory(_brokerUri);
            using (IConnection connection = factory.CreateConnection())
            using (ISession session = connection.CreateSession())
            {
                IDestination destination = session.GetQueue(_queueName);
                using (IMessageConsumer consumer = session.CreateConsumer(destination))
                {
                    connection.Start(); // Démarrer la connexion
                    Console.WriteLine("En attente des messages...");

                    while (true)
                    {
                        ITextMessage? message = consumer.Receive() as ITextMessage;
                        if (message != null)
                        {
                            Console.WriteLine($"Message reçu : {message.Text}");
                        }
                    }
                }
            }
        }
    }

}
