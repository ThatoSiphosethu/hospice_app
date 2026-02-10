/// Simple route table for named navigation.
///
/// Maps route names to widget builders used by `MaterialApp.routes`.
library;
import 'package:flutter/material.dart';
import 'package:hospice_app/features/ehr/domain/patient.dart';

import '../../features/admin/presentation/admin_dashboard.dart';
import '../../features/clinician/presentation/doctor_dashboard.dart';
import '../../features/clinician/presentation/cna_dashboard.dart';
import '../../features/patient_portal/presentation/patient_dashboard.dart';
import '../../features/patient_portal/presentation/family_dashboard.dart';
import '../../features/clinician/presentation/clinician_home.dart';
import '../../features/ehr/presentation/clinical_notes_screen.dart';
import '../../features/ehr/presentation/medication_screen.dart';

class AppRouter {
  /// Named routes used throughout the app.
  static final routes = <String, WidgetBuilder>{
    '/': (context) => const ClinicianHome(),
    '/admin': (context) => const AdminDashboard(),
    '/doctor': (context) => const DoctorDashboard(),
    '/cna': (context) => const CNADashboard(),
    '/patient': (context) => const PatientDashboard(),
    '/family': (context) => const FamilyDashboard(),
    '/notes': (context) {
      final patient =
          ModalRoute.of(context)!.settings.arguments as Patient;
      return ClinicalNotesScreen(patient: patient);
    },

  '/meds': (context) {
    final patient =
          ModalRoute.of(context)!.settings.arguments as Patient;
      return MedicationScreen(patient: patient);
    },

  };
}
