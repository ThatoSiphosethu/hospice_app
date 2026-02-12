import 'package:flutter/material.dart';
import 'package:hospice_app/features/ehr/presentation/widgets/horizontal_action_bar.dart';
import 'package:hospice_app/shared/cross_domain/widgets/action_chip_button.dart';

import '../../domain/patient.dart';

class PatientActionButtons extends StatelessWidget {
  final Patient patient;

  const PatientActionButtons({
    super.key,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    return HorizontalActionBar(
      actions: [
        ActionChipButton(
          label: "Notes",
          icon: Icons.description,
          onPressed: () {
            Navigator.pushNamed(context, '/notes', arguments: patient);
          },
        ),

        ActionChipButton(
          label: "Meds",
          icon: Icons.medication,
          onPressed: () {
            Navigator.pushNamed(context, '/meds', arguments: patient);
          },
        ),

        ActionChipButton(
          label: "Care Plan",
          icon: Icons.home,
          onPressed: () {
            Navigator.pushNamed(context, '/care-plan', arguments: patient);
          },
        ),

        ActionChipButton(
          label: "Hosp.",
          icon: Icons.local_hospital,
          onPressed: () {
            Navigator.pushNamed(context, '/hospitalizations', arguments: patient);
          },
        ),

        ActionChipButton(
          label: "Contacts",
          icon: Icons.phone,
          onPressed: () {
            Navigator.pushNamed(context, '/emergency-contacts', arguments: patient);
          },
        ),
      ],
    );
  }
}
