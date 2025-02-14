﻿using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using data.Models.EntityFramework.Complexity;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;
using data.Models.DTO;
using Microsoft.Extensions.Logging;

namespace data.Models.EntityFramework
{
    [Table("t_e_events_utl")]
    [Index(nameof(IdEvent))]
    [PrimaryKey(nameof(IdEvent))]
    public partial class Events
    {
        [Key]
        [Column("evt_id")]
        public int IdEvent { get; set; }

        [Column("usr_id")]
        public int IdUser { get; set; }

        [Required]
        [Column("evt_name")]
        [MaxLength(50)]
        public string EventName { get; set; }

        [Column("evt_hour")]
        [HourComplexity]
        public string? EventHour { get; set; }

        [Column("evt_date")]
        [DateComplexity]
        public string? EventDate { get; set; }

        [Column("evt_location")]
        public string? EventLocation { get; set; }

        [Column("gen_id")]
        public int? IdGenre { get; set; }

        [Column("evt_description")]
        [MaxLength(500)]
        public string? EventDescription { get; set; }

        [ForeignKey(nameof(IdGenre))]
        [InverseProperty(nameof(Genres.EventsGenre))]
        public virtual Genres? GenreEvent { get; set; } = null!;

        [ForeignKey(nameof(IdUser))]
        [InverseProperty(nameof(Users.EventOwned))]
        public virtual Users? UserOwner { get; set; } = null!;

        [JsonIgnore]
        public virtual ICollection<EventsInvite> EventInvitation { get; set; } = new List<EventsInvite>();

        public void UpdateEventValues(Events updatedEvent)
        {
            if (!string.IsNullOrEmpty(updatedEvent.EventName))
                this.EventName = updatedEvent.EventName;

            if (!string.IsNullOrEmpty(updatedEvent.EventHour))
                this.EventHour = updatedEvent.EventHour;

            if (!string.IsNullOrEmpty(updatedEvent.EventDate))
                this.EventDate = updatedEvent.EventDate;

            if (!string.IsNullOrEmpty(updatedEvent.EventLocation))
                this.EventLocation = updatedEvent.EventLocation;

            if (updatedEvent.IdGenre != null)
                this.IdGenre = updatedEvent.IdGenre;

            if (!string.IsNullOrEmpty(updatedEvent.EventDescription))
                this.EventDescription = updatedEvent.EventDescription;

        }
    }
}
