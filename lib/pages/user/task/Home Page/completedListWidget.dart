import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import './todoWidet.dart';
import './provider/todos.dart';


class CompletedListWidget extends StatelessWidget {
  const CompletedListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todosCompleted;
    // return todos.isEmpty
    //     ? Column(
    //       children: [
    //             Lottie.asset('assets/404empty.json'),
    //             Text(
    //           'No Completed Tasks!!',
    //            style: TextStyle(fontSize: 20),
    //             ),
    //       ],
    //     )
    //     :
    return TodoWidget(isDone: false);


    // ListView.separated(
    //     physics: BouncingScrollPhysics(),
    //     padding: EdgeInsets.all(16),
    //     itemBuilder: (context, index) {
    //       final todo = todos[index];
    //       return TodoWidget();
    //     },
    //     separatorBuilder: (context, index) => Container(
    //       height: 8,
    //     ),
    //     itemCount: todos.length);
  }
}
