/// Visit domain model for scheduling.
library;

import 'package:hospice_app/features/ehr/domain/patient.dart';

enum VisitStatus { scheduled, inProgress, completed, cancelled }

class Visit {
  final String id;
  final Patient patient;
  final DateTime scheduledTime;
  final VisitStatus status;

  Visit({
    required this.id,
    required this.patient,
    required this.scheduledTime,
    this.status = VisitStatus.scheduled,
  });

  Visit copyWith({
    String? id,
    Patient? patient,
    DateTime? scheduledTime,
    VisitStatus? status,
  }) {
    return Visit(
      id: id ?? this.id,
      patient: patient ?? this.patient,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      status: status ?? this.status,
    );
  }
}