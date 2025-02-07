using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using Npgsql;
using System;
using System.Diagnostics;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using System.Text.Json;
using TruckTracking;
using TruckTracking.Db;
using TruckTracking.Models;

var builder = WebApplication.CreateBuilder(args);

// Configure Identity
builder.Services.AddIdentity<User, IdentityRole>(options =>
{
    options.Password.RequireNonAlphanumeric = false;
    options.Password.RequireUppercase = false;
    options.Password.RequiredLength = 4;
    options.Password.RequiredUniqueChars = 0;
    options.Password.RequireLowercase = false;
    options.Password.RequireDigit = false;
    options.User.RequireUniqueEmail = true;
    options.SignIn.RequireConfirmedAccount = false;
})
.AddEntityFrameworkStores<AppDbContext>()
.AddDefaultTokenProviders();
builder.WebHost.ConfigureKestrel(options =>
{
    options.ListenAnyIP(5000); // Replace 5000 with your desired port
});
// Configure CORS
builder.Services.AddCors(options =>
{
    options.AddDefaultPolicy(policyBuilder =>
    {
        policyBuilder.AllowAnyOrigin()
                 .AllowAnyMethod()
                 .AllowAnyHeader();
    });
});

// Configure JWT Authentication
builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(options =>
{
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true,
        ValidIssuer = "YourIssuer",

        ValidateAudience = true,
        ValidAudience = "YourAudience",

        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes("OmarWaelBayoumyAliMashaalPower3297"))
    };
});

// Configure Database
builder.Services.AddDbContext<AppDbContext>(options =>
{
    options.UseNpgsql("Host=localhost;port=5432;Database=TyresDb;Username=postgres;Password=admin");
});


// Configure Authorization
builder.Services.AddAuthorization();

bool IsTransientError(Exception ex)
{
    return ex.InnerException.Message.ToLower().Contains("failed to connect to") ||
     (ex.InnerException is NpgsqlException && ((NpgsqlException) ex.InnerException).IsTransient==true) ||
      ex is HttpRequestException ||
      ex is TimeoutException;
}
var app = builder.Build();

using (var scope = app.Services.CreateScope())
{
    var services = scope.ServiceProvider;
    var dbContext = services.GetRequiredService<AppDbContext>();

    try
    {
        dbContext.Database.Migrate(); // Applies any pending migrations
    }
    catch (Exception ex)
    {
        // Log the exception or handle errors during migration
        Console.WriteLine($"An error occurred while migrating the database: {ex.Message}");
    }
}

app.UseCors();
app.UseAuthentication();
app.UseAuthorization();




app.Use(async (context, next) =>
{
    var originalBodyStream = context.Response.Body;

    using var responseBodyStream = new MemoryStream();
    context.Response.Body = responseBodyStream;

    var response = new ApiResult();

    int retryCount = 3;
    int retryDelayMs = 2500;
    while(retryCount>0)
    {
        try
        {
            await next();

            context.Response.Body.Seek(0, SeekOrigin.Begin);
            var responseBody = await new StreamReader(context.Response.Body).ReadToEndAsync();
            response.StatusCode = context.Response.StatusCode;
            if (response.StatusCode != StatusCodes.Status200OK)
                response.ErrorMessage = responseBody; // Capture the response body content
            else
                response.Data = responseBody; // Capture the response body content
            response.isSuccess = true;
            break;
        }
        catch (Exception e)
        {
  
            if (IsTransientError(e) && retryCount > 1)
            {
                await Task.Delay(retryDelayMs);
                retryDelayMs *= 2;
                retryCount--;
            }
            else
            {
                response.isSuccess = false;
                response.ErrorMessage = e.Message;
                response.StatusCode = StatusCodes.Status500InternalServerError;
                break;
            }
        }
    }
    


    context.Response.Body.Seek(0, SeekOrigin.Begin);
    context.Response.ContentType = "application/json";
    await context.Response.WriteAsync(JsonSerializer.Serialize(response));

    responseBodyStream.Seek(0, SeekOrigin.Begin);
    await responseBodyStream.CopyToAsync(originalBodyStream);
    context.Response.Body = originalBodyStream;
});

app.MapGet("/test", ([FromServices] AppDbContext dbContext) =>
{
    var tyres = dbContext.Tyres.FirstOrDefault();
    return Results.Ok("Connected");
});

