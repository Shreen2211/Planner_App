import 'dart:convert';
import 'package:planner/Model/task_model/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _prefs;

  SharedPreferencesService(this._prefs);

  // Save data
  Future<void> setData(String key, TaskModel task) async {
    String taskJson = jsonEncode(task.toJson());
    await _prefs.setString(key, taskJson);
  }

  // Get data
  TaskModel? getData(String key) {
    String? taskJson = _prefs.getString(key);
    if (taskJson != null) {
      Map<String, dynamic> taskMap = jsonDecode(taskJson);
      return TaskModel.fromJson(taskMap);
    }
    return null;
  }

  Future<void> saveTask(TaskModel task) async {
    final tasksString = _prefs.getString('tasks') ?? '[]';
    final List<dynamic> tasksList = jsonDecode(tasksString);

    tasksList.add(task.toJson());
    await _prefs.setString('tasks', jsonEncode(tasksList));
  }
  Future<List<TaskModel>> getTasks() async {
    final tasksString = _prefs.getString('tasks') ?? '[]';
    final List<dynamic> tasksList = jsonDecode(tasksString);

    // تحويل كل JSON إلى Object
    return tasksList.map((taskJson) => TaskModel.fromJson(taskJson)).toList();
  }
  // Remove data
  Future<void> removeData(String key) async {
    await _prefs.remove(key);
  }

  // Clear all data
  Future<void> clearData() async {
    await _prefs.clear();
  }
}
