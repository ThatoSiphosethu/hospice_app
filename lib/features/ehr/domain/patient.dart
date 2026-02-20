// Domain model for a Patient entity.
//
// TODO: Define fields such as `id`, `name`, `dob`, `medicalRecordNumber`,
// and any serialization helpers (fromJson/toJson) when implementing the EHR
// domain layer.

enum PatientStatus { active, discharged }

class Patient {
  final String id;
  final String name;
  final int age; // Placeholder, calculate from DOB when implemented
  final String diagnosis;
  final String status;
  final String? address;

  Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.diagnosis,
    required this.status,
    this.address,
  });
}
