import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import './model/todo.dart';
import './provider/todos.dart';
import './utils.dart';
import './taskManager.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'editTask.dart';

class TodoWidget extends StatelessWidget {
  final bool isDone;

  TodoWidget({required this.isDone, Key? key}) : super(key: key);

  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;



  deleteTodoAction(BuildContext context, String id){
    FirebaseFirestore.instance.collection('/$email/$uid/tasks').doc(id).delete();

    // final provider = Provider.of<TodosProvider>(context,listen: false);
    // provider.removeTodoMethod(todo);
    // Utils.showSnackBar(context,'Task Deleted!!');
  }

  editTodoAction(BuildContext context,String id){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditTodoPage(id:id),
      ),
    );

  }





  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: isDone? FirebaseFirestore.instance.collection('/$email/$uid/tasks').where('isDone', isEqualTo:false).snapshots() : FirebaseFirestore.instance.collection('/$email/$uid/tasks').where('isDone', isEqualTo: true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        else if(!snapshot.data!.docs.isEmpty){
          return Container(
            // height: ,
            // width: 100,
            child: ListView(
                shrinkWrap: true,
                children:
                  getTasks(snapshot,context)
            ),
          );

        }
        return Center(
                child: Column(
                  children: [
                    Lottie.asset('assets/404empty.json'),
                    Text(
                      '0 Task Addded!!',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                )
            );




        //
        // return ClipRRect(
        //   borderRadius: BorderRadius.circular(16),
        //   child: Slidable(
        //     startActionPane: ActionPane(
        //       motion: ScrollMotion(),
        //       children: [
        //         SlidableAction(
        //           onPressed: (context) => editTodoAction(context,todo),
        //           backgroundColor: Colors.green,
        //           foregroundColor: Colors.white,
        //           icon: Icons.edit,
        //           label: 'Edit',
        //         ),
        //       ],
        //     ),
        //     endActionPane: ActionPane(
        //       motion: ScrollMotion(),
        //       children: [
        //         SlidableAction(
        //           onPressed:(context)=> deleteTodoAction(context,todo),
        //           backgroundColor: Colors.red,
        //           foregroundColor: Colors.white,
        //           icon: Icons.delete,
        //           label: 'Delete',
        //         ),
        //       ],
        //     ),
        //     key: Key(todo.id),
        //
        //     // child: buildTodo(context),
        //   ),
        // );



      }
    );
  }
  
   List<Container>getTasks(AsyncSnapshot<QuerySnapshot> snapshot, BuildContext context){
    return snapshot.data!.docs
        .map((doc) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Slidable(
                // isDone?
                // if(isDone == false)
                startActionPane:  isDone? ActionPane(
                  // motion: ,
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      // onPressed:(context){},
                      onPressed: (context) => editTodoAction(context,doc['id']),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Edit',
                    ),
                  ],
                )
                : null,
                endActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      // onPressed:(context){},
                      onPressed: (context)=> deleteTodoAction(context,doc['id']),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                key: Key('123'),
                child: Container(
                  color: Colors.white,
                  // margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        // padding: EdgeInsets.all(20),
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          leading: Checkbox(
                                      value: false,
                                      // value: todo.isDone,
                                      activeColor: Theme.of(context).primaryColor,
                                      checkColor: Colors.white,
                                      onChanged: (value) {
                                        // final provider = Provider.of<TodosProvider>(context,listen: false);
                                        // final isDone = provider.toggleTodoStatus(todo);
                                        // Utils.showSnackBar(context,
                                        //   isDone ? 'Task Completed' : 'Task Marked incomplete'
                                        // );

                                        isDone?
                                        FirebaseFirestore.instance.collection('/$email/$uid/tasks').doc(doc['id'])
                                            .update({
                                          'isDone': true
                                        })
                                        :FirebaseFirestore.instance.collection('/$email/$uid/tasks').doc(doc['id'])
                                            .update({
                                          'isDone': false
                                        });

                                      },
                                    ),
                          title: Text(doc["title"]),
                          subtitle: Text(doc["description"].toString(),),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                        child: Row(
                          children: [
                            Text('Swipe Right to Edit/',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontStyle: FontStyle.italic
                              ),
                            ),
                            SizedBox(width: 20,),
                            Text('Swipe Left to Delete/',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontStyle: FontStyle.italic
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                // child: buildTodo(context),
              ),
            ),
          );

      // ListTile(
      //         title: Text(doc["title"]),
      //         subtitle: Text(doc["description"].toString(),),
      //         );
          })
        .toList();
  }
  }

  // Widget buildTodo(BuildContext context) {
  //   return Container(
  //     color: Colors.white,
  //     padding: EdgeInsets.all(20),
  //     child: Row(
  //       children: [
  //         Checkbox(
  //           value: todo.isDone,
  //           activeColor: Theme.of(context).primaryColor,
  //           checkColor: Colors.white,
  //           onChanged: (value) {
  //             final provider = Provider.of<TodosProvider>(context,listen: false);
  //
  //             final isDone = provider.toggleTodoStatus(todo);
  //             Utils.showSnackBar(context,
  //               isDone ? 'Task Completed' : 'Task Marked incomplete'
  //             );
  //           },
  //         ),
  //         SizedBox(
  //           width: 20,
  //         ),
  //
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 // getTitleFromDatabase(),
  //                 todo.title,
  //                 style: TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                     color: Theme.of(context).primaryColor,
  //                     fontSize: 22),
  //               ),
  //               if (todo.description.isNotEmpty)
  //                 Container(
  //                   child: Text(
  //                     todo.description,
  //                     style: TextStyle(fontSize: 20, height: 1.5),
  //                   ),
  //                 ),
  //               SizedBox(
  //                 height:20
  //               ),
  //               Container(
  //                 child: Row(
  //                   children: [
  //                     Text('Swipe Right to Edit/',
  //                       style: TextStyle(
  //                         color: Colors.green,
  //                         fontStyle: FontStyle.italic
  //                       ),
  //                     ),
  //                     SizedBox(width: 20,),
  //                     Text('Swipe Left to Delete/',
  //                         style: TextStyle(
  //                         color: Colors.red,
  //                         fontStyle: FontStyle.italic
  //                     ),
  //                     ),
  //                   ],
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

