import 'package:flutter/material.dart';
import 'package:hospice_app/shared/widgets/body_card.dart';
import 'package:hospice_app/shared/cross_domain/widgets/app_scheduler.dart';
import '../../domain/appointment.dart';

class PatientScheduleCard extends StatelessWidget {
  final List<Appointment> schedules;

  const PatientScheduleCard({
    super.key,
    required this.schedules,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500, // Set a fixed height for the scheduler
      child: BodyCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Today's Schedule",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 12),

            // Receives a list of appointments and displays them in a scheduler format
            Expanded(
              child: AppScheduler(
                items: schedules,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
