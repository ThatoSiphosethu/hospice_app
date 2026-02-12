import 'package:flutter/material.dart';
import '../domain/patient.dart';

import 'widgets/patient_avatar.dart';
import '../presentation/widgets/patient_overview.dart';
import 'widgets/patient_action_buttons.dart';

class PatientProfileScreen extends StatelessWidget {
  final Patient patient;

  const PatientProfileScreen({
    super.key,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(patient.name)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const SizedBox(height: 12),

              const PatientAvatar(),

              const SizedBox(height: 16),

              PatientOverviewCard(patient: patient),

              const SizedBox(height: 16),

              PatientActionButtons(patient: patient),
            ],
          ),
        ),
      ),
    );
  }
}
