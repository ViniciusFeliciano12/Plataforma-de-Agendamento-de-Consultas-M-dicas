namespace Events.API.Models
{
    public class PacienteModel
    {
        public int? Id {get; set;}
        public string? Name {get; set;}
        public string? Sobrenome {get; set;}
        public List<ConsultaModel>? HistoricoMedico {get; set;}

    }
}