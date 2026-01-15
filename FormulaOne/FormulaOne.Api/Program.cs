using FormulaOne.DataService.Data;
using FormulaOne.DataService.Repositories;
using FormulaOne.DataService.Repositories.Interfaces;
using HealthChecks.UI.Client;
using Microsoft.AspNetCore.Diagnostics.HealthChecks;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Diagnostics.HealthChecks;

var builder = WebApplication.CreateBuilder(args);

// Get Connection String
var mssqlConn = builder.Configuration.GetConnectionString("DefaultConnectionMsSql");
   
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseSqlServer(mssqlConn));

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

builder.Services.AddScoped<IUnitOfWork, UnitOfWork>();

builder.Services.AddHealthChecks() 
    .AddSqlite(
        mssqlConn,
        "SELECT 1",
        name: "Db Check",
        failureStatus: HealthStatus.Unhealthy,
        tags: new[] { "sql", "sqlserver", "healthcheks" });

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.MapHealthChecks("/health", new HealthCheckOptions
{
    ResponseWriter = UIResponseWriter.WriteHealthCheckUIResponse
});

app.Run();