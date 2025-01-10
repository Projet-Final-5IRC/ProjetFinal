using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Internal;
using ms_badge.Db;
using ms_badge.Models;
using System;

namespace ms_badge.Controllers
{
    public class BadgeController : Controller
    {
        [ApiController]
        [Route("api/[controller]")]
        public class BadgesController : ControllerBase
        {
            // In-memory database simulation
            private static List<Badge> Badges = new List<Badge>();
            private static List<UserBadge> UserBadges = new List<UserBadge>();
            private readonly BadgeContext _context;

            public BadgesController(BadgeContext context)
            {
                _context = context;
            }

            [HttpGet]
            [Route("list")]
            public async Task<IActionResult> GetAllBadges([FromServices] BadgeContext context)
            {
                var badges = await context.Badges.ToListAsync();
                return Ok(badges);
            }

            [HttpPost]
            [Route("create")]
            public async Task<IActionResult> CreateBadge([FromBody] Badge badge, [FromServices] BadgeContext context)
            {
                await context.Badges.AddAsync(badge);
                await context.SaveChangesAsync();
                return CreatedAtAction(nameof(GetAllBadges), new { id = badge.Id }, badge);
            }

            [HttpGet]
            [Route("{id}")] // Get a badge by ID
            public async Task<IActionResult> GetBadgeById(int id, [FromServices] BadgeContext context)
            {
                var badge = await context.Badges.FindAsync(id);
                if (badge == null)
                {
                    return NotFound();
                }

                return Ok(badge);
            }

            [HttpPut]
            [Route("{id}")] // Update badge
            public async Task<IActionResult> UpdateBadge(int id, [FromBody] Badge updatedBadge, [FromServices] BadgeContext context)
            {
                var badge = await context.Badges.FindAsync(id);
                if (badge == null)
                {
                    return NotFound();
                }

                badge.Name = updatedBadge.Name;
                badge.Description = updatedBadge.Description;
                badge.Criteria = updatedBadge.Criteria;

                context.Badges.Update(badge);
                await context.SaveChangesAsync();

                return NoContent();
            }

            [HttpDelete]
            [Route("{id}")] // Delete badge
            public async Task<IActionResult> DeleteBadge(int id, [FromServices] BadgeContext context)
            {
                var badge = await context.Badges.FindAsync(id);
                if (badge == null)
                {
                    return NotFound();
                }

                context.Badges.Remove(badge);
                await context.SaveChangesAsync();

                return NoContent();
            }

            [HttpPost]
            [Route("assign")] // Assign a badge to a user
            public async Task<IActionResult> AssignBadge([FromBody] AssignBadgeRequest request, [FromServices] BadgeContext context)
            {
                var badge = await context.Badges.FindAsync(request.BadgeId);
                if (badge == null)
                {
                    return NotFound("Badge not found.");
                }

                var userBadge = new UserBadge
                {
                    UserId = request.UserId,
                    BadgeId = request.BadgeId,
                    AssignedDate = System.DateTime.UtcNow
                };

                await context.UserBadges.AddAsync(userBadge);
                await context.SaveChangesAsync();

                return Ok("Badge assigned successfully.");
            }

            [HttpGet]
            [Route("user/{userId}")] // Get all badges for a user
            public async Task<IActionResult> GetUserBadges(int userId, [FromServices] BadgeContext context)
            {
                var badges = await context.UserBadges
                    .Where(ub => ub.UserId == userId)
                    .Join(context.Badges, ub => ub.BadgeId, b => b.Id, (ub, b) => b)
                    .ToListAsync();

                return Ok(badges);
            }
        }
    }
}
