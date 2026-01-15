using AutoMapper;
using FormulaOne.DataService.Repositories.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace FormulaOne.Api.Controllers;

[Route("api/[controller]")]
[ApiController]
public class BaseController : ControllerBase
{
    protected readonly IMapper _mapper;
    protected readonly IUnitOfWork _unitOfWork;

    public BaseController(
        IUnitOfWork unitOfWork,
        IMapper mapper)
    {
        _unitOfWork = unitOfWork;
        _mapper = mapper;
    }
}