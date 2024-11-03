using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace TruckTracking.Models
{
    public class Truck
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        public String? PlatNo { get; set; }
        public int? CurrentMileage { get; set; }
        public List<Tyre> Tyres { get; set; }
        public DateTime LastUpdatedMileageDate { get; set; }
        [NotMapped]
        public List<int> TyreIds { get; set; } = new List<int>();
    }
}
