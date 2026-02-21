import 'package:flutter/material.dart';
import 'package:hospice_app/features/visit/presentation/visit_mode_screen.dart';
import 'package:hospice_app/shared/cross_domain/widgets/action_chip_button.dart';
import '../domain/patient.dart';

//import 'widgets/patient_avatar.dart';
import '../presentation/widgets/patient_overview.dart';
import 'widgets/patient_action_buttons.dart';
import '../domain/appointment.dart';
import 'widgets/patient_schedule_card.dart';
import 'package:hospice_app/features/scheduling/data/mock_visit_repository.dart';
import 'package:hospice_app/features/scheduling/domain/visit.dart';

class PatientProfileScreen extends StatelessWidget {
  final Patient patient;

  const PatientProfileScreen({super.key, required this.patient});

  // Mock schedule data for demonstration
  List<Appointment> _mockSchedules() {
    return [
      Appointment(id: "1", title: "Medication", startHour: 8),
      Appointment(id: "2", title: "Nurse Visit", startHour: 11),
      Appointment(id: "3", title: "Vitals Check", startHour: 15),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                    color: Colors.black.withOpacity(.08),
                  ),
                ],
              ),
              child: AppBar(
                title: Text(patient.name),
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const SizedBox(height: 12),
              const SizedBox(height: 16),
              PatientOverviewCard(patient: patient),
              _buildVisitButton(context),
              const SizedBox(height: 16),
              PatientActionButtons(patient: patient),
              const SizedBox(height: 16),
              PatientScheduleCard(schedules: _mockSchedules()),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the visit button, handling async visit data
  Widget _buildVisitButton(BuildContext context) {
    return FutureBuilder<List<Visit>>(
      future: MockVisitRepository().getTodayVisits(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        try {
          final visitForPatient = snapshot.data!.firstWhere(
            (v) =>
                v.patient.id == patient.id && v.status == VisitStatus.scheduled,
          );

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ActionChipButton(
              label: "Start Visit",
              icon: Icons.play_arrow,
              color: Colors.green,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => VisitModeScreen(visit: visitForPatient),
                  ),
                );
              },
            ),
          );
        } catch (e) {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
