// Domain model for a Patient entity.
//
// TODO: Define fields such as `id`, `name`, `dob`, `medicalRecordNumber`,
// and any serialization helpers (fromJson/toJson) when implementing the EHR
// domain layer.
class Patient {
  final String id;
  final String name;
  final String diagnosis;
  final String status;

  Patient({
    required this.id,
    required this.name,
    required this.diagnosis,
    required this.status,
  });
}
