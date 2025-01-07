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
using Moq;
using Microsoft.EntityFrameworkCore;
using data.Models.DataManager;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Moq;
using Microsoft.Extensions.Configuration;

namespace data.Controllers.Tests
{
    [TestClass()]
    public class GenreControllerTests
    {

        private GenreController _controller;
        private readonly EventDBContext _context;
        private IDataRepository<Genres> dataRepository;

        private GenreController _controller_Moq;
        private Mock<IDataRepository<Genres>> _mockRepo;

        public GenreControllerTests()
        {
            var configuration = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json")
                .Build();

            var connectionString = configuration.GetConnectionString("EventDB");

            var builder = new DbContextOptionsBuilder<EventDBContext>()
                .UseNpgsql(connectionString);

            _context = new EventDBContext(builder.Options);
            dataRepository = new GenresManager(_context);
            _controller = new GenreController(dataRepository);
        }

        //------------------------------------
        // Tests without MOQ
        //------------------------------------

        [TestMethod()]
        public async Task GetGenreTest_CompareWithDB()
        {
            var result = await _controller.GetGenres();
            var genreInDB = _context.Genre.ToList();

            Assert.IsNotNull(result);
            Assert.IsNotNull(genreInDB);
            Assert.AreEqual(genreInDB.Count, result.Value.Count());
        }

        [TestMethod]
        public async Task GetGenreByID_SuccessGetGenreByID()
        {
            var result = await _controller.GetGenreById(1);
            var genreInDB = _context.Genre.Where(c => c.IdGenre == 1).FirstOrDefault();

            Assert.IsNotNull(result);
        }

        [TestMethod]
        public async Task GetGenreByID_GenreNotFound()
        {
            var result = await _controller.GetGenreById(9999);

            Assert.IsNotNull(result);
            Assert.IsInstanceOfType(result.Result, typeof(NotFoundResult));
        }

        //------------------------------------
        //Tests With MOQ
        //------------------------------------

        [TestInitialize]
        public void Setup()
        {
            _mockRepo = new Mock<IDataRepository<Genres>>();
            _controller_Moq = new GenreController(_mockRepo.Object);
        }


        [TestMethod()]
        {
            var mockGenres = new List<Genres>
            {
            };

            _mockRepo.Setup(repo => repo.GetAllAsync())
                .ReturnsAsync(mockGenres);

            //Act
            var result = await _controller_Moq.GetGenres();
            var okResult = result.Value;

            //Assert
            Assert.IsNotNull(result);
            Assert.AreEqual(2, okResult.Count());
            Assert.AreEqual("Horreur", okResult.First().GenreName);
        }

        [TestMethod]
        public async Task PostGenres_Success()
        {
            // Arrange
            var newGenre = new Genres
            {
            };

            _mockRepo.Setup(repo => repo.AddAsync(newGenre)).ReturnsAsync(new ActionResult<Genres>(newGenre));

            // Act
            var result = await _controller_Moq.PostGenre(newGenre);
            var createdResult = result.Result as CreatedAtActionResult;

            // Assert
            Assert.IsNotNull(createdResult);
            Assert.AreEqual(201, createdResult.StatusCode); // HTTP 201 Created
            Assert.AreEqual("GetGenreById", createdResult.ActionName);
            Assert.AreEqual(newGenre.IdGenre, ((GenreDTO)createdResult.Value).IdGenre);
        }

        [TestMethod]
        public async Task PostGenres_ModelStateInvalid()
        {
            // Arrange
            var invalideGenre = new Genres(); // Missing required fields
            _controller_Moq.ModelState.AddModelError("EventName", "The EventName field is required.");

            // Act
            var result = await _controller_Moq.PostGenre(invalideGenre);
            var badRequestResult = result.Result as BadRequestObjectResult;

            // Assert
            Assert.IsNotNull(badRequestResult);
            Assert.AreEqual(400, badRequestResult.StatusCode); // HTTP 400 Bad Request
            Assert.IsTrue(badRequestResult.Value is SerializableError);
        }

        [TestMethod]
        public async Task PutGenres_Success()
        {
            // Arrange
            var existingGenre = new Genres { IdGenre = 1, GenreName = "Action" };
            var updatedGenre = new Genres { IdGenre = 1, GenreName = "Horreur" };

            _mockRepo.Setup(repo => repo.GetByIdAsync(1)).ReturnsAsync(existingGenre);
            _mockRepo.Setup(repo => repo.UpdateAsync(It.IsAny<Genres>(), It.IsAny<Genres>()))
                .Callback<Genres, Genres>((original, updated) =>
                {
                    original.GenreName = updated.GenreName;
                })
                .ReturnsAsync(new ActionResult<Genres>(existingGenre));

            // Act
            var result = await _controller_Moq.PutGenres(1, updatedGenre);
            var verif = await _controller_Moq.GetGenreById(1);

            // Assert
            Assert.IsInstanceOfType(result.Value, typeof(GenreDTO));
            Assert.AreEqual(updatedGenre.GenreName, verif.Value.GenreName);
        }

        [TestMethod]
        public async Task PutGenre_IdMismatch()
        {
            // Arrange
            var updatedGenre = new Genres { IdGenre = 2, GenreName = "Action" };

            // Act
            var result = await _controller_Moq.PutGenres(1, updatedGenre);

            // Assert
            Assert.IsInstanceOfType(result.Result, typeof(BadRequestResult));
        }

        [TestMethod]
        public async Task PutGenre_EventNotFound()
        {
            // Arrange
            _mockRepo.Setup(repo => repo.GetByIdAsync(9999)).ReturnsAsync((Genres)null);

            var updatedGenre = new Genres { IdGenre = 9999, GenreName = "Action" };

            // Act
            var result = await _controller_Moq.PutGenres(9999, updatedGenre);

            // Assert
            Assert.IsInstanceOfType(result.Result, typeof(NotFoundResult));
        }

        [TestMethod]
        public async Task DeleteGenres_Success()
        {
            // Arrange
            var mockGenres = new List<Genres>
            {
                new Genres { IdGenre = 1, GenreName = "Action" },
                new Genres { IdGenre = 2, GenreName = "Horreur" }
            };

            _mockRepo.Setup(repo => repo.GetByIdAsync(1))
                .ReturnsAsync(mockGenres.FirstOrDefault(e => e.IdGenre == 1));

            _mockRepo.Setup(repo => repo.DeleteAsync(It.IsAny<Genres>()))
                .Callback<Genres>(e => mockGenres.Remove(e))
                .ReturnsAsync(new NoContentResult());

            // Act
            var result = await _controller_Moq.DeleteGenre(1);
            var verif = mockGenres.FirstOrDefault(e => e.IdGenre == 1);

            // Assert
            Assert.IsInstanceOfType(result, typeof(NoContentResult));
            Assert.IsNull(verif);
        }

        [TestMethod]
        public async Task DeleteGenres_GenreNotFound()
        {
            // Arrange
            _mockRepo.Setup(repo => repo.GetByIdAsync(9999)).ReturnsAsync((Genres)null);

            // Act
            var result = await _controller_Moq.DeleteGenre(9999);

            // Assert
            Assert.IsInstanceOfType(result, typeof(NotFoundObjectResult));
            var notFoundResult = result as NotFoundObjectResult;
            Assert.AreEqual("Genre not found!", notFoundResult.Value);
        }
    }
}