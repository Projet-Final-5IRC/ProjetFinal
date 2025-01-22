using Microsoft.AspNetCore.Mvc;
using Moq;
using ms_recommend_net.Controllers;
using ms_recommend_net.Interfaces;
using ms_recommend_net.Models;
using System;
using System.Collections.Generic;
using System.Numerics;
using System.Threading.Tasks;
using Xunit;

namespace RecommendationControllerTests
{
    public class RecommendationControllerTests
    {
        private readonly Mock<IRecommendationService> _recommendationServiceMock;

        public RecommendationControllerTests()
        {
            _recommendationServiceMock = new Mock<IRecommendationService>();
        }

        [Fact]
        public async Task GetRecommendations_ReturnsOkResult_WithRecommendations()
        {
            // Arrange
            var userId = 1;
            var mockRecommendations = new List<ParsedMovieDetails>
            {
                new ParsedMovieDetails
                {
                    Id = 123,
                    Title = "Sample Movie",
                    Overview = "Sample Overview",
                    PosterPath = "/sample.jpg",
                    ReleaseDate = "2025-01-01",
                    Runtime = 120,
                    Genres = new List<string> { "Action", "Drama" },
                    Actors = new List<Actor>
                    {
                        new Actor { Id = 1, Name = "Actor 1", Character = "Character 1" }
                    }
                }
            };

            _recommendationServiceMock
                .Setup(service => service.GetRecommendationsAsync(userId))
                .ReturnsAsync(mockRecommendations);

            var controller = new RecommendationController(
                null, // AppDbContext is not used in this method
                _recommendationServiceMock.Object,
                null, // ActiveMqService is not used in this method
                null  // TmdbService is not used in this method
            );

            // Act
            var result = await controller.GetRecommendations(userId);

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var returnedRecommendations = Assert.IsType<List<ParsedMovieDetails>>(okResult.Value);
            Assert.Single(returnedRecommendations);
            Assert.Equal("Sample Movie", returnedRecommendations[0].Title);
        }

        [Fact]
        public async Task GetRecommendations_ReturnsServerError_OnException()
        {
            // Arrange
            var userId = 1;

            _recommendationServiceMock
                .Setup(service => service.GetRecommendationsAsync(userId))
                .ThrowsAsync(new Exception("Test Exception"));

            var controller = new RecommendationController(
                null, // AppDbContext is not used in this method
                _recommendationServiceMock.Object,
                null, // ActiveMqService is not used in this method
                null  // TmdbService is not used in this method
            );

            // Act
            var result = await controller.GetRecommendations(userId);

            // Assert
            var objectResult = Assert.IsType<ObjectResult>(result);
            Assert.Equal(500, objectResult.StatusCode);
            Assert.Contains("Test Exception", objectResult.Value.ToString());
        }
    }
}
