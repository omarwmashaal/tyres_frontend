using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using System.Text.Json;
using TruckTracking.Db;
using TruckTracking.Models;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddCors(options =>
{
    options.AddDefaultPolicy(builder =>
    {
        builder.AllowAnyOrigin()
               .AllowAnyMethod()
               .AllowAnyHeader();
    });
});

builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,
            IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes("OmarWaelBayoumyAliMashaalPower3297"))
        };
    });
builder.Services.AddDbContext<AppDbContext>((options) =>
{
    options.UseNpgsql("Host=localhost;port=5432;Database=TyresDb;Username=postgres;Password=admin");
});
builder.Services.AddIdentity<User, IdentityRole>(options =>
        {
            options.Password.RequireNonAlphanumeric = false;
            options.Password.RequireUppercase = false;
            options.Password.RequiredLength = 4;
            options.Password.RequiredUniqueChars = 0;
            options.Password.RequireNonAlphanumeric = false;
            options.Password.RequireLowercase = false;
            options.Password.RequireUppercase = false;
            options.Password.RequireDigit = false;

            options.User.RequireUniqueEmail = true;
        })
    .AddEntityFrameworkStores<AppDbContext>()
    .AddDefaultTokenProviders();


var app = builder.Build();
app.UseCors();

app.UseAuthentication();

app.Use(async (context, next) =>
{
    var originalBodyStream = context.Response.Body;

    using var responseBodyStream = new MemoryStream();
    context.Response.Body = responseBodyStream;

    var response = new ApiResult();

    try
    {
        await next();

        context.Response.Body.Seek(0, SeekOrigin.Begin);
        var responseBody = await new StreamReader(context.Response.Body).ReadToEndAsync();
        if (response.StatusCode != StatusCodes.Status200OK)
        {
            response.ErrorMessage = responseBody; // Capture the response body content
        }
        else
            response.Data = responseBody; // Capture the response body content
        response.isSuccess = true;
        response.StatusCode = context.Response.StatusCode;
    }
    catch (Exception e)
    {
        response.isSuccess = false;
        response.ErrorMessage = e.Message;
        response.StatusCode = StatusCodes.Status500InternalServerError;
    }


    context.Response.Body.Seek(0, SeekOrigin.Begin);
    context.Response.ContentType = "application/json";
    await context.Response.WriteAsync(JsonSerializer.Serialize(response));

    responseBodyStream.Seek(0, SeekOrigin.Begin);
    await responseBodyStream.CopyToAsync(originalBodyStream);
    context.Response.Body = originalBodyStream;
});

app.MapGet("/register", async ([FromServices] UserManager<User> userManager, [FromQuery] String email, [FromQuery] String password, [FromQuery] String name) =>
{
    var userName = name + email;
    userName = userName.Replace(".","").Replace("@","").Trim().Replace(" ","");
    var result = await userManager.CreateAsync(new User { Email = email, UserName = userName,Name=name }, password);
    if (result.Succeeded)
        return Results.Ok();
    else
        return Results.BadRequest(result.Errors.FirstOrDefault());

});

//app.MapGet("/login", (UserManager<User> userManager,String email,String password)=>{

//});



app.Run();

internal record WeatherForecast(DateOnly Date, int TemperatureC, string? Summary)
{
    public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);
}
