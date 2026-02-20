import 'package:flutter/material.dart';
import 'package:hospice_app/features/scheduling/domain/visit.dart';

class VisitTile extends StatelessWidget {
  final Visit visit;
  final VoidCallback onTap;

  const VisitTile({
    super.key,
    required this.visit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final patient = visit.patient;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12, left: 4, right: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: IntrinsicHeight(
            child: Row(
              children: [
                /// Status Indicator Bar
                Container(
                  width: 6,
                  color: _statusColor(visit.status),
                ),
                Expanded(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade50,
                      foregroundColor: Colors.blue.shade700,
                      child: Text(
                        patient.name[0],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(
                      patient.name,
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
                          Icon(Icons.access_time,
                              size: 14, color: Colors.grey.shade600),
                          const SizedBox(width: 4),
                          Text(
                            _formatTime(visit.scheduledTime),
                            style:
                                TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                    trailing: _statusIcon(visit.status),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _statusColor(VisitStatus status) {
    switch (status) {
      case VisitStatus.completed:
        return Colors.green;
      case VisitStatus.inProgress:
        return Colors.orange;
      case VisitStatus.scheduled:
      default:
        return Colors.blue.shade400;
    }
  }

  Widget _statusIcon(VisitStatus status) {
    switch (status) {
      case VisitStatus.completed:
        return const Icon(Icons.check_circle, color: Colors.green);
      case VisitStatus.inProgress:
        return const Icon(Icons.play_circle, color: Colors.orange);
      case VisitStatus.scheduled:
      default:
        return const Icon(Icons.schedule);
    }
  }

  String _formatTime(DateTime time) {
    final hour = time.hour > 12 ? time.hour - 12 : time.hour;
    final period = time.hour >= 12 ? "PM" : "AM";
    return "$hour:00 $period";
  }
}