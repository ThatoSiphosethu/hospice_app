import 'package:flutter/material.dart';

class VisitTile extends StatelessWidget {
  final String patientName;
  final String time;
  final String address;
  final VoidCallback onTap;

  const VisitTile({
    super.key,
    required this.patientName,
    required this.time,
    required this.address,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(patientName[0]),
        ),
        title: Text(patientName),
        subtitle: Text("$time • $address"),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
