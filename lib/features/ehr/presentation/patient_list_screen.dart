
// Screen that lists patients from the EHR module
import 'package:flutter/material.dart';

import '../domain/patient.dart';
import '../data/patient_repository.dart';
import 'patient_profile_screen.dart';

import '../../../shared/widgets/buttons.dart';
import '../../../shared/widgets/scroll_container.dart';
import '../../../shared/widgets/search_bar.dart';
import '../../../shared/widgets/status_badge.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  final repo = MockPatientRepository();

  final TextEditingController searchController =
      TextEditingController();

  List<Patient> patients = [];
  List<Patient> filtered = [];

  @override
  void initState() {
    super.initState();
    _loadPatients();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _loadPatients() async {
    final loaded = await repo.fetchPatients();

    setState(() {
      patients = loaded;
      filtered = loaded;
    });
  }

  void _filterPatients(String query) {
    final results = patients.where((p) {
      final q = query.toLowerCase();

      return p.name.toLowerCase().contains(q) ||
          p.diagnosis.toLowerCase().contains(q) ||
          p.status.toLowerCase().contains(q);
    }).toList();

    setState(() {
      filtered = results;
    });
  }

  Widget _buildPatientCard(Patient p) {
    return Card(
      child: ListTile(
        title: Text(p.name),
        subtitle: Text(p.diagnosis),
        trailing: StatusBadge(status: p.status),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PatientProfileScreen(patient: p),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: AppBar(title: const Text('Patients')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [

            // 🔍 Search
            SearchBarWidget(
              controller: searchController,
              onChanged: _filterPatients,
            ),

            const SizedBox(height: 12),

            // Add Button
            AppButton(
              text: "Add Patient",
              icon: Icons.add,
              onPressed: () {
                // Hook up form screen later
              },
            ),

            const SizedBox(height: 12),

            //  Scrollable List
            ScrollContainer(
              children: filtered
                  .map((p) => _buildPatientCard(p))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

