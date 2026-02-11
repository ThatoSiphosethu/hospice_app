import 'package:flutter/material.dart';

class ScrollContainer extends StatelessWidget {
  final List<Widget> children;

  const ScrollContainer({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: children.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) => children[index],
      ),
    );
  }
}
