using data.Models.EntityFramework;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using ms_evt.Controllers;
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

        private readonly Mock<EventDBContext> _mockContext;
        private readonly Mock<DbSet<Events>> _mockDbSet;
        private readonly EventsController _controller;

        public EventsControllerTests()
        {
            _mockContext = new Mock<EventDBContext>();
            _mockDbSet = new Mock<DbSet<Events>>();

            _mockContext.Setup(m => m.Event).Returns(_mockDbSet.Object);

            _controller = new EventsController(_mockContext.Object);
        }

        [TestMethod()]
        public async Task GetEvent_ShouldReturnAllEvents()
        {
            var result = await _controller.GetEvents();
            var userInDB = _context.Utilisateurs.ToList();


            Assert.IsNotNull(result);
            Assert.AreEqual(userInDB.Count, result.Value.Count());
        }
    }
}