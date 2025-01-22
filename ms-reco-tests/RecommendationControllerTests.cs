using Microsoft.AspNetCore.Mvc;
using Moq;
using ms_recommend_net.Controllers;
using ms_recommend_net.Interfaces;
using ms_recommend_net.Models;
using ms_recommend_net.Services;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Xunit;

namespace ms_recommend_net.Tests
{
    public class RecommendationControllerTests
    {
        private readonly Mock<IRecommendationService> _recommendationServiceMock;

        private readonly Mock<ITmdbService> _tmdbServiceMock;

        private readonly RecommendationController _controller;

        public RecommendationControllerTests()
        {
            // Mock dependencies
            _recommendationServiceMock = new Mock<IRecommendationService>();
            _tmdbServiceMock = new Mock<ITmdbService>();

            // Pass null for DbContext as it's not used in the tested method
            _controller = new RecommendationController(null, _recommendationServiceMock.Object, _tmdbServiceMock.Object);
        }

        [Fact]
        public async Task GetRecommendations_ShouldReturnOk_WhenRecommendationsAreFound()
        {
            // Arrange
            int userId = 1;
            var mockRecommendations = new List<ParsedMovieDetails>
            {
                new ParsedMovieDetails
                {
                    Id = 1,
                    Title = "Movie 1",
                    poster_path = "/path1.jpg",
                    Runtime = 120,
                    Overview = "Overview 1",
                    ReleaseDate = "2022-01-01",
                    Genres = new List<string> { "Action", "Drama" },
                    Actors = new List<string> { "Actor 1", "Actor 2" }
                },
                new ParsedMovieDetails
                {
                    Id = 2,
                    Title = "Movie 2",
                    poster_path = "/path2.jpg",
                    Runtime = 150,
                    Overview = "Overview 2",
                    ReleaseDate = "2023-02-01",
                    Genres = new List<string> { "Comedy" },
                    Actors = new List<string> { "Actor 3", "Actor 4" }
                }
            };

            _recommendationServiceMock
                .Setup(service => service.GetRecommendationsAsync(userId))
                .ReturnsAsync(mockRecommendations);

            // Act
            var result = await _controller.GetRecommendations(userId);

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            Assert.Equal(200, okResult.StatusCode);

            var recommendations = Assert.IsType<List<ParsedMovieDetails>>(okResult.Value);
            Assert.Equal(2, recommendations.Count);
            Assert.Equal("Movie 1", recommendations[0].Title);
            Assert.Equal("Movie 2", recommendations[1].Title);
        }

        [Fact]
        public async Task GetRecommendations_ShouldReturn500_WhenExceptionIsThrown()
        {
            // Arrange
            int userId = 1;
            _recommendationServiceMock
                .Setup(service => service.GetRecommendationsAsync(userId))
                .ThrowsAsync(new Exception("Test exception"));

            // Act
            var result = await _controller.GetRecommendations(userId);

            // Assert
            var statusCodeResult = Assert.IsType<ObjectResult>(result);
            Assert.Equal(500, statusCodeResult.StatusCode);
            Assert.Contains("Erreur lors de la récupération des recommandations", statusCodeResult.Value.ToString());
        }

        [Fact]
        public async Task GetRecommendations_ShouldHandleEmptyRecommendations()
        {
            // Arrange
            int userId = 1;
            _recommendationServiceMock
                .Setup(service => service.GetRecommendationsAsync(userId))
                .ReturnsAsync(new List<ParsedMovieDetails>()); // No recommendations

            // Act
            var result = await _controller.GetRecommendations(userId);

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            Assert.Equal(200, okResult.StatusCode);

            var recommendations = Assert.IsType<List<ParsedMovieDetails>>(okResult.Value);
            Assert.Empty(recommendations);
        }
    }
}
