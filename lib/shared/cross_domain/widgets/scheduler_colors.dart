import 'package:flutter/material.dart';
import '../../../features/ehr/domain/appointment.dart';

Color scheduleColor(ScheduleType type) {
  switch (type) {
    case ScheduleType.medication:
      return Colors.blue;
    case ScheduleType.visit:
      return Colors.green;
    case ScheduleType.vitals:
      return Colors.orange;
    case ScheduleType.therapy:
      return Colors.purple;
    default:
      return Colors.grey;
  }
}
