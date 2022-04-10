import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import './taskManager.dart';
import 'package:provider/provider.dart';
import 'todoWidet.dart';
import './provider/todos.dart';
import './model/todo.dart';

class EditTodoPage extends StatefulWidget {
  final String id;

  const EditTodoPage({Key? key, required this.id}) : super(key: key);

  @override
  _EditTodoPageState createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final _formKey = GlobalKey<FormState>();

  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;

  late String title;
  late String description;

  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay(hour: 7, minute: 0);

  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  void initState(){
    super.initState();
    getDataFrom();
    // title = widget.todo.title;
    // description = widget.todo.description;
  }

  getDataFrom() async{

    final ref = FirebaseFirestore.instance.collection('/$email/$uid/tasks');

    final data = await ref.doc(widget.id).get();

    titleController.text = data['title'];
    descController.text = data['description'];
  }

  EditTaskAction(){
    final isValid = _formKey.currentState?.validate();

    if(!isValid!){
      return;
    }
    else{
      FirebaseFirestore.instance.collection('/$email/$uid/tasks').doc(widget.id).update(
        {
          'title': titleController.text,
          'description': descController.text
        }
      );
      // final provider = Provider.of<TodosProvider>(context,listen: false);
      // provider.updateTodoMethod(widget.todo, title, description);
      Navigator.of(context).pop();

    }
  }


  // getting the text date

  String getDateText(){
    if(date == null){
      return 'Select Date';
    }
    else{
      return DateFormat('dd/MM/yyyy').format(date);
      // return '${date.day}/${date.month}/${date.year}';
    }
  }


  // date picker
  Future pickDate(BuildContext context) async{
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: date ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate:  DateTime(DateTime.now().year + 5),
    );

    if(newDate == null){
      return;
    }
    setState(() {
      date = newDate;
    });
  }


  // time getter text

  String getTimeText(){
    if(time == null){
      return 'Select Time';
    }
    else{
      final hours = time.hour.toString().padLeft(2,'0');
      final minutes = time.minute.toString().padLeft(2,'0');

      return '$hours:$minutes';
    }

  }

  // Time picker

  Future pickTime(BuildContext context) async{
    final initialTime = TimeOfDay(hour: 7, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: time ?? initialTime,
    );

    if(newTime == null){
      return;
    }
    setState(() {
      time = newTime;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskManager(),
                ),
              );
            },
            child: Icon(Icons.arrow_back_ios_new)),
        title: Text('Edit Tasks'),
        actions: [
          IconButton(
              onPressed: (){
                FirebaseFirestore.instance.collection('/$email/$uid/tasks').doc(widget.id).delete();
                // final provider = Provider.of<TodosProvider>(context,listen: false);
                // provider.removeTodoMethod(widget.todo);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TaskManager()));
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: ListView(
            children: [
              Container(
                width: 70,
                height: 300,
                child: Lottie.asset('assets/edit-task.json'),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  maxLines: 1,
                  decoration: InputDecoration(
                    labelText: 'Enter Title:',
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    errorStyle:
                    TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  autofocus: false,
                  controller: titleController,
                  onChanged: (title) {
                    setState(() {
                      this.title = title;
                    });
                  },
                  validator: (title) {
                    if (title!.isEmpty) {
                      return 'The title cannot be empty';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Enter Description:',
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    errorStyle:
                    TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  autofocus: false,
                  controller: descController,
                  onChanged: (description) {
                    setState(() {
                      this.description = description;
                    });
                  },
                  validator: (title) {
                    if (title!.isEmpty) {
                      return 'The description cannot be empty';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  onTap: (){
                    pickDate(context);
                  },
                  tileColor: Colors.grey[200],
                  title: Text(getDateText()),
                  trailing: Icon(Icons.date_range_outlined),
                  iconColor: Colors.purple,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  onTap: (){
                    pickTime(context);
                  },
                  title: Text(getTimeText()),
                  trailing: Icon(Icons.access_time),
                  iconColor: Colors.purple,
                  tileColor: Colors.grey[200],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        title = titleController.text;
                        description = descController.text;
                      });
                    }
                    EditTaskAction();
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  child: Text(
                    'Edit',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
