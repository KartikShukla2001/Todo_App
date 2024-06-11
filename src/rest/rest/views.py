from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
import json, logging, os
from pymongo import MongoClient
from .todo_factory import TodoFactory

class TodoListView(APIView):

    def get(self, request):
        # Implement this method - return all todo items from db instance above.
        task = request.query_params.get('task', 'todo')
        try:
            todo_manager = TodoFactory.get_todo_manager(task)
            todos = todo_manager.get_todos()
            return Response(todos, status=status.HTTP_200_OK)
        except ValueError as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)
        
    def post(self, request):
        # Implement this method - accept a todo item in a mongo collection, persist it using db instance above.
        task = request.query_params.get('task', 'todo')
        try:
            todo_manager = TodoFactory.get_todo_manager(task)
            description = request.data.get('description')
            if not description:
                return Response({"error": "Description is required"}, status=status.HTTP_400_BAD_REQUEST)
            todo_id = todo_manager.create_todo(description)
            return Response({"id": todo_id, "description": description}, status=status.HTTP_201_CREATED)
        except ValueError as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)
