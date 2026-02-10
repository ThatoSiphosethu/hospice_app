/// Admin area dashboard and management entry point.
///
/// Hosts administrative features; keep this file focused on presentation
/// only, and move complex logic to dedicated controllers/services.
import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Center(
        child: Text('Welcome to the Admin Dashboard!'),
      ),
    );
  }
}