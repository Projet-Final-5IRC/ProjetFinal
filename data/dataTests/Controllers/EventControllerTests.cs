using Microsoft.VisualStudio.TestTools.UnitTesting;
using data.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using data.Models.EntityFramework;
using Microsoft.EntityFrameworkCore;
using data.Models.Repository;
using data.Models.DataManager;
using Moq;
using Microsoft.AspNetCore.Mvc;
using data.Models.DTO;

namespace data.Controllers.Tests
{
    [TestClass()]
    public class EventControllerTests
    {
        private EventController _controller;
        private readonly EventDBContext _context;
        private IDataRepository<Events> dataRepository;

        private EventController _controller_Moq;
        private Mock<IDataRepository<Events>> _mockRepo;

        public EventControllerTests()
        {
            var builder = new DbContextOptionsBuilder<EventDBContext>()
                .UseNpgsql("Server=localhost;port=5432;Database=EventsDB;uid=postgres;password=postgres;");
            _context = new EventDBContext(builder.Options);
            dataRepository = new EventsManager(_context);
            _controller = new EventController(dataRepository);
        }

        //------------------------------------
        // Tests without MOQ
        //------------------------------------

        [TestMethod()]
        public async Task GetEventTest_CompareWithDB()
        {
            var result = await _controller.GetEvent();
            var eventInDB = _context.Event.ToList();

            Assert.IsNotNull(result);
            Assert.AreEqual(eventInDB.Count,result.Value.Count());
        }

        [TestMethod]
        public async Task GetEventByID_SuccessGetEventByID()
        {
            var result = await _controller.GetEventById(1);
            var eventInDB = _context.Event.Where(c => c.IdEvent == 1).FirstOrDefault();

            Assert.AreEqual(eventInDB.EventName, result.Value.EventName);
        }

        [TestMethod]
        public async Task GetEventByID_EventNotFound()
        {
            var result = await _controller.GetEventById(9999);
            Assert.IsInstanceOfType(result.Result, typeof(NotFoundResult));
        }

        //------------------------------------
        //Tests With MOQ
        //------------------------------------

        [TestInitialize]
        public void Setup()
        {
            _mockRepo = new Mock<IDataRepository<Events>>();
            _controller_Moq = new EventController(_mockRepo.Object);
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
            Assert.IsInstanceOfType(result.Value, typeof(List<EventDTO>));
            Assert.AreEqual(2, okResult.Count());
            Assert.AreEqual("Soirée Horreur", okResult.First().EventName);
        }

        [TestMethod]
        public async Task PostEvents_Success()
        {
            // Arrange
            var newEvent = new Events
            {
                EventName = "Concert",
                EventLocation = "Stadium",
                EventDate = "19:06:2002",
                EventHour = "20:00",
                EventDescription = "Music concert"
            };

            _mockRepo.Setup(repo => repo.AddAsync(newEvent)).ReturnsAsync(new ActionResult<Events>(newEvent));

            // Act
            var result = await _controller_Moq.PostEvents(newEvent);
            var createdResult = result.Result as CreatedAtActionResult;

            // Assert
            Assert.IsNotNull(createdResult);
            Assert.AreEqual(201, createdResult.StatusCode); // HTTP 201 Created
            Assert.AreEqual("GetEventById", createdResult.ActionName);
            Assert.AreEqual(newEvent.IdEvent, ((EventDTO)createdResult.Value).IdEvent);
        }

        [TestMethod]
        public async Task PostEvents_ModelStateInvalid()
        {
            // Arrange
            var invalidEvent = new Events(); // Missing required fields
            _controller_Moq.ModelState.AddModelError("EventName", "The EventName field is required.");

            // Act
            var result = await _controller_Moq.PostEvents(invalidEvent);
            var badRequestResult = result.Result as BadRequestObjectResult;

            // Assert
            Assert.IsNotNull(badRequestResult);
            Assert.AreEqual(400, badRequestResult.StatusCode); // HTTP 400 Bad Request
            Assert.IsTrue(badRequestResult.Value is SerializableError);
        }

