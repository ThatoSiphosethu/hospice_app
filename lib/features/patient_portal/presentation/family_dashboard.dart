import 'package:flutter/material.dart';
import '../../../shared/widgets/app_shell.dart';
import '../../ehr/domain/patient.dart';
import '../../ehr/data/patient_repository.dart';
import '../../ehr/presentation/widgets/patient_action_buttons.dart';
import '../../profile/profile_screen.dart';

class FamilyDashboard extends StatefulWidget {
  const FamilyDashboard({super.key});

  @override
  State<FamilyDashboard> createState() => _FamilyDashboardState();
}

class _FamilyDashboardState extends State<FamilyDashboard> {
  final MockPatientRepository _repo = MockPatientRepository();
  Patient? _patient;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPatient();
  }

  Future<void> _loadPatient() async {
    try {
      final patients = await _repo.fetchPatients();
      // For family dashboard, show the first active patient
      final activePatient = patients.firstWhere(
        (p) => p.status == 'Active',
        orElse: () => patients.first,
      );

      setState(() {
        _patient = activePatient;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error (e.g., show a snackbar or dialog)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load patient data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_patient == null) {
      return const Scaffold(
        body: Center(
          child: Text('No patient data available'),
        ),
      );
    }

    return AppShell(
      pages: [
        _buildOverviewPage(_patient!),
        _buildVisitsPage(),
        const ProfileScreen(),
      ],
      titles: const ['Home', 'Visits', 'Profile'],
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Visits'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }

  Widget _buildOverviewPage(Patient patient) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPatientHeader(patient),
          const SizedBox(height: 20),
          PatientActionButtons(patient: patient),
          const SizedBox(height: 20),
          _buildStatusCard(),
          const SizedBox(height: 16),
          _buildUpcomingVisits(),
        ],
      ),
    );
  }

  Widget _buildVisitsPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Upcoming Visits',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _visitTile('Nurse Visit', 'Tomorrow • 10:00 AM'),
          _visitTile('Physical Therapy', 'Friday • 2:00 PM'),
        ],
      ),
    );
  }

  /// 👤 Patient Info Header
  Widget _buildPatientHeader(Patient patient) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.blue,
            child: Text(
              patient.name.isNotEmpty ? patient.name[0] : "?",
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                patient.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Patient ID: ${patient.id}",
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 📊 Status Card
  Widget _buildStatusCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: const [
          Icon(Icons.favorite, color: Colors.green),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "Patient is stable. No alerts at this time.",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  /// 📅 Upcoming Visits
  Widget _buildUpcomingVisits() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Upcoming Visits",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        _visitTile("Nurse Visit", "Tomorrow • 10:00 AM"),
        _visitTile("Physical Therapy", "Friday • 2:00 PM"),
      ],
    );
  }

  Widget _visitTile(String title, String subtitle) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const Icon(Icons.calendar_today),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}