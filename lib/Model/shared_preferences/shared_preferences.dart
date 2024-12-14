import 'dart:convert';
import 'package:planner/Model/task_model/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsManager {
  static final SharedPrefsManager _instance = SharedPrefsManager._internal();
  late final SharedPreferences _prefs;

  // Private Constructor
  SharedPrefsManager._internal();

  static SharedPrefsManager get instance => _instance;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  SharedPrefsManager(this._prefs);

  Future<void> setTask(TaskModel task) async {
    String? taskString = _prefs.getString('tasksList');
    List<TaskModel> tasks = taskString != null
        ? (jsonDecode(taskString) as List)
            .map((json) => TaskModel.fromJson(json))
            .toList()
        : [];
    tasks.add(task);
    String updateList = jsonEncode(tasks.map((task) => task.toJson()).toList());
    await _prefs.setString('tasksList', updateList);
  }

  List<TaskModel> getTasks() {
    String? taskString = _prefs.getString('tasksList');
    List<TaskModel> tasks = taskString != null
        ? (jsonDecode(taskString) as List)
            .map((json) => TaskModel.fromJson(json))
            .toList()
        : [];
    return tasks;
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
