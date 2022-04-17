import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import './taskManager.dart';
import './model/todo.dart';
import './provider/todos.dart';
import '../api/notification_api.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay(hour: 7, minute: 0);

  final titleController = TextEditingController();
  final descController = TextEditingController();

  int alarmId = 2;

  // printAlarmStatus(){
  //   print('Alarm fired at ${DateTime.now()}');
  // }
  //
  // AddNotification()async{
  //   await WidgetsFlutterBinding.ensureInitialized();
  //   await AndroidAlarmManager.initialize();
  //   AndroidAlarmManager.oneShot(Duration(seconds: 3), alarmId, printAlarmStatus);
  // }
  //



  AddTaskAction(){
    final isValid = _formKey.currentState?.validate();
    if(!isValid!){
      return;
    }else{
      final todo = Todo(
          id: DateTime.now().toString(),
          title: title,
          description:description,
          // date:date,
          // time:time,
          createdTime: DateTime.now()
      );

      final provider = Provider.of<TodosProvider>(context,listen: false);
      provider.addTodoMethod(todo);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TaskManager()));
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
      initialDate: DateTime.now(),
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
      initialTime: TimeOfDay(hour: 8, minute: 10),
    );

    if(newTime == null){
      return;
    }
    setState(() {
      time = newTime;
    });
  }


  @override
  void initstate(){
    super.initState();

    NotificationApi.init();
    listenNotifications();
  }

  void listenNotifications(){
    NotificationApi.onNotifications.stream.listen(onClickedNotification);
  }

  void onClickedNotification(String? payload){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> TaskManager()));
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
        title: Text('Add Tasks'),
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
                child: Lottie.asset('assets/add-task.json'),
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
                  onChanged: (value) {
                    title = value;
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
                  onChanged: (value) {
                    description = value;
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
                    NotificationApi.showScheduledNotification(
                        title: 'talha',
                        body: 'This is my name in the notification',
                        payload:'sample payload',
                        scheduledDate: DateTime.now().add(Duration(seconds: 3))
                    );


                    AddTaskAction();

                    final snackBar = SnackBar(
                        content: Text('Task added Successfully!!!'),
                      backgroundColor: Colors.green,
                    );
                    ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(snackBar);
                    // AddNotification();

                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      shadowColor: Colors.black,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  child: Text(
                    'Add',
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
