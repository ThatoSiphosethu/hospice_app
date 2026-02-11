// Screen that lists patients from the EHR module
import 'package:flutter/material.dart';
import 'package:hospice_app/features/ehr/presentation/patient_profile_screen.dart';
import 'package:hospice_app/shared/cross_domain/widgets/patient_card.dart';
import 'package:hospice_app/shared/widgets/buttons.dart';
import 'package:hospice_app/shared/widgets/scroll_container.dart';
import 'package:hospice_app/shared/widgets/search_bar.dart';

import '../domain/patient.dart';
import '../data/patient_repository.dart';
import '../../../shared/widgets/body_card.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  final repo = MockPatientRepository();

  final TextEditingController searchController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: BodyCard(
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
                  children: filtered.map((p) {
                    return PatientCard(
                      patient: p,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PatientProfileScreen(patient: p),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