app.MapGet("/register", async ([FromServices] UserManager<User> userManager, [FromQuery] String email, [FromQuery] String password, [FromQuery] String name) =>
{
    var userName = name + email;
    userName = userName.Replace(".", "").Replace("@", "").Trim().Replace(" ", "");
    var result = await userManager.CreateAsync(new User { Email = email, UserName = userName, Name = name }, password);
    if (result.Succeeded)
        return Results.Ok();
    else
        return Results.BadRequest(result.Errors.FirstOrDefault());

});
app.MapGet("/login", [AllowAnonymous] async ([FromServices] UserManager<User> userManager, [FromServices] SignInManager<User> signInManager, [FromQuery] string email, [FromQuery] string password) =>
{
    var user = await userManager.FindByEmailAsync(email);
    if (user == null)
        return Results.BadRequest("Invalid Email Or Password");

    var result = await signInManager.CheckPasswordSignInAsync(user, password, false);
    if (!result.Succeeded)
        return Results.BadRequest("Invalid Email Or Password");

    // Generate the JWT token
    var tokenString = GenerateToken.GenerateJWTToken(user);
    return Results.Ok(tokenString);
});


app.MapGet("/searchTrucks", [Authorize] async ([FromServices] AppDbContext dbContext, [FromQuery] String? search) =>
{
    List<Truck> trucks = new List<Truck>();
    if (search == null)
        trucks = await dbContext.Trucks.ToListAsync();
    else
    {
        search = search.Replace(" ", "");
        trucks = await dbContext.Trucks.Where(x => x.PlatNo!.ToLower().Replace(" ", "").Contains(search!.ToLower())).ToListAsync();
    }
    return Results.Ok(trucks);

});
app.MapGet("/getTruck", async ([FromServices] AppDbContext dbContext, [FromQuery] int id) =>
{
    var truck = await dbContext.Trucks.Include(x => x.Tyres).FirstOrDefaultAsync(x => x.Id == id);
    if (truck == null)
    {
        return Results.BadRequest("Truck Not Found!");
    }
    foreach (var tyre in truck.Tyres)
    {
        var historyMileage = dbContext.TyreLogs.Where(x => x.TyreId == tyre.Id).Sum(x => x.Mileage);
        tyre.EndMileage = truck.CurrentMileage ?? 0;
        tyre.TotalMileage = historyMileage + ((tyre.EndMileage ?? 0) - (tyre.StartMileage ?? 0));
        dbContext.Tyres.Update(tyre);
    }
    dbContext.SaveChanges();
    return Results.Ok(truck);

});

app.MapPost("/addTruck", async ([FromServices] AppDbContext dbContext, [FromBody] Truck truck) =>
{
    var found = dbContext.Trucks.Any(x => x.PlatNo!.ToLower() == truck.PlatNo!.ToLower());
    if (found)
        return Results.BadRequest("Truck is already added!");
    truck.LastUpdatedMileageDate = DateTime.UtcNow;
    dbContext.Trucks.Add(truck);
    dbContext.SaveChanges();
    return Results.Ok(truck);

});

app.MapPut("/updateTruck", async ([FromServices] AppDbContext dbContext, [FromBody] Truck truck) =>
{
    var found = await dbContext.Trucks.FirstOrDefaultAsync(x => x.PlatNo!.ToLower() == truck.PlatNo!.ToLower());
    if (found == null)
        return Results.BadRequest("Truck Not Found!");
    if (truck.CurrentMileage < found.CurrentMileage)
        return Results.BadRequest("Invalid Mileage");
    found.CurrentMileage = truck.CurrentMileage;
    found.LastUpdatedMileageDate = DateTime.UtcNow;
    dbContext.Trucks.Update(found);
    dbContext.SaveChanges();
    return Results.Ok(truck);

});

