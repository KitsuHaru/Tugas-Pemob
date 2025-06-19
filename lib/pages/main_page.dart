import 'package:flutter/material.dart';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:tugasanalisis/pages/add_transaction.dart';
import 'package:tugasanalisis/pages/home_page.dart';
import 'package:tugasanalisis/pages/analityc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  DateTime selectedDate = DateTime.now();
  List<Map<String, String>> tasks = [];

  void _addTask(Map<String, String> task) {
    setState(() {
      tasks.add(task);
    });
  }

  void _updateTask(int index, Map<String, String> updatedTask) {
    setState(() {
      tasks[index] = updatedTask;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CalendarAppBar(
        accent: Colors.teal,
        backButton: false,
        onDateChanged: (value) {
          setState(() {
            selectedDate = value;
          });
        },
        firstDate: DateTime.now().subtract(const Duration(days: 140)),
        lastDate: DateTime.now(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TransactionPage(),
            ),
          );

          if (newTask != null) {
            _addTask(newTask);
          }
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      body: HomePage(
        tasks: tasks,
        onTaskUpdate: _updateTask, // Pass the update function
        onTaskDelete: _deleteTask, // Pass the delete function
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                // No need to pushReplacement if already on MainPage
                // Navigator.of(context).pushReplacement(MaterialPageRoute(
                //   builder: (context) => MainPage(),
                // ));
              },
              icon: const Icon(Icons.home, color: Colors.teal),
            ),
            const SizedBox(width: 20),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AnalitycPage(),
                ));
              },
              icon: const Icon(Icons.analytics, color: Colors.teal),
            ),
          ],
        ),
      ),
    );
  }
}