import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// class ExpenseList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new StreamBuilder<QuerySnapshot>(
//         stream: Firestore.instance.collection("firestore-example-app/").snapshots,
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) return new Text("There is no expense");
//           return new ListView(children: getExpenseItems(snapshot));
//         });
//   }
//
//   getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
//     return snapshot.data.documents
//         .map((doc) => new ListTile(
//             title: new Text(doc["name"]),
//             subtitle: new Text(doc["amount"].toString())))
//         .toList();
//   }
// }

class ReadScreen extends StatefulWidget {
  const ReadScreen({Key? key}) : super(key: key);

  @override
  _ReadScreenState createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  void addData() async {
    final ref = FirebaseFirestore.instance;
    await ref.collection("Task").add({"task": task});
  }

  String? task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('read Screen')),
      body: Column(
        children: [
          TextFormField(
            onChanged: (value) {
              setState(() {
                task = value;
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
              addData();
            },
            child: Text('click Me'),
          )
        ],
      ),
    );
  }
}
