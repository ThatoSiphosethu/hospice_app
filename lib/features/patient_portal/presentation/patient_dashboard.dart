import 'package:flutter/material.dart';

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