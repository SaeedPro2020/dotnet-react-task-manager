export interface User {
  id: number;
  email: string;
  firstName: string;
  lastName: string;
}

export interface Task {
  id: number;
  title: string;
  description: string;
  isCompleted: boolean;
  createdAt: string;
  dueDate: string | null;
  userId: number;
}

export interface AuthResponse {
  token: string;
  userId: number;
  email: string;
  firstName: string;
  lastName: string;
}

export interface LoginRequest {
  email: string;
  password: string;
}

export interface RegisterRequest {
  email: string;
  password: string;
  firstName: string;
  lastName: string;
}

export interface CreateTaskRequest {
  title: string;
  description: string;
  dueDate?: string | null;
}

export interface UpdateTaskRequest {
  title: string;
  description: string;
  isCompleted: boolean;
  dueDate?: string | null;
}