        [TestMethod]
        public async Task PutEvents_Success()
        {
            // Arrange
            var existingEvent = new Events { IdEvent = 1, EventName = "Concert" };
            var updatedEvent = new Events { IdEvent = 1, EventName = "Updated Concert" };

            _mockRepo.Setup(repo => repo.GetByIdAsync(1)).ReturnsAsync(existingEvent);
            _mockRepo.Setup(repo => repo.UpdateAsync(It.IsAny<Events>(), It.IsAny<Events>()))
                .Callback<Events, Events>((original, updated) =>
                {
                    original.EventName = updated.EventName;
                    original.EventDescription = updated.EventDescription;
                    original.EventDate = updated.EventDate;
                    original.EventHour = updated.EventHour;
                    original.EventLocation = updated.EventLocation;
                    original.EventInvitation = updated.EventInvitation;
                    original.IdGenre = updated.IdGenre;
                    original.GenreEvent = updated.GenreEvent;
                })
                .ReturnsAsync(new ActionResult<Events>(updatedEvent));

            // Act
            var result = await _controller_Moq.PutEvents(1, updatedEvent);
            var verif = await _controller_Moq.GetEventById(1);

            // Assert
            Assert.IsInstanceOfType(result.Value, typeof(EventDTO));
            Assert.AreEqual(updatedEvent.EventName, verif.Value.EventName);
        }

        [TestMethod]
        public async Task PutEvents_IdMismatch()
        {
            // Arrange
            var updatedEvent = new Events { IdEvent = 2, EventName = "Updated Concert" };

            // Act
            var result = await _controller_Moq.PutEvents(1, updatedEvent);

            // Assert
            Assert.IsInstanceOfType(result.Result, typeof(BadRequestResult));
        }

        [TestMethod]
        public async Task PutEvents_EventNotFound()
        {
            // Arrange
            _mockRepo.Setup(repo => repo.GetByIdAsync(9999)).ReturnsAsync((Events)null);

            var updatedEvent = new Events { IdEvent = 9999, EventName = "Updated Concert" };

            // Act
            var result = await _controller_Moq.PutEvents(9999, updatedEvent);

            // Assert
            Assert.IsInstanceOfType(result.Result, typeof(NotFoundResult));
        }

        [TestMethod]
        public async Task DeleteEvents_Success()
        {
            // Arrange
            var mockEvents = new List<Events>
            {
                new Events { IdEvent = 1, EventName = "Concert" },
                new Events { IdEvent = 2, EventName = "Festival" }
            };

            _mockRepo.Setup(repo => repo.GetByIdAsync(1))
                .ReturnsAsync(mockEvents.FirstOrDefault(e => e.IdEvent == 1));

            _mockRepo.Setup(repo => repo.DeleteAsync(It.IsAny<Events>()))
                .Callback<Events>(e => mockEvents.Remove(e))
                .ReturnsAsync(new NoContentResult());

            // Act
            var result = await _controller_Moq.DeleteEvents(1);
            var verif = mockEvents.FirstOrDefault(e => e.IdEvent == 1);

            // Assert
            Assert.IsInstanceOfType(result, typeof(NoContentResult));
            Assert.IsNull(verif); // Ensure the event is deleted
        }

        [TestMethod]
        public async Task DeleteEvents_EventNotFound()
        {
            // Arrange
            _mockRepo.Setup(repo => repo.GetByIdAsync(9999)).ReturnsAsync((Events)null);

            // Act
            var result = await _controller_Moq.DeleteEvents(9999);

            // Assert
            Assert.IsInstanceOfType(result, typeof(NotFoundObjectResult));
            var notFoundResult = result as NotFoundObjectResult;
            Assert.AreEqual("Event not found!", notFoundResult.Value);
        }
    }
}