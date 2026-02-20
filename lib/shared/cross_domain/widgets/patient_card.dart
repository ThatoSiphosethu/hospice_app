import 'package:flutter/material.dart';
import '../../widgets/body_card.dart';
import '../../widgets/status_badge.dart';
import '../../../features/ehr/domain/patient.dart';

class PatientCard extends StatelessWidget {
  final Patient patient;
  final VoidCallback onTap;

  const PatientCard({
    super.key,
    required this.patient,
    required this.onTap,
    
  });

  @override
  Widget build(BuildContext context) {
    return BodyCard(
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Row(
          children: [

            CircleAvatar(
              radius: 22,
              child: Text(patient.name[0]),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patient.name,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium,
                  ),
                  Text(
                    patient.diagnosis,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall,
                  ),
                ],
              ),
            ),

            StatusBadge(status: patient.status),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
