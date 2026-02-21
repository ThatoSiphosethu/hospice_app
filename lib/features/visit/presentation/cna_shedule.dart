import 'package:flutter/material.dart';
import 'package:hospice_app/features/scheduling/domain/cna_shift.dart';
import '../../../shared/widgets/body_card.dart';

class CNAScheduleScreen extends StatefulWidget {
  final List<WorkShift> shifts;

  const CNAScheduleScreen({super.key, required this.shifts});

  @override
  State<CNAScheduleScreen> createState() => _CNAScheduleScreenState();
}

class _CNAScheduleScreenState extends State<CNAScheduleScreen> {
  final DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildProfessionalHeader(),
            Expanded(
              child: ListView.builder(
                // ADDED: Significant edge padding for the entire list
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                itemCount: 24,
                itemBuilder: (context, hour) {
                  final activeShift = widget.shifts.firstWhere(
                    (s) => hour >= s.startHour && 
                           hour < (s.startHour + s.duration) && 
                           s.date.day == _selectedDate.day,
                    orElse: () => WorkShift(
                      date: _selectedDate, 
                      startHour: -1, 
                      duration: 0, 
                      location: '', 
                      type: ShiftType.onCall
                    ),
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
      // ADDED: Increased padding to align with the list below
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
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
                    style: TextStyle(color: Colors.blueGrey[400], fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  const Text(
                    "Work Schedule",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: -0.5),
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
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildHeaderStat("Total", "8.5h", Icons.timer_outlined),
              const SizedBox(width: 20),
              _buildHeaderStat("Active Unit", "Wing B", Icons.apartment_outlined),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTimelineRow(int hour, WorkShift shift) {
    bool isShiftStart = shift.startHour == hour;
    bool isNow = DateTime.now().hour == hour;

    return IntrinsicHeight(
      child: Row(
        children: [
          // Time Axis with extra spacing
          SizedBox(
            width: 55,
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
                    decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                  )
              ],
            ),
          ),
          // Timeline Line and Card Content
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                border: Border(left: BorderSide(color: Colors.grey[200]!, width: 2)),
              ),
              // ADDED: Vertical spacing between card blocks
              padding: const EdgeInsets.only(bottom: 16, left: 16),
              child: isShiftStart ? _buildShiftCard(shift) : const SizedBox(height: 40),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShiftCard(WorkShift shift) {
    final themeColor = _getShiftColor(shift.type);
    
    return BodyCard(
      // The BodyCard handles its own internal padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: themeColor, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(
                shift.location,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              const Spacer(),
              _buildStatusBadge(shift.type),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Divider(height: 1),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: shift.primaryTasks.map((t) => _buildSmallTaskBadge(t)).toList(),
          )
        ],
      ),
    );
  }

  /// Builds a header stat widget with icon, label, and value
  Widget _buildHeaderStat(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
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
                  Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                  Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Returns the color for a given shift type
  Color _getShiftColor(ShiftType type) {
    switch (type) {
      case ShiftType.inPerson:
        return Colors.green;
      case ShiftType.remote:
        return Colors.orange;
      case ShiftType.onCall:
        return Colors.grey;
      case ShiftType.morning:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ShiftType.evening:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ShiftType.night:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  /// Builds a status badge for a shift type
  Widget _buildStatusBadge(ShiftType type) {
    final (color, label) = switch (type) {
      ShiftType.inPerson => (Colors.green, 'In-Person'),
      ShiftType.remote => (Colors.orange, 'Remote'),
      ShiftType.onCall => (Colors.grey, 'On-Call'),
      // TODO: Handle this case.
      ShiftType.morning => throw UnimplementedError(),
      // TODO: Handle this case.
      ShiftType.evening => throw UnimplementedError(),
      // TODO: Handle this case.
      ShiftType.night => throw UnimplementedError(),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600),
      ),
    );
  }

  /// Builds a small task badge
  Widget _buildSmallTaskBadge(String task) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Text(
        task,
        style: TextStyle(fontSize: 10, color: Colors.grey[800], fontWeight: FontWeight.w500),
      ),
    );
  }

  /// Formats the date to 'EEEE, MMM d' format (e.g., 'Monday, Feb 20')
  String _formatDate(DateTime date) {
    const weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    
    return '${weekdays[date.weekday - 1]}, ${months[date.month - 1]} ${date.day}';
  }
}