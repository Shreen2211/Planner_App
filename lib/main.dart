import 'package:flutter/material.dart';
import 'View/Screens/home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}


/*
class TaskSearch extends StatefulWidget {
  @override
  _TaskSearchState createState() => _TaskSearchState();
}

class _TaskSearchState extends State<TaskSearch> {
  final List<String> allTasks = [
    "Task One",
    "Task Two",
    "Task Three",
    "Another Task",
    "Flutter Task"
  ]; // القائمة الأصلية للمهام
  List<String> filteredTasks = []; // القائمة المفلترة
  TextEditingController searchController = TextEditingController(); // للتحكم في البحث

  @override
  void initState() {
    super.initState();
    filteredTasks = allTasks; // في البداية، القائمة المفلترة تحتوي على جميع المهام
  }

  void filterTasks(String query) {
    setState(() {
      filteredTasks = allTasks
          .where((task) =>
          task.toLowerCase().contains(query.toLowerCase())) // التصفية
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Search"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: filterTasks, // تحديث النتائج مع كل حرف
              decoration: InputDecoration(
                hintText: "Search tasks...",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredTasks[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/