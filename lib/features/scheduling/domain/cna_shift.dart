enum ShiftType { morning, evening, night, onCall, inPerson, remote }

class WorkShift {
  final DateTime date;
  final int startHour; // e.g., 07 for 7 AM
  final int duration;  // e.g., 8 for an 8-hour shift
  final String location; // e.g., "Unit 4 - Hospice Wing"
  final ShiftType type;
  final List<String> primaryTasks; // e.g., ["Vitals", "ADLs", "Turning"]

  WorkShift({
    required this.date,
    required this.startHour,
    required this.duration,
    required this.location,
    required this.type,
    this.primaryTasks = const [],
  });
}