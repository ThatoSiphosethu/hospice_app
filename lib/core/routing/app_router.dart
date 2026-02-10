/// Simple route table for named navigation.
///
/// Maps route names to widget builders used by `MaterialApp.routes`.
import 'package:flutter/material.dart';

import '../../features/admin/presentation/admin_dashboard.dart';
import '../../features/clinician/presentation/doctor_dashboard.dart';
import '../../features/clinician/presentation/cna_dashboard.dart';
import '../../features/patient_portal/presentation/patient_dashboard.dart';
import '../../features/patient_portal/presentation/family_dashboard.dart';
import '../../features/clinician/presentation/clinician_home.dart';

class AppRouter {
  /// Named routes used throughout the app.
  static final routes = <String, WidgetBuilder>{
    '/': (context) => const ClinicianHome(),
    '/admin': (context) => const AdminDashboard(),
    '/doctor': (context) => const DoctorDashboard(),
    '/cna': (context) => const CNADashboard(),
    '/patient': (context) => const PatientDashboard(),
    '/family': (context) => const FamilyDashboard(),
  };
}
