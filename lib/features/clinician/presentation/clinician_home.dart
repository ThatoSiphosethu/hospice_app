import 'package:flutter/material.dart';
import '../../../shared/widgets/app_shell.dart';
import 'doctor_dashboard.dart';

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
        DoctorDashboard(),
        Center(child: Text('Patients')),
        Center(child: Text('Schedule')),
        Center(child: Text('Profile')),
      ],
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Patients',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Schedule',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
