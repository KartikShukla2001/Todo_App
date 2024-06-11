from .todo_manager import TodoManager

class TodoFactory:

    @staticmethod
    def get_todo_manager(task):
        if task == 'todo':
            return TodoManager()
        else:
            raise ValueError(f"Unknown manager type: {task}")
