from abc import ABC, abstractmethod

class TodoInterface(ABC):

    @abstractmethod
    def create_todo(self, description):
        pass

    @abstractmethod
    def get_todos(self):
        pass