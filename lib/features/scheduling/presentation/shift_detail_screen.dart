import 'package:flutter/material.dart';
import 'package:hospice_app/features/scheduling/domain/cna_shift.dart';


class ShiftDetailScreen extends StatelessWidget {
  final WorkShift shift;

  const ShiftDetailScreen({super.key, required this.shift});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shift Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              shift.location,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text("Start Hour: ${shift.startHour}:00"),
            Text("Duration: ${shift.duration} hours"),
            const SizedBox(height: 20),
            const Text(
              "Tasks",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...shift.primaryTasks.map((t) => Text("• $t")),
          ],
        ),
      ),
    );
  }
}