import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import './model/todo.dart';
import './provider/todos.dart';
import './todoWidet.dart';

class TaskListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todos;
    // return todos.isEmpty
    //     ? Column(
    //         children: [
    //           Lottie.asset('assets/404empty.json'),
    //           Text(
    //             '0 Task Addded!!',
    //             style: TextStyle(fontSize: 20),
    //           ),
    //         ],
    //     )
    //     :
       return TodoWidget(isDone: true);

    // ListView.separated(
    //         physics: BouncingScrollPhysics(),
    //         padding: EdgeInsets.all(16),
    //         itemBuilder: (context, index) {
    //           final todo = todos[index];
    //          return TodoWidget(todo: todo);
    //         },
    //         separatorBuilder: (context, index) => Container(
    //               height: 8,
    //             ),
    //         itemCount: todos.length);
  }
}
