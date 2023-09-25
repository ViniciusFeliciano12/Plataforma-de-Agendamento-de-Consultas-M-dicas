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

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<ConsultaModel>()
                .HasOne(c => c.Medico)
                .WithMany(m => m.ConsultasMedicas)
                .HasForeignKey(c => c.MedicoId);

            modelBuilder.Entity<ConsultaModel>()
                .HasOne(c => c.Paciente)
                .WithMany(p => p.ConsultasMedicas)
                .HasForeignKey(c => c.PacienteId);

            modelBuilder.Entity<MedicoModel>()
                .HasMany(c => c.ConsultasMedicas)
                .WithOne(p => p.Medico)
                .HasForeignKey(c => c.MedicoId);

            modelBuilder.Entity<PacienteModel>()
                .HasMany(c => c.ConsultasMedicas)
                .WithOne(p => p.Paciente)
                .HasForeignKey(c => c.PacienteId);
        }

    }
}