// Presentation screen for an individual patient's profile.
//
// TODO: Implement UI to display patient demographics, medical history,
// and recent clinical notes. This placeholder file documents the intent so
// future contributors know where profile UI belongs.
import 'package:flutter/material.dart';
import '../domain/patient.dart';

class PatientProfileScreen extends StatelessWidget {
  final Patient patient;

  const PatientProfileScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(patient.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Diagnosis: ${patient.diagnosis}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text("Status: ${patient.status}",
                style: const TextStyle(fontSize: 18)),

            const SizedBox(height: 24),

            ElevatedButton(
              child: const Text("Clinical Notes"),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/notes',
                  arguments: patient,
                );
              },
            ),

            ElevatedButton(
              child: const Text("Medications"),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/meds',
                  arguments: patient,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
