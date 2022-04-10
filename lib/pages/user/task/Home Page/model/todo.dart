import 'package:authentication/pages/user/task/Home%20Page/utils.dart';
import 'package:flutter/src/material/time.dart';
// import 'package:flutter/cupertino.dart';
import '../utils.dart';

class TodoField {
  static const createdTime = 'createdTime';
  // static const date = 'date';
  // static const time = 'time';
}

class Todo {
  DateTime createdTime;
  String title;
  String id;
  String description;
  // DateTime date;
  // TimeOfDay time;
  bool isDone;

  Todo({
      required this.createdTime,
      required this.title,
      this.description = '',
      this.id = '',
      // required this.date,
      // required this.time,
      this.isDone = false,
      });

  // static Todo fromJson(Map<String, dynamic> json) => Todo(
  //     createdTime: Utils.toDateTime(json["createdTime"]),
  //     title: json['title'],
  //     description: json['description'],
  //     id: json['id'],
  //     date: Utils.toDateTime(json["date"]),
  //     time: Utils.toDateTime(json["time"]),
  //     isDone: json['isDone']
  // );


  Map<String, dynamic> toJson() => {
      'createdTime': Utils.fromDateTimeToJson(createdTime),
      'title' : title,
      'description' : description,
      'id' : id,
      // 'date': date,
      // 'time': time,
      'isDone': isDone
  };

}
