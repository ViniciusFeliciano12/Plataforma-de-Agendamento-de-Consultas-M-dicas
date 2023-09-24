using System.Text.Json.Serialization;

namespace Events.API.Models
{
    public class ConsultaModel
    {
        public int? Id { get; set; }
        public DateTime? DataEHora { get; set; }
        public string? TipoConsulta { get; set; }
        public string? Observacoes { get; set; }

        public int MedicoId { get; set; }

        [JsonIgnore]
        public MedicoModel? Medico { get; set; }

        public int PacienteId { get; set; }

        [JsonIgnore]
        public PacienteModel? Paciente { get; set; }
    }
}