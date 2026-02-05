import 'package:flutter/material.dart';

class FamilyDashboard extends StatelessWidget {

  const FamilyDashboard({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Family Dashboard'),
      ),
      body: Center(
        child: Text('Welcome to the Family Dashboard!'),
      ),
    );
  }
}