using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace TruckTracking.Models
{
    public class Tyre
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]   
        public int? Id { get; set; }
        public int? TruckId { get; set; }
        public int? StartMileage { get; set; } = 0;
        public int? EndMileage { get; set; } = 0;
        public String? Serial { get; set; }
        public String? Model { get; set; }
        public TyrePosition? Position { get; set; } = null;
        public DateTime? AddedDate { get; set; }
        public DateTime? InstalledDate { get; set; }
        [NotMapped]
        public int? TotalMileage { get; set; } = 0;
        [NotMapped]
        public string? CurrentTruckPlateNo { get; set; } 
    }
    [Owned]
    public class TyrePosition
    {
      
        public Enum_TyreDirection? Direction { get; set; }
        public Enum_TyreSide? Side { get; set; }
        public int? Index { get; set; }
    }
}
