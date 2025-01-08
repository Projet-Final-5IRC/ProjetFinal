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
public class UserControllerTests
{
        private UserController _controller;
        private readonly EventDBContext _context;
        private IDataRepositoryWithEmail<Users> dataRepository;

        private UserController _controller_Moq;
        private Mock<IDataRepositoryWithEmail<Users>> _mockRepo;

        public UserControllerTests()
        {
            var configuration = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json")
                .Build();

            var connectionString = configuration.GetConnectionString("EventDB");

            var builder = new DbContextOptionsBuilder<EventDBContext>()
                .UseNpgsql(connectionString);

            _context = new EventDBContext(builder.Options);
            dataRepository = new UsersManager(_context);
            _controller = new UserController(dataRepository);
        }
        //------------------------------------
        // Tests without MOQ
        //------------------------------------

        [TestMethod()]
        public async Task GetUserTest_CompareWithDB()
        {
            var result = await _controller.GetUsers();
            var userInDB = _context.User.ToList();

            Assert.IsNotNull(result);
            Assert.AreEqual(userInDB.Count, result.Value.Count());
        }

        [TestMethod]
        public async Task GetUserByID_SuccessGetUserByID()
        {
            var result = await _controller.GetUserById(1);
            var userInDB = _context.User.Where(c => c.IdUser == 1).FirstOrDefault();

            Assert.IsNotNull(result);
            Assert.AreEqual(userInDB.IdUser, result.Value.IdUser);
        }

        [TestMethod]
        public async Task GetUserByID_UserNotFound()
        {
            var result = await _controller.GetUserById(9999);

            Assert.IsNotNull(result);
            Assert.IsInstanceOfType(result.Result, typeof(NotFoundResult));
        }

        //------------------------------------
        //Tests With MOQ
        //------------------------------------

        [TestInitialize]
        public void Setup()
        {
            _mockRepo = new Mock<IDataRepositoryWithEmail<Users>>();
            _controller_Moq = new UserController(_mockRepo.Object);
        }

        [TestMethod()]
        public async Task GetAllUser()
        {
            var mockUser = new List<Users>
        {
            new Users { IdUser = 1, UserName = "Planche_", Email = "user@mail.com", FirstName = "Maxime", LastName = "BROSSARD", Password = "TESt&12", DateCreation = "19:06:2025" },
            new Users { IdUser = 2, UserName = "KAKOU", Email = "user2@mail.com", FirstName = "Julien", LastName = "PUC", Password = "TESt&12", DateCreation = "19:06:2024" }
        };

            _mockRepo.Setup(repo => repo.GetAllAsync())
                .ReturnsAsync(mockUser);

            //Act
            var result = await _controller_Moq.GetUsers();
            var okResult = result.Value;

            //Assert
            Assert.IsNotNull(result);
            Assert.IsInstanceOfType(result.Value, typeof(List<UserDTO>));
            Assert.AreEqual(2, okResult.Count());
            Assert.AreEqual(1, okResult.First().IdUser);
        }

        [TestMethod]
        public async Task PostUser_Success()
        {
            // Arrange
            var newUser = new Users
            {
                IdUser = 1,
                UserName = "Planche_",
                Email = "user5@mail.com",
                FirstName = "Maxime",
                LastName = "BROSSARD",
                Password = "TESt&12",
                DateCreation = "19:06:2025"
            };

            _mockRepo.Setup(repo => repo.AddAsync(newUser)).ReturnsAsync(new ActionResult<Users>(newUser));

            // Act
            var result = await _controller_Moq.PostUser(newUser);
            var createdResult = result.Result as CreatedAtActionResult;

            // Assert
            Assert.IsNotNull(createdResult);
            Assert.AreEqual(201, createdResult.StatusCode); // HTTP 201 Created
            Assert.AreEqual("GetUserById", createdResult.ActionName);
            Assert.AreEqual(newUser.IdUser, ((UserDTO)createdResult.Value).IdUser);
        }

        [TestMethod]
        public async Task PostUser_ModelStateInvalid()
        {
            // Arrange
            var invalideUser = new Users(); // Missing required fields
            _controller_Moq.ModelState.AddModelError("email", "The email field is required.");

            // Act
            var result = await _controller_Moq.PostUser(invalideUser);
            var badRequestResult = result.Result as BadRequestObjectResult;

            // Assert
            Assert.IsNotNull(badRequestResult);
            Assert.AreEqual(400, badRequestResult.StatusCode); // HTTP 400 Bad Request
            Assert.IsTrue(badRequestResult.Value is SerializableError);
        }

