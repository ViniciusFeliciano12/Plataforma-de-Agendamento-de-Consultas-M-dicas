using System.Text.Json.Serialization;

namespace Events.API.Models
{
    public class PacienteGetModel
    {
        public int? Id {get; set;}
        public string? Name {get; set;}
        public string? Sobrenome {get; set;}
        public List<ConsultaModel>? ConsultasMedicas { get; set; }   
    }
}