app.MapPost("/installTyre", async ([FromServices] AppDbContext dbContext, [FromBody] Tyre tyre, [FromQuery] bool newTyre) =>
{

    var tyreInDb = await dbContext.Tyres.FirstOrDefaultAsync(x => x.Serial.ToLower().Trim().Replace(" ", "") == tyre.Serial.ToLower().Trim().Replace(" ", ""));
    bool returnSerial = false;
    if (tyreInDb != null && newTyre)
    {
        var result = await dbContext.Database.SqlQuery<int>($"SELECT nextval('unique_number_seq') AS \"Value\"")
        .FirstAsync();
        tyreInDb = null;
        tyre.Serial = tyre.Serial + " - " + result.ToString();
        returnSerial = true;
    }


    var truck = await dbContext.Trucks.Include(x => x.Tyres).FirstOrDefaultAsync(x => x.Id == tyre.TruckId);
    if (tyreInDb == null)
    {
        if (tyre.Model.IsNullOrEmpty() || tyre.Serial.IsNullOrEmpty())
            return Results.BadRequest("Model and serial should be filled!");
        tyreInDb = new Tyre
        {
            Model = tyre.Model,
            Serial = tyre.Serial,
            Position = tyre.Position,
            TruckId = tyre.TruckId,
            StartMileage = truck!.CurrentMileage ?? 0,
            EndMileage = truck!.CurrentMileage ?? 0,
            AddedDate = DateTime.UtcNow,
            InstalledDate = DateTime.UtcNow,
        };
        dbContext.Tyres.Add(tyreInDb);
        dbContext.SaveChanges();
        dbContext.TyreLogs.Add(new TyreLog
        {
            Date = DateTime.UtcNow,
            Status = Enum_TyreLog.Added,
            Tyre = tyreInDb,
            TyreId = (int)tyreInDb!.Id!,
            Mileage = 0

        });
        dbContext.TyreLogs.Add(new TyreLog
        {
            Date = DateTime.UtcNow,
            Status = Enum_TyreLog.Installed,
            Tyre = tyreInDb,
            TyreId = (int)tyreInDb!.Id!,
            TruckId = truck.Id,
            TruckPlateNo = truck.PlatNo,
            Mileage = 0,
        });
        dbContext.SaveChanges();
        if (returnSerial)
            return Results.Ok(tyreInDb.Serial);
        else
            return Results.Ok();
    }
    else
    {
        if (tyreInDb.TruckId != null)
        {
            var truckPlatNo = await dbContext.Trucks.FirstAsync(x => x.Id == tyreInDb.TruckId);
            return Results.BadRequest($"Tyre is already installed to another vehicle Plat No {truckPlatNo.PlatNo} " + (tyreInDb.Position?.Side.ToString() ?? "") + (tyreInDb?.Position?.Index.ToString() ?? "") + (tyreInDb?.Position?.Direction.ToString() ?? ""));
        }
        if (truck.Tyres.Any(x =>
            x.Position.Side == tyre.Position.Side &&
            x.Position.Direction == tyre.Position.Direction &&
            x.Position.Index == tyre.Position.Index)
        )
            return Results.BadRequest("Truck has a tyre installed to this position, Please remove the tyre first!");


        tyreInDb.Position = tyre.Position;
        tyreInDb.TruckId = tyre.TruckId;
        tyreInDb.StartMileage = truck!.CurrentMileage ?? 0;
        tyreInDb.EndMileage = truck!.CurrentMileage ?? 0;
        tyreInDb.InstalledDate = DateTime.UtcNow;
        dbContext.Tyres.Update(tyreInDb);
        dbContext.SaveChanges();
        dbContext.TyreLogs.Add(new TyreLog
        {
            Date = DateTime.UtcNow,
            Status = Enum_TyreLog.Installed,
            Tyre = tyreInDb,
            TyreId = (int)tyreInDb!.Id!,
            TruckId = truck.Id,
            TruckPlateNo = truck.PlatNo,
            Mileage = 0,
        });
        return Results.Ok();
    }


});


