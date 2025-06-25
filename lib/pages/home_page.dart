import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  final List<Map<String, String>> tasks;
  final Function(int, Map<String, String>) onTaskUpdate;
  final Function(int) onTaskDelete;

  const HomePage({
    super.key,
    required this.tasks,
    required this.onTaskUpdate,
    required this.onTaskDelete,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  "Your Task Manager",
                  style: GoogleFonts.montserrat(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Your Tasks",
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (widget.tasks.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    "No tasks yet!",
                    style: GoogleFonts.montserrat(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ...widget.tasks.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, String> task = entry.value;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            task['title'] ?? "Untitled",
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text("📌 Details: ${task['details'] ?? "-"}"),
                              Text(
                                  "📅 Date: ${task['date'] ?? "-"} at ${task['time'] ?? "-"}"),
                              Text("📂 Category: ${task['category'] ?? "-"}"),
                              Text("⚡ Priority: ${task['priority'] ?? "-"}"),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  _showEditDialog(context, index, task);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  widget.onTaskDelete(index);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(
      BuildContext context, int index, Map<String, String> task) {
    final titleController = TextEditingController(text: task['title']);
    final detailsController = TextEditingController(text: task['details']);

    DateTime selectedDate =
        DateTime.tryParse(task['date'] ?? "") ?? DateTime.now();
    List<String> timeParts = (task['time'] ?? "00:00").split(":");
    TimeOfDay selectedTime = TimeOfDay(
      hour: int.tryParse(timeParts[0]) ?? 0,
      minute: int.tryParse(timeParts[1]) ?? 0,
    );

    String selectedCategory = task['category'] ?? "Work";
    String selectedPriority = task['priority'] ?? "Medium";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Edit Task"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                        controller: titleController,
                        decoration: const InputDecoration(labelText: "Title")),
                    TextField(
                        controller: detailsController,
                        decoration:
                            const InputDecoration(labelText: "Details")),
                    ElevatedButton(
                      onPressed: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null) {
                          setState(() => selectedDate = picked);
                        }
                      },
                      child: Text(
                          "Pick Date: ${selectedDate.toLocal()}".split(' ')[0]),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: selectedTime,
                        );
                        if (picked != null) {
                          setState(() => selectedTime = picked);
                        }
                      },
                      child: Text("Pick Time: ${selectedTime.format(context)}"),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    final updatedTask = {
                      'title': titleController.text,
                      'details': detailsController.text,
                      'date': selectedDate.toIso8601String().split('T')[0],
                      'time': "${selectedTime.hour}:${selectedTime.minute}",
                      'category': selectedCategory,
                      'priority': selectedPriority,
                    };
                    widget.onTaskUpdate(index, updatedTask);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Save"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
