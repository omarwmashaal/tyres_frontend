using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace TruckTracking.Models
{
    public class TyreLog
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public DateTime Date { get; set; }
        public int Mileage { get; set; }
        public Enum_TyreLog Status { get; set; }
        public int? TruckId { get; set; }
        public String? TruckPlateNo { get; set; }
        public int TyreId { get; set; }
        [ForeignKey("TyreId")]
        public Tyre Tyre { get; set; }
    }
}
