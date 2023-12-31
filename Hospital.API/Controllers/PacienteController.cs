using Events.API.Models;
using Events.Data;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Events.API.Controllers
{
    [ApiController]
    [EnableCors("AllowAnyOrigin")]
    [Route("api/[controller]")]
    public class PacienteController : ControllerBase
    {
        //Products
        [HttpGet]
        [Route("/pacientes")]
        public IActionResult Get(
            [FromServices] AppDbContext context)
        {
            var ListaAuxiliar = context.Pacientes!.Include(m => m.ConsultasMedicas).ToList();
            List<PacienteGetModel> ListaAEnviar = new List<PacienteGetModel>();
            foreach(var item in ListaAuxiliar){
                PacienteGetModel Paciente = new PacienteGetModel
                {
                    Id = item.Id,
                    Name = item.Name,
                    Sobrenome = item.Sobrenome,
                    ConsultasMedicas = item.ConsultasMedicas
                };
                ListaAEnviar.Add(Paciente);
            }

            return Ok(ListaAEnviar);
        }

        [HttpGet]
        [Route("/pacientes/{id:int}")]
        public IActionResult Get([FromRoute] int id,
            [FromServices] AppDbContext context)
        {
            var pacienteModel = context.Pacientes!.FirstOrDefault(x => x.Id == id);
            if (pacienteModel == null){
                return NotFound();
            }
            return Ok(pacienteModel);
        }

        [HttpPost("/pacientes")]
        public IActionResult Post([FromBody] PacienteModel pacienteModel, [FromServices] AppDbContext context){

            var model = context.Pacientes!.ToList();
            var count = 0;
            if (model != null){
                foreach(var item in model){
                    if (item.Id != count){
                        pacienteModel.Id = count;
                        context.Pacientes!.Add(pacienteModel);
                        context.SaveChanges();
                        return Created($"/{pacienteModel.Id}", pacienteModel);
                    }
                    count++;
                }
                pacienteModel.Id = count;
                context.Pacientes!.Add(pacienteModel);
                context.SaveChanges();
                return Created($"/{pacienteModel.Id}", pacienteModel);
            }
            pacienteModel.Id = 0;
            context.Pacientes!.Add(pacienteModel);
            context.SaveChanges();
            return Created($"/{pacienteModel.Id}", pacienteModel);
        }

        [HttpPut("/pacientes")]
        public IActionResult Put(
        [FromBody] PacienteModel pacienteModel,
        [FromServices] AppDbContext context){
            var model = context.Pacientes!.FirstOrDefault(x => x.Id == pacienteModel.Id);
            if (model == null){
                return NotFound();
            }

            model.Name = pacienteModel.Name;
            model.Sobrenome = pacienteModel.Sobrenome;
            model.ConsultasMedicas = pacienteModel.ConsultasMedicas;

            context.Pacientes!.Update(model);
            context.SaveChanges();
            return Ok(model);
        }

        [HttpDelete("/pacientes/{id:int}")] 
        public IActionResult Delete([FromRoute] int id,
        [FromServices] AppDbContext context){
            var model = context.Pacientes!.FirstOrDefault(x => x.Id == id);
            if (model == null){
                return NotFound();
            }

            context.Pacientes!.Remove(model);
            context.SaveChanges();
            return Ok(model);
        }
    }
}