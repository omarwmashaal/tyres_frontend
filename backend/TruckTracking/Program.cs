using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using TruckTracking.Db;

var builder = WebApplication.CreateBuilder(args);


var app = builder.Build();


builder.Services.AddDbContext<AppDbContext>((options) =>
{
    options.UseNpgsql("Host=localhost;port=5432;Database=TyresDb;Username=postgres;Password=admin");
});


app.MapGet("/weatherforecast", () =>
{
    var forecast = Enumerable.Range(1, 5).Select(index =>
        new WeatherForecast
        (
            DateOnly.FromDateTime(DateTime.Now.AddDays(index)),
            Random.Shared.Next(-20, 55),
            summaries[Random.Shared.Next(summaries.Length)]
        ))
        .ToArray();
    return forecast;
});

app.Run();

internal record WeatherForecast(DateOnly Date, int TemperatureC, string? Summary)
{
    public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);
}
