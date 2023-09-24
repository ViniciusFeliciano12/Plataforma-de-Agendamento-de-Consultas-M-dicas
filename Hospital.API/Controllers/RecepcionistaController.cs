using Events.API.Models;
using Events.Data;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;

namespace Events.API.Controllers
{
    [ApiController]
    [EnableCors("AllowAnyOrigin")]
    [Route("api/[controller]")]
    public class RecepcionistaController : ControllerBase
    {

        [HttpGet]
        [Route("/recepcionistas")]
        public IActionResult GetProducts(
            [FromServices] AppDbContext context)
        {
            return Ok(context.Recepcionistas!.ToList());
        }

        [HttpGet]
        [Route("/recepcionistas/{id:int}")]
        public IActionResult GetProducts([FromRoute] int id,
            [FromServices] AppDbContext context)
        {
            var productsModel = context.Recepcionistas!.FirstOrDefault(x => x.Id == id);
            if (productsModel == null){
                return NotFound();
            }
            return Ok(productsModel);
        }

        [HttpPost("/recepcionistas")]
        public IActionResult PostProducts([FromBody] RecepcionistaModel recepcionistaModel, [FromServices] AppDbContext context){
            var model = context.Recepcionistas!.ToList();
            var count = 0;
            if (model != null){
                foreach(var item in model){
                    if (item.Id != count){
                        recepcionistaModel.Id = count;
                        context.Recepcionistas!.Add(recepcionistaModel);
                        context.SaveChanges();
                        return Created($"/{recepcionistaModel.Id}", recepcionistaModel);
                    }
                    count++;
                }
                recepcionistaModel.Id = count;
                context.Recepcionistas!.Add(recepcionistaModel);
                context.SaveChanges();
                return Created($"/{recepcionistaModel.Id}", recepcionistaModel);
            }
            recepcionistaModel.Id = 0;
            context.Recepcionistas!.Add(recepcionistaModel);
            context.SaveChanges();
            return Created($"/{recepcionistaModel.Id}", recepcionistaModel);
        }

        [HttpPut("/recepcionistas")]
        public IActionResult PutProducts( 
        [FromBody] RecepcionistaModel recepcionistaModel,
        [FromServices] AppDbContext context){
            var model = context.Recepcionistas!.FirstOrDefault(x => x.Id == recepcionistaModel.Id);
            if (model == null){
                return NotFound();
            }

            model.Name = recepcionistaModel.Name;
            model.Sobrenome = recepcionistaModel.Sobrenome;
            model.Telefone = recepcionistaModel.Telefone;

            context.Recepcionistas!.Update(model);
            context.SaveChanges();
            return Ok(model);
        }

        [HttpDelete("/recepcionistas/{id:int}")]
        public IActionResult DeleteProducts([FromRoute] int id,
        [FromServices] AppDbContext context){
            var model = context.Recepcionistas!.FirstOrDefault(x => x.Id == id);
            if (model == null){
                return NotFound();
            }

            context.Recepcionistas!.Remove(model);
            context.SaveChanges();
            return Ok(model);
        }
    }
}