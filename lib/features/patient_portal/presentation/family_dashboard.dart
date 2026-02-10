import 'package:flutter/material.dart';

/// Family-facing dashboard screen.
///
/// Shows information relevant to family members such as patient status and
/// messages. This is a self-contained presentation widget.
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