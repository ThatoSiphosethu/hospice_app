import 'package:flutter/material.dart';
import '../../../shared/widgets/body_card.dart';
import '../../ehr/domain/patient.dart';

class PatientProfileScreen extends StatelessWidget {
  final Patient patient;

  const PatientProfileScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Patient Profile',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildPatientHeader(patient),
          const SizedBox(height: 20),
          BodyCard(
            child: ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Patient Status'),
              subtitle: Text(patient.status),
            ),
          ),
          const SizedBox(height: 10),
          BodyCard(
            child: ListTile(
              leading: const Icon(Icons.medical_services_outlined),
              title: const Text('Primary Diagnosis'),
              subtitle: Text(patient.diagnosis.isNotEmpty ? patient.diagnosis : 'N/A'),
            ),
          ),
          const SizedBox(height: 10),
          BodyCard(
            child: ListTile(
              leading: const Icon(Icons.location_on_outlined),
              title: const Text('Address'),
              subtitle: Text(patient.address ?? 'No address provided'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientHeader(Patient patient) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.blue,
            child: Text(
              patient.name.isNotEmpty ? patient.name[0] : '?',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                patient.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Patient ID: ${patient.id}',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
