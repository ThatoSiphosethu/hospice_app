import 'package:flutter/material.dart';
import 'package:hospice_app/features/scheduling/presentation/shift_detail_screen.dart';
import 'package:hospice_app/shared/widgets/body_card.dart';
import 'package:hospice_app/features/scheduling/domain/cna_shift.dart';

class ShiftCard extends StatelessWidget {
  final WorkShift shift;

  const ShiftCard({super.key, required this.shift});

  @override
  Widget build(BuildContext context) {
    final themeColor = _getShiftColor(shift.type);

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShiftDetailScreen(shift: shift),
          ),
        );
      },
      child: BodyCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: themeColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  shift.location,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const Spacer(),
                _buildStatusBadge(shift.type),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(height: 1),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: shift.primaryTasks
                  .map((t) => _buildSmallTaskBadge(t))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

 Color _getShiftColor(ShiftType type) {
  switch (type) {
    case ShiftType.morning:
      return Colors.blue;
    case ShiftType.evening:
      return Colors.orange;
    case ShiftType.night:
      return Colors.indigo;
    case ShiftType.onCall:
      return Colors.purple;
    case ShiftType.inPerson:
      return Colors.green;
    case ShiftType.remote:
      return Colors.teal;
  }
}

  Widget _buildStatusBadge(ShiftType type) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getShiftColor(type).withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        type.name.toUpperCase(),
        style: TextStyle(
          color: _getShiftColor(type),
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSmallTaskBadge(String task) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        task,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}