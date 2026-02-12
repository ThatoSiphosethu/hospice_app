import 'package:flutter/material.dart';

class HorizontalActionBar extends StatelessWidget {
  final List<Widget> actions;
  final double spacing;

  const HorizontalActionBar({
    super.key,
    required this.actions,
    this.spacing = 10,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: actions.length,
        separatorBuilder: (_, __) => SizedBox(width: spacing),
        itemBuilder: (context, index) => actions[index],
      ),
    );
  }
}
