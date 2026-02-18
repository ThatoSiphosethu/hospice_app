import 'package:hospice_app/features/ehr/domain/patient.dart';

enum VisitStatus { scheduled, inProgress, completed }

class Visit {
  final String id;
  final Patient patient;
  final DateTime scheduledTime;
  final VisitStatus status;

  const Visit({
    required this.id,
    required this.patient,
    required this.scheduledTime,
    this.status = VisitStatus.scheduled,
  });

  Visit copyWith({
    VisitStatus? status,
  }) {
    return Visit(
      id: id,
      patient: patient,
      scheduledTime: scheduledTime,
      status: status ?? this.status,
    );
  }
}
