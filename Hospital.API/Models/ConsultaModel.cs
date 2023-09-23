namespace Events.API.Models
{
    public class ConsultaModel
    {
        public int? Id {get; set;}
        public MedicoModel? Medico {get; set;}
        public PacienteModel? Paciente {get; set;}
        public DateTime? DataEHora {get; set; }
        public string? TipoConsulta {get; set;}
        public string? Observacoes {get; set;}
    }
}