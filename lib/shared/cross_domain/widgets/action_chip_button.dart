import 'package:flutter/material.dart';

class ActionChipButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;

  const ActionChipButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ActionChip(
      avatar: Icon(
        icon,
        size: 18,
        color: Colors.white,
      ),
      label: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: color ??
          theme.colorScheme.primary, // uses theme automatically
      onPressed: onPressed,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }
}
