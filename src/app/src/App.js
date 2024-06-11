import './App.css';
import logo from './logo.svg';
import React, { useState, useEffect } from 'react';

const TodoList = ({ todos }) => {
  return (
    <ul>
      {todos.map((todo) => (
        <li key={todo._id}>{todo.description}</li>
      ))}
    </ul>
  );
};

const TodoForm = ({ setTodos }) => {
  const [todo, setTodo] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await fetch('http://localhost:8000/todos/?task=todo', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ description: todo }),
      });
      if (response.ok) {
        console.log('Todo added successfully');
        setTodo('');

        // Fetch updated list of todos after successful POST request
        const updatedResponse = await fetch('http://localhost:8000/todos/');
        if (updatedResponse.ok) {
          const updatedData = await updatedResponse.json();
          setTodos(updatedData);
        } else {
          console.error('Failed to fetch updated todos');
        }
      } else {
        console.error('Failed to add todo');
      }
    } catch (error) {
      console.error('Error:', error);
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        type="text"
        value={todo}
        onChange={(e) => setTodo(e.target.value)}
        placeholder="Enter TODO description"
      />
      <button type="submit">Add Todo</button>
    </form>
  );
};

export function App() {
  const [todos, setTodos] = useState([]);

  useEffect(() => {
    const fetchTodos = async () => {
      try {
        const response = await fetch('http://localhost:8000/todos/');
        if (response.ok) {
          const data = await response.json();
          setTodos(data);
        } else {
          console.error('Failed to fetch todos');
        }
      } catch (error) {
        console.error('Error:', error);
      }
    };
    fetchTodos();
  }, []);

  return (
    <div>
      <h1>TODO List</h1>
      <TodoList todos={todos} />
      <h1>TODO Form</h1>
      <TodoForm setTodos={setTodos} />
    </div>
  );
};

export default App;
