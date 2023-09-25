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
    public class MedicoController : ControllerBase
    {
        //Products
        [HttpGet]
        [Route("/medicos")]
        public IActionResult Get(
            [FromServices] AppDbContext context)
        {
           var medicos = context.Medicos!
            .Include(m => m.Especialidade).Include(m => m.ConsultasMedicas) 
            .ToList();

            List<MedicoGetModel> ListaAEnviar = new List<MedicoGetModel>();
            foreach(var item in medicos){
                MedicoGetModel Medico = new MedicoGetModel
                {
                    Id = item.Id,
                    Name = item.Name,
                    RegistroProfissional = item.RegistroProfissional,
                    Especialidade = item.Especialidade,
                    ConsultasMedicas = item.ConsultasMedicas
                };
                ListaAEnviar.Add(Medico);
            }
            return Ok(ListaAEnviar);
        }

        [HttpGet]
        [Route("/medicos/{id:int}")]
        public IActionResult Get([FromRoute] int id,
            [FromServices] AppDbContext context)
        {
            var medicoModel = context.Medicos!.FirstOrDefault(x => x.Id == id);
            if (medicoModel == null){
                return NotFound();
            }
            return Ok(medicoModel);
        }

        [HttpPost("/medicos")]
        public IActionResult Post([FromBody] MedicoModel medicoModel, [FromServices] AppDbContext context){

            var model = context.Medicos!.ToList();
            var count = 0;
            var aux = medicoModel.Especialidade;
            if (model != null){
                foreach(var item in model){
                    if (item.Id != count){
                        medicoModel.Especialidade = null;
                        medicoModel.Id = count;
                        context.Medicos!.Add(medicoModel);
                        context.SaveChanges();
                        medicoModel.Especialidade = aux;
                        context.Medicos!.Update(medicoModel);
                        context.SaveChanges();
                        return Created($"/{medicoModel.Id}", medicoModel);
                    }
                    count++;
                }
                medicoModel.Especialidade = null;
                medicoModel.Id = count;
                context.Medicos!.Add(medicoModel);
                context.SaveChanges();
                medicoModel.Especialidade = aux;
                context.Medicos!.Update(medicoModel);
                context.SaveChanges();
                return Created($"/{medicoModel.Id}", medicoModel);
            }
            medicoModel.Id = 0;
            medicoModel.Especialidade = null;
            medicoModel.Id = count;
            context.Medicos!.Add(medicoModel);
            medicoModel.Especialidade = aux;
            context.Medicos!.Update(medicoModel);
            context.SaveChanges();
            return Created($"/{medicoModel.Id}", medicoModel);
        }

        [HttpPut("/medicos")]
        public IActionResult Put(
        [FromBody] MedicoModel medicoModel,
        [FromServices] AppDbContext context){
            var model = context.Medicos!.FirstOrDefault(x => x.Id == medicoModel.Id);
            if (model == null){
                return NotFound();
            }

            model.ConsultasMedicas = medicoModel.ConsultasMedicas;
            model.Name = medicoModel.Name;
            model.RegistroProfissional = medicoModel.RegistroProfissional;
            model.Especialidade = medicoModel.Especialidade;

            context.Medicos!.Update(model);
            context.SaveChanges();
            return Ok(model);
        }

        [HttpDelete("/medicos/{id:int}")] 
        public IActionResult Delete([FromRoute] int id,
        [FromServices] AppDbContext context){
            var model = context.Medicos!.FirstOrDefault(x => x.Id == id);
            if (model == null){
                return NotFound();
            }

            context.Medicos!.Remove(model);
            context.SaveChanges();
            return Ok(model);
        }
    }
}