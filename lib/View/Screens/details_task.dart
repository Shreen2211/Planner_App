import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blue,
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Name:"),
            Text("Description:"),
            Text("Start Date:"),
            Text("Finish Date:"),
            Text("State:"),
            Text("Priority:"),
          ],
        ),
      ),
    );
  }
}
