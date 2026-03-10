import 'package:flutter/material.dart';
import '../../domain/patient.dart';

class CarePlanScreen extends StatelessWidget {
  final Patient patient;

  const CarePlanScreen({
    super.key,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    final careItems = [
      "Pain management monitoring",
      "Assist with ADLs",
      "Fall risk precautions",
      "Skin integrity monitoring",
      "Daily vitals tracking",
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("${patient.name} Care Plan"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: careItems.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(Icons.check_circle_outline),
              title: Text(careItems[index]),
            ),
          );
        },
      ),
    );
  }
}