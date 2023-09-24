using System.Text.Json.Serialization;

namespace Events.API.Models
{
    public class PacienteModel
    {
        public int? Id {get; set;}
        public string? Name {get; set;}
        public string? Sobrenome {get; set;}
        [JsonIgnore]
        public List<ConsultaModel>? ConsultasMedicas { get; set; }   
    }
}