using TaskManager.Api.DTOs;

namespace TaskManager.Api.Services;

public interface ITaskService
{
    Task<IEnumerable<TaskResponseDto>> GetUserTasksAsync(int userId);
    Task<TaskResponseDto?> GetTaskByIdAsync(int taskId, int userId);
    Task<TaskResponseDto> CreateTaskAsync(CreateTaskDto createTaskDto, int userId);
    Task<TaskResponseDto?> UpdateTaskAsync(int taskId, UpdateTaskDto updateTaskDto, int userId);
    Task<bool> DeleteTaskAsync(int taskId, int userId);
}
