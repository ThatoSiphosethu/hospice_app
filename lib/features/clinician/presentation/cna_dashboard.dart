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
    );
  }
}