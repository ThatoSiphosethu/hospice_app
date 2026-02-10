/// Common shell used by clinician-facing screens.
///
/// Provides a `Scaffold` with a configurable bottom navigation bar and a
/// list of pages. This keeps navigation UI consistent across clinician
/// entry points.
import 'package:flutter/material.dart';

/// AppShell is a reusable scaffold with a bottom navigation bar.
///
/// - `pages` is the list of page widgets shown for each tab.
/// - `items` are the corresponding `BottomNavigationBarItem`s.
class AppShell extends StatefulWidget {
  /// The page widgets that correspond to each bottom nav tab.
  final List<Widget> pages;

  /// The items to display in the `BottomNavigationBar`.
  final List<BottomNavigationBarItem> items;

  const AppShell({
    super.key,
    required this.pages,
    required this.items,
  });

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  // The currently selected tab index. Defaults to 1 to show the middle tab.
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Scaffold manages the overall visual structure: body + bottom nav.
    return Scaffold(
      // Display the page corresponding to the active index.
      body: widget.pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        // Keep the BottomNavigationBar in sync with the selected index.
        currentIndex: _currentIndex,
        items: widget.items,
        // Update the state when the user taps a different tab.
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
