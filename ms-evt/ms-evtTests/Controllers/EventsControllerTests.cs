using data.Models.EntityFramework;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using ms_evt.Controllers;
using ms_evt.Models.DataManager;
using ms_evt.Models.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ms_evt.Controllers.Tests
{
    [TestClass()]
    public class EventsControllerTests
    {
        private EventsController _controller;
        private EventsController _controller_Moq;
        private Mock<IDataRepository<Events>> _mockRepo;
        private IDataRepository<Events> dataRepository;
        private readonly EventDBContext _context;

        public EventsControllerTests()
        {
            var builder = new DbContextOptionsBuilder<EventDBContext>()
                .UseNpgsql("Server=localhost;port=5432;Database=EventsDB;uid=postgres;password=postgres;");
            _context = new EventDBContext(builder.Options);
            dataRepository = new EventsManager(_context);
            _controller = new EventsController(dataRepository);
        }

        //Tests Without MOQ

        [TestMethod]
        public async Task GetAllUtilisateurs_CompareWithDB()
        {
            var result = await _controller.GetEvent();
            var userInDB = _context.Event.ToList();


            Assert.IsNotNull(result);
            Assert.AreEqual(userInDB.Count, result.Value.Count());
        }

        //Tests With MOQ

        [TestInitialize]
        public void Setup()
        {
            _mockRepo = new Mock<IDataRepository<Events>>();
            _controller_Moq = new EventsController(_mockRepo.Object);
        }

        [TestMethod()]
        public async Task GetAllEvent()
        {
            var mockEvents = new List<Events>
            {
                new Events { IdEvent = 1, EventName = "Soirée Horreur", EventLocation = "Chez Maxime", EventDate = "19:06:2025", EventHour = "17:30", EventDescription = "KAKOU KAKOU" },
                new Events { IdEvent = 2, EventName = "Soirée Fiction", EventLocation = "Chez Louis", EventDate = "19:08:2025", EventHour = "19:30", EventDescription = "KAKOU KAKOU" }
            };

            _mockRepo.Setup(repo => repo.GetAllAsync())
                .ReturnsAsync(mockEvents);

            //Act
            var result = await _controller_Moq.GetEvent();
            var okResult = result.Value;

            //Assert
            Assert.IsNotNull(result);
            Assert.IsInstanceOfType(result.Value, typeof(List<Events>));
            Assert.AreEqual(2, okResult.Count());
            Assert.AreEqual("Soirée Horreur", okResult.First().EventName);
        }
    }
}