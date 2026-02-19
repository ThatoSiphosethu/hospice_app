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
    return GestureDetector(
  onTap: onTap,
  child: Container(
    margin: const EdgeInsets.only(bottom: 12, left: 4, right: 4),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      // Soft, professional shadow
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
      // Subtle border to define the card
      border: Border.all(color: Colors.grey.shade100),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Status Indicator Bar (e.g., Blue for upcoming visits)
            Container(
              width: 6,
              color: Colors.blue.shade400,
            ),
            Expanded(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue.shade100, width: 2),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.blue.shade50,
                    foregroundColor: Colors.blue.shade700,
                    child: Text(
                      patientName[0],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                title: Text(
                  patientName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF2D3142),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 14, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(
                        time,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
);
  }
}
