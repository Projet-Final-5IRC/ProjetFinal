using Microsoft.VisualStudio.TestTools.UnitTesting;
using data.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using data.Models.DataManager;
using data.Models.DTO;
using data.Models.EntityFramework;
using data.Models.Repository;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Moq;
using Microsoft.Extensions.Configuration;

namespace data.Controllers.Tests
{
    [TestClass()]
    public class EventInviteControllerTests
    {
        private EventInviteController _controller;
        private readonly EventDBContext _context;
        private IDataRepository<EventsInvite> dataRepository;

        private EventInviteController _controller_Moq;
        private Mock<IDataRepository<EventsInvite>> _mockRepo;

        public EventInviteControllerTests()
        {
            var builder = new DbContextOptionsBuilder<EventDBContext>()
                .UseNpgsql("Server=projet-final.postgres.database.azure.com; port=5432; Database=EventsDB; uid=projectAdmin; password=5IRCCPELyon");

            _context = new EventDBContext(builder.Options);
            dataRepository = new EventsInviteManager(_context);
            _controller = new EventInviteController(dataRepository);
        }
        //------------------------------------
        // Tests without MOQ
        //------------------------------------

        [TestMethod()]
        public async Task GetInviteTest_CompareWithDB()
        {
            var result = await _controller.GetInvites();
            var invitInDB = _context.EventInvite.ToList();

            Assert.IsNotNull(result);
            Assert.AreEqual(invitInDB.Count, result.Value.Count());
        }

        [TestMethod]
        public async Task GetInviteByID_SuccessGetInviteByID()
        {
            var result = await _controller.GetInviteById(3);
            var invitInDB = _context.EventInvite.Where(c => c.idEventsInvite == 3).FirstOrDefault();

            Assert.IsNotNull(result);
            Assert.AreEqual(invitInDB.idEventsInvite, result.Value.IdEventsInvite);
        }

        [TestMethod]
        public async Task GetInviteByID_InviteNotFound()
        {
            var result = await _controller.GetInviteById(9999);

            Assert.IsNotNull(result);
            Assert.IsInstanceOfType(result.Result, typeof(NotFoundResult));
        }

        //------------------------------------
        //Tests With MOQ
        //------------------------------------

        [TestInitialize]
        public void Setup()
        {
            _mockRepo = new Mock<IDataRepository<EventsInvite>>();
            _controller_Moq = new EventInviteController(_mockRepo.Object);
        }

        [TestMethod()]
        public async Task GetAllInvites()
        {
            var mockInvite = new List<EventsInvite>
            {
                new EventsInvite { idEventsInvite = 1, IdEvent = 1, IdUser = 1 },
                new EventsInvite { idEventsInvite = 2, IdEvent = 1, IdUser = 2 }
            };

            _mockRepo.Setup(repo => repo.GetAllAsync())
                .ReturnsAsync(mockInvite);

            //Act
            var result = await _controller_Moq.GetInvites();
            var okResult = result.Value;

            //Assert
            Assert.IsNotNull(result);
            Assert.IsInstanceOfType(result.Value, typeof(List<EventInviteDTO>));
            Assert.AreEqual(2, okResult.Count());
            Assert.AreEqual(1, okResult.First().IdUser);
        }

        [TestMethod]
        public async Task PostInvite_Success()
        {
            // Arrange
            var newInvite = new EventsInvite
            {
                IdEvent = 1,
                IdUser = 1
            };

            _mockRepo.Setup(repo => repo.AddAsync(newInvite)).ReturnsAsync(new ActionResult<EventsInvite>(newInvite));

            // Act
            var result = await _controller_Moq.PostInvite(newInvite);
            var createdResult = result.Result as CreatedAtActionResult;

            // Assert
            Assert.IsNotNull(createdResult);
            Assert.AreEqual(201, createdResult.StatusCode); // HTTP 201 Created
            Assert.AreEqual("GetInviteById", createdResult.ActionName);
            Assert.AreEqual(newInvite.idEventsInvite, ((EventInviteDTO)createdResult.Value).IdEventsInvite);
        }

