import 'package:flutter/material.dart';

/// Dashboard shown to patients with their personalized information.
///
/// Replace the body with real patient data widgets (e.g., vitals, messages,
/// upcoming appointments) as the feature is implemented.
class PatientDashboard extends StatelessWidget {
  
  const PatientDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Dashboard'),
      ),
      body: Center(
        child: Text('Welcome to the Patient Dashboard!'),
      ),
    );
  }
}