app.MapPut("/removeTyreFromTruck", async ([FromServices] AppDbContext dbContext, [FromQuery] int tyreId) =>
{
    var tyre = await dbContext.Tyres.FirstOrDefaultAsync(x => x.Id == tyreId);
    if (tyre.TruckId == null)
    {
        return Results.BadRequest("Tyre is not attached to a truck!");
    }
    var truck = await dbContext.Trucks.FirstAsync(x => x.Id == tyre.TruckId);
    tyre.TruckId = null;
    tyre.EndMileage = 0;
    tyre.StartMileage = 0;
    dbContext.TyreLogs.Add(new TyreLog
    {
        Date = DateTime.UtcNow,
        Status = Enum_TyreLog.Removed,
        Tyre = tyre,
        TyreId = (int)tyre!.Id!,
        TruckId = truck.Id,
        TruckPlateNo = truck.PlatNo,
        Mileage = (tyre.EndMileage ?? 0) - (tyre.StartMileage ?? 0),
    });
    dbContext.Tyres.Update(tyre);
    dbContext.SaveChanges();
    return Results.Ok();



});
app.MapPut("/transfereTyreOnSameTruck", async ([FromServices] AppDbContext dbContext, [FromQuery] int tyreId, [FromBody] TyrePosition newPosition) =>
{
    var tyre = await dbContext.Tyres.FirstOrDefaultAsync(x => x.Id == tyreId);
    if (tyre == null)
        return Results.BadRequest("Tyre not found!");
    else if (tyre.TruckId == null)
        return Results.BadRequest("Tyre is not installed!");
    var truck = await dbContext.Trucks.Include(x => x.Tyres).FirstOrDefaultAsync(x => x.Id == tyre.TruckId);
    if (truck == null)
        return Results.BadRequest("Truck not found!");
    if (truck.Tyres.Any(x => x.Position.Side == newPosition.Side && x.Position.Index == newPosition.Index && x.Position.Direction == newPosition.Direction))
        return Results.BadRequest("Another Tyre is installed in this position!");
    tyre.Position = newPosition;
    dbContext.Update(tyre);
    dbContext.SaveChanges();
    return Results.Ok();



});


app.MapGet("/searchTyre", async ([FromServices] AppDbContext dbContext, [FromQuery] string serial) =>
{
    serial = serial.ToLower().Trim().Replace(" ", "");
    var tyres = await dbContext.Tyres.Include(x => x.Position).Where(x => x.Serial.ToLower().Trim().Replace(" ", "").StartsWith(serial)).ToListAsync();

    foreach (var tyre in tyres)
    {
        var historyMileage = dbContext.TyreLogs.Where(x => x.TyreId == tyre.Id).Sum(x => x.Mileage);
        tyre.TotalMileage = historyMileage + ((tyre.EndMileage ?? 0) - (tyre.StartMileage ?? 0));
        var truck = dbContext.Trucks.FirstOrDefault(x => x.Id == tyre.TruckId);
        tyre.CurrentTruckPlateNo = truck == null ? "Not Installed!" : truck?.PlatNo + " " + (tyre.Position?.Side.ToString() ?? "") + (tyre?.Position?.Index.ToString() ?? "") + (tyre?.Position?.Direction.ToString() ?? "");
    }
    return Results.Ok(tyres);


});

app.MapGet("/getNewId", async ([FromServices] AppDbContext dbContext) =>
{
    int nextId = (dbContext.Tyres.Max(t => (int?)t.Id) ?? 0) + 1;

    return Results.Ok(nextId);


});
app.MapPut("/addTyre", async ([FromServices] AppDbContext dbContext, [FromQuery] string serial, [FromQuery] string model) =>
{
    if (model.IsNullOrEmpty() || serial.IsNullOrEmpty())
        return Results.BadRequest("Model and serial should be filled!");
    var foundTyre = await dbContext.Tyres.FirstOrDefaultAsync(x => x.Serial.ToLower().Trim().Replace(" ", "") == serial.ToLower().Trim().Replace(" ", ""));
    bool returnSerial = false;
    if (foundTyre != null)
    {
        var result = await dbContext.Database.SqlQuery<int>($"SELECT nextval('unique_number_seq') AS \"Value\"")
        .FirstAsync();

        serial = serial + " - " + result.ToString();
        returnSerial = true;
    }



    var tyre = new Tyre
    {
        Model = model,
        Serial = serial,
        StartMileage = 0,
        EndMileage = 0,
        AddedDate = DateTime.UtcNow,
        Position = null,
        TruckId = null,
        CurrentTruckPlateNo = null,
        InstalledDate = null,
        TotalMileage = 0,
    };
    dbContext.Tyres.Add(tyre);
    dbContext.SaveChanges();
    dbContext.TyreLogs.Add(new TyreLog
    {
        Date = DateTime.UtcNow,
        Status = Enum_TyreLog.Added,
        Tyre = tyre,
        TyreId = (int)tyre!.Id!,
        Mileage = 0

    });
    dbContext.SaveChanges();
    if (returnSerial)
        return Results.Ok(tyre.Serial);
    else
        return Results.Ok();

});




app.Run();

internal record WeatherForecast(DateOnly Date, int TemperatureC, string? Summary)
{
    public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);
}
