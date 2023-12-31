using System.Text.Json.Serialization;

namespace Events.API.Models
{
    public class MedicoModel
    {
        public int? Id {get; set;}
        public string? Name {get; set;}
        public EspecialidadeModel? Especialidade {get; set;}
        public string? RegistroProfissional {get; set;}

        [JsonIgnore]
        public List<ConsultaModel>? ConsultasMedicas { get; set; }    
    }
}