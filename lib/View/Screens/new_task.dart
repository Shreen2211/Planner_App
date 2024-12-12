import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:planner/Model/shared_preferences/shared_preferences.dart';
import 'package:planner/Model/task_model/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  DateTime? selectTime;
  String? selectedLevel;
  String? selectedCategory;
  Color? chooseColor;
  late TaskModel newTask;
  List? tasks;
  TextEditingController? controllerName = TextEditingController();
  TextEditingController? controllerDescription = TextEditingController();
  late SharedPreferencesService sharedPreferencesService;

  @override
  void initState() {
    super.initState();
    initShared();
  }

  void initShared() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    sharedPreferencesService = SharedPreferencesService(pref);
    loadTasks();
  }

  Future<void> loadTasks() async {
    final loadedTasks = await sharedPreferencesService.getTasks();
    setState(() {
      tasks = loadedTasks;
    });
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectTime) {
      setState(() {
        selectTime = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> task = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
       // backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15)
              ),
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(20),
              child: Form(
                  key: task,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: controllerName,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Name'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        maxLines: 3,
                        controller: controllerDescription,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Description'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black)),
                        child: DropdownButton(
                          hint: const Text('Category'),
                          value: selectedCategory,
                          items: TaskModel().categories.map((String option) {
                            return DropdownMenuItem<String>(
                                value: option, child: Text(option));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black)),
                        child: DropdownButton(
                          hint: const Text('Level Import'),
                          value: selectedLevel,
                          items: TaskModel().levels.map((String option) {
                            return DropdownMenuItem<String>(
                                value: option, child: Text(option));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedLevel = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                   InkWell(
                     onTap: (){
                       setState(() {
                         _selectDate(context);
                       });
                     },
                     child: Container(
                       height: 60,
                       width: double.infinity,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(6),
                         border:Border.all(
                           color: Colors.black
                         )
                       ),
                       child: Center(child: selectTime != null? Text('$selectTime'):Text('Start Date')),
                     ),
                   ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 70,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: (){
                                  setState(() {
                                    chooseColor=TaskModel().colors[index];
                                  });
                                },
                                child: Container(
                                  width: 55,
                                  margin: const EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: TaskModel().colors[index]),
                                ),
                              );
                            },
                            itemCount: TaskModel().colors.length),
                      ),

                    ],
                  )),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    loadTasks();
                    TaskModel newTask = TaskModel(
                      nameTask: controllerName?.text ?? '',
                      category: selectedCategory ?? '',
                      level: selectedLevel ?? '',
                      descriptionTask: controllerDescription?.text ?? '',
                      //date: selectTime,
                    );
                    sharedPreferencesService.setData('Task 5', newTask);
                    if (kDebugMode) {
                      TaskModel? task =
                          sharedPreferencesService.getData('Task 5');
                     print('Task: ${tasks?.length}');
                    }
                    controllerName!.clear();
                    controllerDescription!.clear();
                  });
                },
                style: const ButtonStyle(),
                child: const Text('Add')),
          ],
        ),
      ),
    );
  }
}