        [TestMethod]
        public async Task PostInvite_ModelStateInvalid()
        {
            // Arrange
            var invalideGenre = new EventsInvite(); // Missing required fields
            _controller_Moq.ModelState.AddModelError("IdEvent", "The IdEvent field is required.");

            // Act
            var result = await _controller_Moq.PostInvite(invalideGenre);
            var badRequestResult = result.Result as BadRequestObjectResult;

            // Assert
            Assert.IsNotNull(badRequestResult);
            Assert.AreEqual(400, badRequestResult.StatusCode); // HTTP 400 Bad Request
            Assert.IsTrue(badRequestResult.Value is SerializableError);
        }

        [TestMethod]
        public async Task PutInvite_Success()
        {
            // Arrange
            var existingInvite = new EventsInvite { idEventsInvite = 1, IdUser = 1, IdEvent = 2};
            var updatedInvite = new EventsInvite { idEventsInvite = 1, IdUser = 2, IdEvent = 1 };

            _mockRepo.Setup(repo => repo.GetByIdAsync(1)).ReturnsAsync(existingInvite);
            _mockRepo.Setup(repo => repo.UpdateAsync(It.IsAny<EventsInvite>(), It.IsAny<EventsInvite>()))
                .Callback<EventsInvite, EventsInvite>((original, updated) =>
                {
                    original.IdEvent = updated.IdEvent;
                    original.IdUser = updated.IdUser;
                })
                .ReturnsAsync(new ActionResult<EventsInvite>(existingInvite));

            // Act
            var result = await _controller_Moq.PutInvite(1, updatedInvite);
            var verif = await _controller_Moq.GetInviteById(1);

            // Assert
            Assert.IsInstanceOfType(result.Value, typeof(EventInviteDTO));
            Assert.AreEqual(updatedInvite.idEventsInvite, verif.Value.IdEventsInvite);
        }

        [TestMethod]
        public async Task PutInvite_IdMismatch()
        {
            // Arrange
            var updatedInvite = new EventsInvite { idEventsInvite = 2, IdEvent = 1, IdUser = 1 };

            // Act
            var result = await _controller_Moq.PutInvite(1, updatedInvite);

            // Assert
            Assert.IsInstanceOfType(result.Result, typeof(BadRequestResult));
        }

        [TestMethod]
        public async Task PutInvite_EventNotFound()
        {
            // Arrange
            _mockRepo.Setup(repo => repo.GetByIdAsync(9999)).ReturnsAsync((EventsInvite)null);

            var updatedInvite = new EventsInvite { idEventsInvite = 9999, IdEvent = 1, IdUser = 1 };

            // Act
            var result = await _controller_Moq.PutInvite(9999, updatedInvite);

            // Assert
            Assert.IsInstanceOfType(result.Result, typeof(NotFoundResult));
        }

        [TestMethod]
        public async Task DeleteInvite_Success()
        {
            // Arrange
            var mockInvite = new List<EventsInvite>
            {
                new EventsInvite { idEventsInvite = 1, IdEvent = 1, IdUser = 1 },
                new EventsInvite { idEventsInvite = 2, IdEvent = 1, IdUser = 2 }
            };

            _mockRepo.Setup(repo => repo.GetByIdAsync(1))
                .ReturnsAsync(mockInvite.FirstOrDefault(e => e.idEventsInvite == 1));

            _mockRepo.Setup(repo => repo.DeleteAsync(It.IsAny<EventsInvite>()))
                .Callback<EventsInvite>(e => mockInvite.Remove(e))
                .ReturnsAsync(new NoContentResult());

            // Act
            var result = await _controller_Moq.DeleteInvite(1);
            var verif = mockInvite.FirstOrDefault(e => e.idEventsInvite == 1);

            // Assert
            Assert.IsInstanceOfType(result, typeof(NoContentResult));
            Assert.IsNull(verif);
        }

        [TestMethod]
        public async Task DeleteGenres_GenreNotFound()
        {
            // Arrange
            _mockRepo.Setup(repo => repo.GetByIdAsync(9999)).ReturnsAsync((EventsInvite)null);

            // Act
            var result = await _controller_Moq.DeleteInvite(9999);

            // Assert
            Assert.IsInstanceOfType(result, typeof(NotFoundObjectResult));
            var notFoundResult = result as NotFoundObjectResult;
            Assert.AreEqual("Invite not found!", notFoundResult.Value);
        }
    }
}