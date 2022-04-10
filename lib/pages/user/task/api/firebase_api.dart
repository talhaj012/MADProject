import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Home Page/model/todo.dart';


class FirebaseApi {
  static Future<String> createTodo(Todo todo) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final email = FirebaseAuth.instance.currentUser!.email;
    final docTodo = FirebaseFirestore.instance.collection('/$email/$uid/tasks').doc();

    todo.id = docTodo.id;
    await docTodo.set(todo.toJson());

    return docTodo.id;
  }


}