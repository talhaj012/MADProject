import './task/Task_main.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Text('Categories',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30
            ),
          ),
        ),
        FlatButton(
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TaskApp()));

          },
          child: Container(
            // height: 80,
            // padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            // color: Colors.grey,
            child: Card(
              // color: Colors.purple[100],
              elevation: 10,
              child: ListTile(
                iconColor: Colors.purple,
                leading: Icon(Icons.task_alt_rounded),
                title: Text('Task Manager',
                  style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                    color: Colors.purple
                  ),
                ),
                // trailing: Icon(Icons.task_alt_outlined),
              ),
            ),
          ),
        ),
        FlatButton(
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TaskApp()));

          },
          child: Container(
            // height: 80,
            // padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            margin: EdgeInsets.symmetric(horizontal: 20),
            // color: Colors.grey,
            child: Card(
              // color: Colors.purple[100],
              elevation: 10,
              child: ListTile(
                iconColor: Colors.purple,
                leading: Icon(Icons.hourglass_bottom),
                title: Text('Habit Manager',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.purple
                  ),
                ),
                // trailing: Icon(Icons.task_alt_outlined),
              ),
            ),
          ),
        )
      ],
    );
  }
}
