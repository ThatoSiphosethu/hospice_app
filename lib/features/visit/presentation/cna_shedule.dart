import 'package:flutter/material.dart';
import 'package:hospice_app/features/scheduling/domain/cna_shift.dart';
import 'package:hospice_app/shared/widgets/body_card.dart';
import '../../../shared/widgets/cards/shift_card.dart';

class CNAScheduleScreen extends StatefulWidget {
  final List<WorkShift> shifts;

  const CNAScheduleScreen({super.key, required this.shifts});

  @override
  State<CNAScheduleScreen> createState() => _CNAScheduleScreenState();
}

class _CNAScheduleScreenState extends State<CNAScheduleScreen> {
  final DateTime _selectedDate = DateTime.now();

 // int? _dragStartHour;
  //int? _dragEndHour;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildProfessionalHeader(),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                // ADDED: Significant edge padding for the entire list
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                itemCount: 24,
                itemBuilder: (context, hour) {
                  bool isSameDay(DateTime a, DateTime b) {
                    return a.year == b.year &&
                        a.month == b.month &&
                        a.day == b.day;
                  }

                  final activeShift = widget.shifts.firstWhere(
                    (s) =>
                        hour >= s.startHour &&
                        hour < (s.startHour + s.duration) &&
                        isSameDay(s.date, _selectedDate),
                    orElse: () => WorkShift.empty(_selectedDate),
                  );

                  return _buildTimelineRow(hour, activeShift);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfessionalHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: BodyCard(
        // ADDED: Increased padding to align with the list below
        padding: const EdgeInsets.all(28),
        child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _formatDate(_selectedDate),
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text(
                    "Work Schedule",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              // Profile Action
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.person_outline, color: Colors.blue),
                  onPressed: () => Navigator.pushNamed(context, '/profile'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              _buildHeaderStat("Total", "8.5h", Icons.timer_outlined),
              const SizedBox(width: 20),
              _buildHeaderStat(
                "Active Unit",
                "Wing B",
                Icons.apartment_outlined,
              ),
            ],
          ),
        ],
      ),
      ),
    );
  }

Widget _buildTimelineRow(int hour, WorkShift shift) {
  bool isShiftStart = shift.startHour == hour;
  bool isNow = DateTime.now().hour == hour;

  //final Color rowBackground = isNow ? Colors.blue.withOpacity(0.05) : Colors.transparent;

  return IntrinsicHeight(
    child: BodyCard(
      //color: rowBackground,
      child: Row(
        children: [
        // The Hour Indicator and "Now" dot
        SizedBox(
          width: 65,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Column(
              children: [
                Text(
                  "$hour:00",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isNow ? FontWeight.w900 : FontWeight.w500,
                    color: isNow ? Colors.blue : Colors.blueGrey[200],
                  ),
                ),
                if (isNow)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ),
        
        // The "Continuous Line" and Content area
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 4),
            decoration: BoxDecoration(
              // This creates the single continuous vertical line
              border: Border(
                left: BorderSide(color: Colors.grey[200]!, width: 2),
              ),
            ),
            // Padding here creates the space between the line and the card
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 24), 
            child: isShiftStart
                ? ShiftCard(shift: shift) // Card only appears at the start of the shift
                : const SizedBox(height: 60), // Empty space keeps the line going
          ),
        ),
      ],
    ),
  ),
  );
}

  /// Builds a header stat widget with icon, label, and value
  Widget _buildHeaderStat(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Formats the date to 'EEEE, MMM d' format (e.g., 'Monday, Feb 20')
  String _formatDate(DateTime date) {
    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${weekdays[date.weekday - 1]}, ${months[date.month - 1]} ${date.day}';
  }
}
