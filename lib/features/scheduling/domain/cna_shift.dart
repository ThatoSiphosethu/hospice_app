enum ShiftType { morning, evening, night, onCall, inPerson, remote }

class WorkShift {
  final DateTime date;
  final int startHour;
  final int duration;
  final String location;
  final ShiftType type;
  final List<String> primaryTasks;

  WorkShift({
    required this.date,
    required this.startHour,
    required this.duration,
    required this.location,
    required this.type,
    required this.primaryTasks,
  });

  factory WorkShift.empty(DateTime date) {
    return WorkShift(
      date: date,
      startHour: -1,
      duration: 0,
      location: '',
      type: ShiftType.onCall,
      primaryTasks: [],
    );
  }
}