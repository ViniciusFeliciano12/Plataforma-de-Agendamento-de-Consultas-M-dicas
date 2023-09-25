using Events.API.Models;
using Events.Data;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;

namespace Events.API.Controllers
{
    [ApiController]
    [EnableCors("AllowAnyOrigin")]
    [Route("api/[controller]")]
    public class ConsultaController : ControllerBase
    {
        //Products
        [HttpGet]
        [Route("/consultas")]
        public IActionResult Get(
            [FromServices] AppDbContext context)
        {
            return Ok(context.Consultas!.ToList());
        }

        [HttpGet]
        [Route("/consultas/{id:int}")]
        public IActionResult Get(
            [FromRoute] int id,
            [FromServices] AppDbContext context)
        {
            var consultaModel = context.Consultas!.FirstOrDefault(x => x.Id == id);
            if (consultaModel == null){
                return NotFound();
            }
            return Ok(consultaModel);
        }

        [HttpPost("/consultas")]
        public IActionResult Post([FromBody] ConsultaModel consultaModel, [FromServices] AppDbContext context){
            var model = context.Consultas!.ToList();
            var count = 0;
            if (model != null){
                foreach(var item in model){
                    if (item.Id != count){
                        consultaModel.Id = count;
                        context.Consultas!.Add(consultaModel);
                        context.SaveChanges();
                        return Created($"/{consultaModel.Id}", consultaModel);
                    }
                    count++;
                }
                consultaModel.Id = count;
                context.Consultas!.Add(consultaModel);
                context.SaveChanges();
                return Created($"/{consultaModel.Id}", consultaModel);
            }
            consultaModel.Id = 0;
            context.Consultas!.Add(consultaModel);
            context.SaveChanges();
            return Created($"/{consultaModel.Id}", consultaModel);
        }

        [HttpPut("/consultas")]
        public IActionResult Put( 
        [FromBody] ConsultaModel consultaModel,
        [FromServices] AppDbContext context){
            var model = context.Consultas!.FirstOrDefault(x => x.Id == consultaModel.Id);
                if (model == null){
                    return NotFound();
                }

                model.MedicoId = consultaModel.MedicoId;
                model.PacienteId = consultaModel.PacienteId;
                model.TipoConsulta = consultaModel.TipoConsulta;
                model.DataEHora = consultaModel.DataEHora;
                model.Observacoes = consultaModel.Observacoes;


                context.Consultas!.Update(model);
                context.SaveChanges();
                return Ok(model);
        }

        [HttpDelete("/consultas/{id:int}")] 
        public IActionResult Delete([FromRoute] int id,
        [FromServices] AppDbContext context){
            var model = context.Consultas!.FirstOrDefault(x => x.Id == id);
            if (model == null){
                return NotFound();
            }

            context.Consultas!.Remove(model);
            context.SaveChanges();
            return Ok(model);
        }
    }
}