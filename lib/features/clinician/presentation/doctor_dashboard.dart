import 'package:flutter/material.dart';

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