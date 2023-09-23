namespace Events.API.Models
{
    public class MedicoModel
    {
        public int? Id {get; set;}
        public string? Name {get; set;}
        public string? Especialidade {get; set;}
        public string? RegistroProfissional {get; set;}
        public List<ConsultaModel>? HorariosDisponiveis {get; set;}
    }
}