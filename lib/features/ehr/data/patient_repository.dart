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
      ),
      Patient(
        id: '2',
        name: 'Mary Jones',
        age: 65,
        diagnosis: 'Stage IV Cancer',
        status: 'Active', 
      ),
      Patient(
        id: '3',
        name: 'Robert Lee',
        age: 78,
        diagnosis: 'COPD',
        status: 'Discharged',
      ),
    ];
  }
}
