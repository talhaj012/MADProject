import 'package:authentication/main.dart';
import 'package:authentication/pages/user/task/Home%20Page/model/todo.dart';
import 'package:authentication/pages/user/task/Home%20Page/provider/todos.dart';
import 'package:authentication/pages/user/user_main.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Task_main.dart';
import '../api/firebase_api.dart';
import './addTask.dart';
import './taskWidget.dart';
import './completedListWidget.dart';


class TaskManager extends StatefulWidget {

  const TaskManager({Key? key}) : super(key: key);

  static String id = 'TaskManager';

  @override
  _TaskManagerState createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  int selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final tabs = [TaskListWidget(), CompletedListWidget()];

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> UserMain()));
            },
            child: Icon(Icons.arrow_back_ios_new,)),
        title: Text(TaskApp.title),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: selectedIndex,
        showElevation: true,
        backgroundColor: Theme.of(context).primaryColor,
        // unselectedItemColor: Colors.white.withOpacity(0.7),
        // selectedItemColor: Colors.white,
        // currentIndex: selectedIndex,
        // onTap: (index) {
        //   setState(() {
        //     selectedIndex = index;
        //   });
        // },

        onItemSelected: (index) => setState(() {
          selectedIndex = index;
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 300), curve: Curves.ease);
        }),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              activeColor: Colors.white,
              icon: Icon(Icons.fact_check_outlined),
              title: Text('Tasks')),
          // BottomNavyBarItem(
          //   activeColor: Colors.white,
          // icon: Icon(Icons.done),
          //     icon:
          //     title: Text('sjfbcj')),
          BottomNavyBarItem(activeColor: Colors.white,icon: Icon(Icons.done), title: Text('Archived')),
        ],
      ),

      body: Container(
        margin: EdgeInsets.all(20),
        child: SizedBox.expand(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() => selectedIndex = index);
                      },
                      children: [tabs[selectedIndex]],
                    ),
                  ),
      ),


      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
       floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AddTask(),
            ),
          );
        },
        backgroundColor: Colors.white,
         foregroundColor: Colors.purple,
        icon: Icon(
          Icons.add,
        ),
         label: Text('Add Task',
         style: TextStyle(
           fontWeight: FontWeight.bold
         ),
         ),
      ),
      // body: tabs[selectedIndex],
    );
  }
}
