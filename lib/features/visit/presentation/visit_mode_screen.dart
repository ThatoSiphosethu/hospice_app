import 'package:flutter/material.dart';
import 'package:hospice_app/features/scheduling/domain/visit.dart';

class VisitModeScreen extends StatefulWidget {
  final Visit visit;

  const VisitModeScreen({super.key, required this.visit});

  @override
  State<VisitModeScreen> createState() => _VisitModeScreenState();
}

class _VisitModeScreenState extends State<VisitModeScreen> {
  bool arrived = false;

  final List<String> tasks = [
    "Bathing Assistance",
    "Meal Preparation",
    "Medication Reminder",
    "Light Housekeeping",
  ];

  final Map<String, bool> completedTasks = {};
  final TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    for (var task in tasks) {
      completedTasks[task] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.visit.patient.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [

            /// Arrival
            ElevatedButton(
              onPressed: () {
                setState(() {
                  arrived = true;
                });
              },
              child: Text(arrived ? "Arrived ✔" : "Confirm Arrival"),
            ),

            const SizedBox(height: 24),

            /// Tasks
            const Text(
              "Tasks",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            ...tasks.map(
              (task) => CheckboxListTile(
                title: Text(task),
                value: completedTasks[task],
                onChanged: (value) {
                  setState(() {
                    completedTasks[task] = value ?? false;
                  });
                },
              ),
            ),

            const SizedBox(height: 24),

            /// Notes
            const Text(
              "Visit Notes",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: notesController,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter notes...",
              ),
            ),

            const SizedBox(height: 24),

            /// End Visit
            ElevatedButton(
              onPressed: _endVisit,
              child: const Text("End Visit"),
            ),
          ],
        ),
      ),
    );
  }

  void _endVisit() {
    if (!arrived) {
      _showError("Please confirm arrival first.");
      return;
    }

    Navigator.pop(
      context,
      widget.visit.copyWith(status: VisitStatus.completed),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}