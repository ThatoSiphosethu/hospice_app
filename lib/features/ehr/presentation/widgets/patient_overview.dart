import 'package:flutter/material.dart';
import '../../domain/patient.dart';
import 'package:hospice_app/shared/widgets/body_card.dart';

class PatientOverviewCard extends StatelessWidget {
  final Patient patient;

  const PatientOverviewCard({
    super.key,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = patient.status == "Active";

    return BodyCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(patient.name,
              style: Theme.of(context).textTheme.titleLarge),

          const SizedBox(height: 8),

          Text("Age: ${patient.age}"),
          Text("Diagnosis: ${patient.diagnosis}"),
          Text(
            "Status: ${patient.status}",
            style: TextStyle(
              color: isActive ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
