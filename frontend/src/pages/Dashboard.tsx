import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAppDispatch, useAppSelector } from '../store/hooks';
import { logout } from '../store/authSlice';
import { fetchTasks, deleteTask, createTask, updateTask } from '../store/tasksSlice';
import TaskModal from '../components/TaskModal';
import { Task } from '../types';

const Dashboard: React.FC = () => {
  const navigate = useNavigate();
  const dispatch = useAppDispatch();
  const { user } = useAppSelector((state) => state.auth);
  const { tasks, isLoading } = useAppSelector((state) => state.tasks);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editingTask, setEditingTask] = useState<Task | null>(null);

  useEffect(() => {
    dispatch(fetchTasks());
  }, [dispatch]);

  const handleLogout = () => {
    dispatch(logout());
    navigate('/login');
  };

  const handleDeleteTask = async (id: number) => {
    if (window.confirm('Are you sure you want to delete this task?')) {
      await dispatch(deleteTask(id));
    }
  };

  const handleEditTask = (task: Task) => {
    setEditingTask(task);
    setIsModalOpen(true);
  };

  const handleCreateTask = () => {
    setEditingTask(null);
    setIsModalOpen(true);
  };

  const handleToggleComplete = async (task: Task) => {
    await dispatch(
      updateTask({
        id: task.id,
        task: {
          title: task.title,
          description: task.description,
          isCompleted: !task.isCompleted,
          dueDate: task.dueDate,
        },
      })
    );
  };

  return (
    <div style={{ padding: '20px' }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '20px' }}>
        <div>
          <h1>Task Manager</h1>
          <p>Welcome, {user?.firstName}!</p>
        </div>
        <button
          onClick={handleLogout}
          style={{ padding: '10px 20px', backgroundColor: '#dc3545', color: 'white', border: 'none', cursor: 'pointer' }}
        >
          Logout
        </button>
      </div>

      <button
        onClick={handleCreateTask}
        style={{ padding: '10px 20px', backgroundColor: '#28a745', color: 'white', border: 'none', cursor: 'pointer', marginBottom: '20px' }}
      >
        + Create New Task
      </button>

      {isLoading ? (
        <p>Loading tasks...</p>
      ) : (
        <div style={{ display: 'grid', gap: '15px' }}>
          {tasks.length === 0 ? (
            <p>No tasks found. Create your first task!</p>
          ) : (
            tasks.map((task) => (
              <div
                key={task.id}
                style={{
                  border: '1px solid #ddd',
                  padding: '15px',
                  borderRadius: '5px',
                  backgroundColor: task.isCompleted ? '#f0f0f0' : 'white',
                }}
              >
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'start' }}>
                  <div style={{ flex: 1 }}>
                    <h3 style={{ textDecoration: task.isCompleted ? 'line-through' : 'none' }}>
                      {task.title}
                    </h3>
                    <p>{task.description}</p>
                    {task.dueDate && (
                      <p style={{ fontSize: '0.9em', color: '#666' }}>
                        Due: {new Date(task.dueDate).toLocaleDateString()}
                      </p>
                    )}
                  </div>
                  <div style={{ display: 'flex', gap: '10px' }}>
                    <button
                      onClick={() => handleToggleComplete(task)}
                      style={{ padding: '5px 10px', backgroundColor: task.isCompleted ? '#ffc107' : '#28a745', color: 'white', border: 'none', cursor: 'pointer' }}
                    >
                      {task.isCompleted ? 'Undo' : 'Complete'}
                    </button>
                    <button
                      onClick={() => handleEditTask(task)}
                      style={{ padding: '5px 10px', backgroundColor: '#007bff', color: 'white', border: 'none', cursor: 'pointer' }}
                    >
                      Edit
                    </button>
                    <button
                      onClick={() => handleDeleteTask(task.id)}
                      style={{ padding: '5px 10px', backgroundColor: '#dc3545', color: 'white', border: 'none', cursor: 'pointer' }}
                    >
                      Delete
                    </button>
                  </div>
                </div>
              </div>
            ))
          )}
        </div>
      )}

      {isModalOpen && (
        <TaskModal
          task={editingTask}
          onClose={() => setIsModalOpen(false)}
          onSave={() => {
            setIsModalOpen(false);
            dispatch(fetchTasks());
          }}
        />
      )}
    </div>
  );
};

export default Dashboard;
