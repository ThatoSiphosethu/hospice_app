import 'package:flutter/material.dart';

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