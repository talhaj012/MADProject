import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Home Page/taskManager.dart';
import 'Home Page/provider/todos.dart';

// void main() {
//   runApp(MyApp());
// }

class TaskApp extends StatelessWidget {
  static final String title = 'Task Manager';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodosProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          scaffoldBackgroundColor: Color(0xFFf6f5ee),
        ),
        home: TaskManager(),
        initialRoute: TaskManager.id,
      ),
    );
  }
}
