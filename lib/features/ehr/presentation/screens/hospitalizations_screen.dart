import 'package:flutter/material.dart';
import '../../domain/patient.dart';

class HospitalizationsScreen extends StatelessWidget {
  final Patient patient;

  const HospitalizationsScreen({
    super.key,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    final hospitalizations = [
      {
        "date": "Jan 10, 2026",
        "reason": "Respiratory distress",
        "hospital": "Milwaukee General Hospital"
      },
      {
        "date": "Aug 21, 2025",
        "reason": "Fall injury evaluation",
        "hospital": "St. Mary's Medical Center"
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("${patient.name} Hospitalizations"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: hospitalizations.length,
        itemBuilder: (context, index) {
          final h = hospitalizations[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(Icons.local_hospital),
              title: Text(h["reason"]!),
              subtitle: Text("${h["hospital"]} • ${h["date"]}"),
            ),
          );
        },
      ),
    );
  }
}