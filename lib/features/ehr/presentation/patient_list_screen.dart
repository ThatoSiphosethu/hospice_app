// Screen that will list patients from the EHR module.
//
// TODO: Populate with a paginated list and search/filter controls. This
// placeholder marks the file's purpose for future implementation.
import 'package:flutter/material.dart';
import '../domain/patient.dart';
import '../data/patient_repository.dart';
import 'patient_profile_screen.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  List<Patient> patients = [];
  List<Patient> filtered = [];

final repo = MockPatientRepository();
  @override
  void initState() {
    super.initState();
    _loadPatients();
  }

  void _loadPatients() async {
    final loaded = await repo.fetchPatients();
    setState(() {
      patients = loaded;
      filtered = patients;
    });
  }

  void _search(String query) {
    setState(() {
      filtered = patients
          .where((p) =>
              p.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Patients')),
      body: Column(
        children: [

          // 🔍 Search
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: _search,
              decoration: InputDecoration(
                hintText: 'Search patients...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // 📋 Patient List
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final p = filtered[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(p.name),
                    subtitle: Text(
                        '${p.diagnosis} • ${p.status}'),
                    trailing:
                        const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // We'll wire navigation next
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PatientProfileScreen(patient: p),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
