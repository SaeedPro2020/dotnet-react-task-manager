using System.ComponentModel.DataAnnotations;

namespace TaskManager.Api.DTOs;

public class CreateTaskDto
{
    [Required]
    [MaxLength(200)]
    public string Title { get; set; } = string.Empty;

    [MaxLength(1000)]
    public string Description { get; set; } = string.Empty;

    public DateTime? DueDate { get; set; }
}
