import 'package:flutter/material.dart';

class TaskModel {
  TaskModel({this.nameTask,
    this.descriptionTask,
    this.category,
    this.date,
    this.level,
    this.color});

  String? nameTask;
  String? descriptionTask;
  String? category;
  String? level;
  DateTime? date;
  Color? color;
  List<String> levels = ['High Important', 'Mid Important', 'Low Important'];
  List<String> categories = ['Work', 'Home', 'Study', 'Fun', 'Other'];
  List<Color> colors = [
    const Color.fromRGBO(206, 237, 199, 1),
    const Color.fromRGBO(215, 227, 252, 1),
    const Color.fromRGBO(255, 212, 178, 1),
    const Color.fromRGBO(255, 148, 148, 1),
    const Color.fromRGBO(255, 246, 189, 1),
  ];

  Map<String, dynamic> toJson() {
    return {
      'nameTask': nameTask,
      'category': category,
      'level': level,
      'descriptionTask': descriptionTask,
      'color':color,
      'date':date
    };
  }

  // تحويل JSON إلى كائن
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      nameTask: json['nameTask'],
      category: json['category'],
      level: json['level'],
      descriptionTask: json['descriptionTask'],
      color: json['color'],
      date: json['date']
    );
  }
}
