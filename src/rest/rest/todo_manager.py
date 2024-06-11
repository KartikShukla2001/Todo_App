
from pymongo import MongoClient
import os
from .todo_interface import TodoInterface

mongo_uri = 'mongodb://' + os.environ["MONGO_HOST"] + ':' + os.environ["MONGO_PORT"]
db = MongoClient(mongo_uri)['test_db']

class TodoManager(TodoInterface):

    def create_todo(self, description):
        todo = {
            "description": description
        }
        result = db.todos.insert_one(todo)
        return str(result.inserted_id)

    def get_todos(self):
        todos = list(db.todos.find({}, {"_id": 1, "description": 1}))
        for todo in todos:
            todo["_id"] = str(todo["_id"])
        return todos
