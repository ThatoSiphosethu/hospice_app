import 'package:flutter/material.dart';

class PatientAvatar extends StatelessWidget {
  const PatientAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 50,
      backgroundColor: Colors.grey,
      child: Icon(Icons.person, size: 60, color: Colors.white),
    );
  }
}
