
namespace skandiahackstatehandler
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // Add services to the container.

            builder.Services.AddControllers();
            // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();
            builder.Services.AddHostedService<MessageSenderWorker>();
            builder.Services.AddHostedService<EventWorker>();
            builder.Services.AddHostedService<TimedEventWorker>();
            builder.Services.AddCors(options =>
            {
                options.AddPolicy(name: "all",
                                  policy =>
                                  {
                                      policy.AllowAnyOrigin();                                      
                                  });
            });

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment() || true)
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }

            app.UseHttpsRedirection();

            app.UseAuthorization();
            app.UseCors("all");

            app.UseWebSockets();

            app.UseStaticFiles();
            app.UseDefaultFiles();

            app.MapControllers();
            app.Run();
        }
    }
}
