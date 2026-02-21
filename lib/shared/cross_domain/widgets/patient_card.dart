/// Reusable patient information card component for displaying patient details.
library;

import 'package:flutter/material.dart';

import '../../../features/ehr/domain/patient.dart';
import '../../widgets/body_card.dart';
import '../../widgets/status_badge.dart';
import 'action_chip_button.dart';

/// A card widget that displays patient information with basic details and optional actions.
///
/// This card shows the patient's name, diagnosis, status badge, and optional action button.
/// It does not depend on specific features, making it reusable across the app.
class PatientCard extends StatelessWidget {
  /// The patient data to display
  final Patient patient;

  /// Callback triggered when the card is tapped
  final VoidCallback onTap;

  /// Optional label and icon for a primary action button
  final String? actionLabel;
  final IconData? actionIcon;
  final Color? actionColor;

  /// Callback for the action button
  final VoidCallback? onActionPressed;

  const PatientCard({
    super.key,
    required this.patient,
    required this.onTap,
    this.actionLabel,
    this.actionIcon,
    this.actionColor,
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BodyCard(
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top Row (Avatar + Info + Status)
            Row(
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
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        patient.diagnosis,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                StatusBadge(status: patient.status),
                const SizedBox(width: 8),
                const Icon(Icons.chevron_right),
              ],
            ),

            /// Optional Action Button
            if (actionLabel != null && onActionPressed != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: ActionChipButton(
                  label: actionLabel!,
                  icon: actionIcon ?? Icons.edit,
                  color: actionColor ?? Colors.blue,
                  onPressed: onActionPressed!,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
