enum ScheduleType {
  medication,
  visit,
  vitals,
  therapy,
  custom,
}

class Appointment {
  final String id;
  final String title;

  int startHour;
  int duration;
  // make date mutable so UI can update it when dragging appointments
  DateTime date;
  final ScheduleType type;

  Appointment({
    required this.id,
    required this.title,
    required this.startHour,
    DateTime? date,
    this.duration = 1,
    this.type = ScheduleType.custom,
  }) : date = date ?? DateTime.now();
}
