using Events.API.Models;
using Microsoft.EntityFrameworkCore;

namespace Events.Data
{
    public class AppDbContext : DbContext
    {
        public DbSet<ConsultaModel>? Consultas { get; set; }
        public DbSet<EspecialidadeModel>? Especialidades { get; set; }
        public DbSet<MedicoModel>? Medicos { get; set; }
        public DbSet<PacienteModel>? Pacientes { get; set; }
        public DbSet<RecepcionistaModel>? Recepcionistas { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseSqlite("DataSource=tds.db;Cache=Shared");
    }
}