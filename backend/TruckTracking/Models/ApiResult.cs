namespace TruckTracking.Models
{
    public class ApiResult
    {
        public int StatusCode { get; set; }
        public object? Data { get; set; }
        public String? ErrorMessage { get; set; }
        public bool isSuccess { get; set; }

    }
}
