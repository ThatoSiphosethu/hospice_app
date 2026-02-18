import 'package:flutter/material.dart';
import 'info_card.dart';

class ShiftStatusCard extends StatelessWidget {
  final String shiftTime;
  final bool isClockedIn;
  final VoidCallback onToggle;

  const ShiftStatusCard({
    super.key,
    required this.shiftTime,
    required this.isClockedIn,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Shift: $shiftTime",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                isClockedIn ? "Status: Clocked In" : "Status: Clocked Out",
              ),
            ],
          ),
          ElevatedButton(
            onPressed: onToggle,
            child: Text(isClockedIn ? "Clock Out" : "Clock In"),
          ),
        ],
      ),
    );
  }
}
