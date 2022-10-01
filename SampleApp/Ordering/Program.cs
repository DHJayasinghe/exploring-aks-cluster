var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddHttpClient();

var app = builder.Build();
app.UseHttpsRedirection();

app.MapGet("/api", async () =>
 {
     using var scope = app.Services.CreateScope();
     var httpClient = (scope.ServiceProvider.GetRequiredService<IHttpClientFactory>()).CreateClient();

     var response = await httpClient.GetAsync("https://dummyjson.com/carts");
     var result = await response.Content.ReadAsStringAsync();
     return result;
 });

app.Run();