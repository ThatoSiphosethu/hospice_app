import 'package:flutter/material.dart';
import '/features/visit/presentation/cna_shedule.dart';
import '../../../shared/widgets/app_shell.dart';
import 'cna_dashboard.dart';
import '../../ehr/presentation/patient_list_screen.dart';


/// Landing shell for clinician users.
///
/// Uses `AppShell` to provide a consistent bottom navigation bar and
/// composes clinician-specific pages. Keep only presentation logic here;
/// business logic and state should live in separate controllers/providers.
class ClinicianHome extends StatelessWidget {
  const ClinicianHome({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      pages: const [
        CNADashboard(),
        PatientListScreen(),
        CNAScheduleScreen(shifts: []), // Pass actual shifts in real implementation
        Center(child: Text('Profile')),
      ],

      // NEW — titles for AppBar
      titles: const ['Dashboard', 'Patients', 'Schedule', 'Profile'],

      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Patients'),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today),label: 'Schedule',),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
