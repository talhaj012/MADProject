import 'package:authentication/pages/user/task/api/firebase_api.dart';
import 'package:flutter/material.dart';
import '../model/todo.dart';

class TodosProvider extends ChangeNotifier {
  final List<Todo> _todos = [
    Todo(
        createdTime: DateTime.now(),
        // date: DateTime.now(),
        // time: TimeOfDay(hour: 7, minute: 0),
        title: 'Sample Task Title',
        description: 'Sample Task '
            'Description'),

  ];

  List<Todo> get todos {
    return
       _todos.where((todo) => todo.isDone == false).toList();
  }


  List<Todo> get todosCompleted =>
      _todos.where((todo) => todo.isDone == true).toList();


  void addTodoMethod(Todo todo) => FirebaseApi.createTodo(todo);
  // {
  //   _todos.add(todo);
  //
  //   notifyListeners();
  // }

  void removeTodoMethod(Todo todo){
    _todos.remove(todo);
    notifyListeners();
  }

  bool toggleTodoStatus(Todo todo){
    todo.isDone = !todo.isDone;
    notifyListeners();
    return todo.isDone;
  }

  void updateTodoMethod(Todo todo, String title, String description){
    todo.title = title;
    todo.description = description;
    notifyListeners();
  }

}
