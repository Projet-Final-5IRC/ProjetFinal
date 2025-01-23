using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Internal;
using ms_badge.Db;
using ms_badge.Models;
using ms_badge.Services;
using System;

namespace ms_badge.Controllers
{
    public class BadgeController : Controller
    {
        // In-memory database simulation
        private static List<Badge> Badges = new List<Badge>();
        private static List<UserBadge> UserBadges = new List<UserBadge>();
        private readonly BadgeContext _context;
        private readonly BadgeEvaluatorService _badgeEvaluatorService;

        public BadgeController(BadgeContext context, BadgeEvaluatorService badgeEvaluatorService)
        {
            _context = context;
            _badgeEvaluatorService = badgeEvaluatorService;
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

        [HttpPost("evaluate-and-assign/{userId}")]
        public async Task<IActionResult> EvaluateAndAssignBadges(int userId)
        {
            try
            {
                // Fetch user activity using the BadgeEvaluatorService
                var userActivity = await _badgeEvaluatorService.GetUserActivity(userId, _context);
                var badges = await _context.Badges.ToListAsync();

                foreach (var badge in badges)
                {
                    // Evaluate the badge criteria using the service
                    if (_badgeEvaluatorService.EvaluateCriteria(badge, userActivity))
                    {
                        // Check if the badge is already assigned
                        var alreadyAssigned = await _context.UserBadges
                            .AnyAsync(ub => ub.UserId == userId && ub.BadgeId == badge.Id);

                        if (!alreadyAssigned)
                        {
                            var userBadge = new UserBadge
                            {
                                UserId = userId,
                                BadgeId = badge.Id,
                                AssignedDate = DateTime.UtcNow
                            };

                            await _context.UserBadges.AddAsync(userBadge);
                        }
                    }
                }

                // Save changes in the database
                await _context.SaveChangesAsync();
                return Ok("Badges evaluated and assigned successfully.");
            }
            catch (Exception ex)
            {
                return BadRequest($"An error occurred: {ex.Message}");
            }
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
