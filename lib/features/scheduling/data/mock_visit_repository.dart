/// Mock repository for visit scheduling.
library;

import 'package:hospice_app/features/ehr/data/patient_repository.dart';
import 'package:hospice_app/features/scheduling/domain/visit.dart'; // Unused in current implementation

class MockVisitRepository {
  final _patientRepo = MockPatientRepository();

  Future<List<Visit>> getTodayVisits() async {
    final patients = await _patientRepo.fetchPatients();

    return List.generate(
      patients.length,
      (index) => Visit(
        id: 'visit_$index',
        patient: patients[index],
        scheduledTime: DateTime.now().add(Duration(hours: index + 1)),
      ),
    );
  }
}
