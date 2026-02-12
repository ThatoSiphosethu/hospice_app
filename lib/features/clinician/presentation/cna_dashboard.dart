import 'package:flutter/material.dart';

/// Dashboard for CNAs (Certified Nursing Assistants).
///
/// Contains quick access to patient care lists and shift tasks. Keep
/// presentation separate from business logic to make testing straightforward.
class CNADashboard extends StatelessWidget {

  const CNADashboard({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CNA Dashboard'),
      ),
      body: Center(
        child: Text('Welcome to the CNA Dashboard!'),
      ),

      // CNA-specific UI components would go here. For example, 
      //you might have a list of assigned patients, upcoming tasks, or shift schedules.
      // Quick access to patient care lists and shift tasks could be implemented here, allowing CNAs to efficiently manage their responsibilities and stay organized during their shifts.
    );
  }
}