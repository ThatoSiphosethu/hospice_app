import 'package:flutter/material.dart';

import '../../features/admin/presentation/admin_dashboard.dart';
import '../../features/clinician/presentation/doctor_dashboard.dart';
import '../../features/clinician/presentation/cna_dashboard.dart';
import '../../features/patient_portal/presentation/patient_dashboard.dart';
import '../../features/patient_portal/presentation/family_dashboard.dart';

class AppRouter {
  static final routes = <String, WidgetBuilder>{
    '/': (context) => const DoctorDashboard(),
    '/admin': (context) => const AdminDashboard(),
    '/doctor': (context) => const DoctorDashboard(),
    '/cna': (context) => const CNADashboard(),
    '/patient': (context) => const PatientDashboard(),
    '/family': (context) => const FamilyDashboard(),
  };
}
