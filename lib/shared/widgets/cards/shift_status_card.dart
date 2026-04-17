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

          /// Shift Info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Shift: $shiftTime",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 6),

              Row(
                children: [
                  Icon(
                    isClockedIn ? Icons.check_circle : Icons.cancel,
                    color: isClockedIn ? Colors.green : Colors.grey,
                    size: 18,
                  ),

                  const SizedBox(width: 6),

                  Text(
                    isClockedIn
                        ? "Status: Clocked In"
                        : "Status: Clocked Out",
                    style: TextStyle(
                      color: isClockedIn ? Colors.green : Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),

          /// Clock Button
          ElevatedButton(
            onPressed: onToggle,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isClockedIn ? Colors.red : Colors.green,
              foregroundColor: Colors.white,
            ),
            child: Text(
              isClockedIn ? "Clock Out" : "Clock In",
            ),
          ),
        ],
      ),
    );
  }
}