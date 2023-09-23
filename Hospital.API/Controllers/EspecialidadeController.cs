using Events.API.Models;
using Events.Data;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;

namespace Events.API.Controllers
{
    [ApiController]
    [EnableCors("AllowAnyOrigin")]
    [Route("api/[controller]")]
    public class EspecialidadeController : ControllerBase
    {
        //Products
        [HttpGet]
        [Route("/especialidades")]
        public IActionResult Get(
            [FromServices] AppDbContext context)
        {
            return Ok(context.Especialidades!.ToList());
        }

        [HttpGet]
        [Route("/especialidades/{id:int}")]
        public IActionResult Get([FromRoute] int id,
            [FromServices] AppDbContext context)
        {
            var especialidadeModel = context.Especialidades!.FirstOrDefault(x => x.Id == id);
            if (especialidadeModel == null){
                return NotFound();
            }
            return Ok(especialidadeModel);
        }

        [HttpPost("/especialidades")]
        public IActionResult Post([FromBody] EspecialidadeModel especialidadeModel, [FromServices] AppDbContext context){

            var model = context.Especialidades!.ToList();
            var count = 0;
            if (model != null){
                foreach(var item in model){
                    if (item.Id != count){
                        especialidadeModel.Id = count;
                        context.Especialidades!.Add(especialidadeModel);
                        context.SaveChanges();
                        return Created($"/{especialidadeModel.Id}", especialidadeModel);
                    }
                    count++;
                }
                especialidadeModel.Id = count;
                context.Especialidades!.Add(especialidadeModel);
                context.SaveChanges();
                return Created($"/{especialidadeModel.Id}", especialidadeModel);
            }
            especialidadeModel.Id = 0;
            context.Especialidades!.Add(especialidadeModel);
            context.SaveChanges();
            return Created($"/{especialidadeModel.Id}", especialidadeModel);
        }

        [HttpPut("/especialidades")]
        public IActionResult Put([FromRoute] int id, 
        [FromBody] EspecialidadeModel especialidadeModel,
        [FromServices] AppDbContext context){
            var model = context.Especialidades!.FirstOrDefault(x => x.Id == id);
                if (model == null){
                    return NotFound();
                }

               model.Descricao = especialidadeModel.Descricao;
               model.Especialidade = especialidadeModel.Especialidade;

                context.Especialidades!.Update(model);
                context.SaveChanges();
                return Ok(model);
        }

        [HttpDelete("/especialidades/{id:int}")] 
        public IActionResult Delete([FromRoute] int id,
        [FromServices] AppDbContext context){
            var model = context.Especialidades!.FirstOrDefault(x => x.Id == id);
            if (model == null){
                return NotFound();
            }

            context.Especialidades!.Remove(model);
            context.SaveChanges();
            return Ok(model);
        }
    }
}