import '../domain/patient.dart';

/// Interface (what the UI depends on)
abstract class PatientRepositoryBase {
  Future<List<Patient>> fetchPatients();
}

/// Mock implementation (temporary fake data)
class MockPatientRepository
    implements PatientRepositoryBase {

  @override
  Future<List<Patient>> fetchPatients() async {

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      Patient(
        id: '1',
        name: 'John Smith',
        age: 72,
        diagnosis: 'Congestive Heart Failure',
        status: 'Active',
        address: '123 Oak Street, Portland, OR 97201',
      ),
      Patient(
        id: '2',
        name: 'Mary Jones',
        age: 65,
        diagnosis: 'Stage IV Cancer',
        status: 'Active',
        address: '456 Elm Avenue, Portland, OR 97202',
      ),
      Patient(
        id: '3',
        name: 'Robert Lee',
        age: 78,
        diagnosis: 'COPD',
        status: 'Discharged',
        address: '789 Maple Drive, Portland, OR 97203',
      ),
    ];
  }
}
