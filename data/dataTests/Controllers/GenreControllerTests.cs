using Microsoft.VisualStudio.TestTools.UnitTesting;
using data.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using data.Models.EntityFramework;
using data.Models.Repository;
using Moq;
using Microsoft.EntityFrameworkCore;
using data.Models.DataManager;
using Microsoft.AspNetCore.Mvc;

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
            var builder = new DbContextOptionsBuilder<EventDBContext>()
                .UseNpgsql("Server=localhost;port=5432;Database=EventsDB;uid=postgres;password=postgres;");
            _context = new EventDBContext(builder.Options);
            dataRepository = new GenresManager(_context);
            _controller = new GenreController(dataRepository);
        }

        //------------------------------------
        // Tests without MOQ
        //------------------------------------

        [TestMethod()]
        public async Task GetGenresTest_CompareWithDB()
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
            Assert.AreEqual(genreInDB.GenreName, result.Value.GenreName);
        }

        [TestMethod]
        public async Task GetGenreByID_GenreNotFound()
        {
            var result = await _controller.GetGenreById(9999);
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
        public async Task GetAllGenre()
        {
            var mockGenres = new List<Genres>
            {
                new Genres { IdGenre = 1, GenreName = "Action" },
                new Genres { IdGenre = 2, GenreName = "Horreur" }
            };

            _mockRepo.Setup(repo => repo.GetAllAsync())
                .ReturnsAsync(mockGenres);

            //Act
            var result = await _controller_Moq.GetGenres();
            var okResult = result.Value;

            //Assert
            Assert.IsNotNull(result);
            Assert.IsInstanceOfType(result.Value, typeof(List<Genres>));
            Assert.AreEqual(2, okResult.Count());
            Assert.AreEqual("Horreur", okResult.First().GenreName);
        }

        [TestMethod]
        public async Task PostGenres_Success()
        {
            // Arrange
            var newGenre = new Genres
            {
                GenreName = "SF"
            };

            _mockRepo.Setup(repo => repo.AddAsync(newGenre)).ReturnsAsync(new ActionResult<Genres>(newGenre));

            // Act
            var result = await _controller_Moq.PostGenre(newGenre);
            var createdResult = result.Result as CreatedAtActionResult;

            // Assert
            Assert.IsNotNull(createdResult);
            Assert.AreEqual(201, createdResult.StatusCode); // HTTP 201 Created
            Assert.AreEqual("GetGenre", createdResult.ActionName);
            Assert.AreEqual(newGenre.IdGenre, ((Events)createdResult.Value).IdEvent);
        }
    }
}