        [TestMethod]
        public async Task PutUser_Success()
        {
            // Arrange
            var existingUser = new Users { IdUser= 1, UserName = "Planche_", Email = "user@mail.com", FirstName = "Maxime", LastName = "BROSSARD", Password = "TESt&12", DateCreation = "19:06:2025" };
            var updatedUser = new Users { IdUser = 1, UserName = "Planche_", Email = "user2@mail.com", FirstName = "Maxime", LastName = "BROSSARD", Password = "TESt&12", DateCreation = "19:06:2025" };

            _mockRepo.Setup(repo => repo.GetByIdAsync(1)).ReturnsAsync(existingUser);
            _mockRepo.Setup(repo => repo.UpdateAsync(It.IsAny<Users>(), It.IsAny<Users>()))
                .Callback<Users, Users>((original, updated) =>
                {
                    original.UserName = updated.UserName;
                    original.Email = updated.Email;
                    original.FirstName = updated.FirstName;
                    original.LastName = updated.LastName;
                    original.Password = updated.Password;
                    original.DateCreation = updated.DateCreation;
                })
                .ReturnsAsync(new ActionResult<Users>(existingUser));

            // Act
            var result = await _controller_Moq.PutUsers(1, updatedUser);
            var verif = await _controller_Moq.GetUserById(1);

            // Assert
            Assert.IsInstanceOfType(result.Value, typeof(UserDTO));
            Assert.AreEqual(updatedUser.IdUser, verif.Value.IdUser);
        }

        [TestMethod]
        public async Task PutUser_IdMismatch()
        {
            // Arrange
            var updatedUser = new Users { UserName = "Planche_", Email = "user7@mail.com", FirstName = "Maxime", LastName = "BROSSARD", Password = "TESt&12", DateCreation = "19:06:2025" };

            // Act
            var result = await _controller_Moq.PutUsers(1, updatedUser);

            // Assert
            Assert.IsInstanceOfType(result.Result, typeof(BadRequestResult));
        }

        [TestMethod]
        public async Task PutUser_EventNotFound()
        {
            // Arrange
            _mockRepo.Setup(repo => repo.GetByIdAsync(9999)).ReturnsAsync((Users)null);

            var updatedUser = new Users {IdUser = 9999, UserName = "Planche_", Email = "user8@mail.com", FirstName = "Maxime", LastName = "BROSSARD", Password = "TESt&12", DateCreation = "19:06:2025" };

            // Act
            var result = await _controller_Moq.PutUsers(9999, updatedUser);

            // Assert
            Assert.IsInstanceOfType(result.Result, typeof(NotFoundResult));
        }

        [TestMethod]
        public async Task DeleteUser_Success()
        {
            // Arrange
            var mockUser = new List<Users>
        {
            new Users { IdUser = 1, UserName = "Planche_", Email = "user@mail.com", FirstName = "Maxime", LastName = "BROSSARD", Password = "TESt&12", DateCreation = "19:06:2025" },
            new Users { IdUser = 2, UserName = "KAKOU", Email = "user2@mail.com", FirstName = "Julien", LastName = "PUC", Password = "TESt&12", DateCreation = "19:06:2024" }
        };

            _mockRepo.Setup(repo => repo.GetByIdAsync(1))
                .ReturnsAsync(mockUser.FirstOrDefault(e => e.IdUser == 1));

            _mockRepo.Setup(repo => repo.DeleteAsync(It.IsAny<Users>()))
                .Callback<Users>(e => mockUser.Remove(e))
                .ReturnsAsync(new NoContentResult());

            // Act
            var result = await _controller_Moq.DeleteUser(1);
            var verif = mockUser.FirstOrDefault(e => e.IdUser == 1);

            // Assert
            Assert.IsInstanceOfType(result, typeof(NoContentResult));
            Assert.IsNull(verif);
        }

        [TestMethod]
        public async Task DeleteGenres_GenreNotFound()
        {
            // Arrange
            _mockRepo.Setup(repo => repo.GetByIdAsync(9999)).ReturnsAsync((Users)null);

            // Act
            var result = await _controller_Moq.DeleteUser(9999);

            // Assert
            Assert.IsInstanceOfType(result, typeof(NotFoundObjectResult));
            var notFoundResult = result as NotFoundObjectResult;
            Assert.AreEqual("User not found!", notFoundResult.Value);
        }
    }
}