import 'package:flutter/material.dart';
import 'info_card.dart';

class NextVisitCard extends StatelessWidget {
  final String patientName;
  final String time;
  final String address;
  final VoidCallback onStart;

  const NextVisitCard({
    super.key,
    required this.patientName,
    required this.time,
    required this.address,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      backgroundColor: Colors.blue.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Next Visit",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            patientName,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 4),
          Text("$time • $address"),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onStart,
              child: const Text("Start Visit"),
            ),
          ),
        ],
      ),
    );
  }
}
