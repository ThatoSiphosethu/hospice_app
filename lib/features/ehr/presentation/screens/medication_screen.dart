import 'package:flutter/material.dart';
import '../../domain/patient.dart';
import '../../domain/medication.dart';

class MedicationScreen extends StatelessWidget {
  final Patient patient;

  const MedicationScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {

    final meds = [
      Medication("Morphine", "5mg"),
      Medication("Lorazepam", "1mg"),
    ];

    return Scaffold(
      appBar: AppBar(title: Text("${patient.name} Medications")),
      body: ListView(
        children: meds.map((m) => ListTile(
          title: Text(m.name),
          subtitle: Text(m.dosage),
        )).toList(),
      ),
    );
  }
}
