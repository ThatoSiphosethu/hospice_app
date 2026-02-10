import 'package:flutter/material.dart';

/// Dashboard for clinicians with the role of doctor.
///
/// This presentation widget should contain doctor-specific views such as
/// assigned patients, tasks, and alerts.
class DoctorDashboard extends StatelessWidget {

  const DoctorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Dashboard'),
      ),
      body: Center(
        child: Text('Welcome to the Doctor Dashboard!'),
      ),
    );
  }
}