import 'package:flutter/material.dart';
import '../domain/patient.dart';

import 'widgets/patient_avatar.dart';
import '../presentation/widgets/patient_overview.dart';
import 'widgets/patient_action_buttons.dart';

class PatientProfileScreen extends StatelessWidget {
  final Patient patient;

  const PatientProfileScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                    color: Colors.black.withOpacity(.08),
                  ),
                ],
              ),
              child: AppBar(
                title: Text(patient.name),
                
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
              ),
            ),
          ),
        ),
      ),

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
