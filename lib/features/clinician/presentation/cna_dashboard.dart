import 'package:flutter/material.dart';
import 'package:hospice_app/shared/widgets/cards/shift_status_card.dart';
import 'package:hospice_app/shared/widgets/cards/next_visit_card.dart';
import 'package:hospice_app/shared/widgets/cards/visit_tile.dart';
import 'package:hospice_app/features/scheduling/data/mock_visit_repository.dart';
import 'package:hospice_app/features/scheduling/domain/visit_.dart';

class CNADashboard extends StatefulWidget {
  const CNADashboard({super.key});

  @override
  State<CNADashboard> createState() => _CNADashboardState();
}

class _CNADashboardState extends State<CNADashboard> {
  late Future<List<Visit>> _visitsFuture;

  @override
  void initState() {
    super.initState();
    _visitsFuture = MockVisitRepository().getTodayVisits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Visit>>(
        future: _visitsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final visits = snapshot.data!;
          final nextVisit = visits.isNotEmpty ? visits.first : null;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Greeting
                const Text(
                  "Good Morning 👋 ", 

                  // Dynamic greeting based on time of day to be implemented later

                  // Style: Larger, friendly font

                  // Color: Use theme's primary color for warmth

                  // Spacing: Add some vertical space below the greeting

                  // Consider adding the CNA's name if available for a more personalized touch

                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                /// Shift Card
                ShiftStatusCard(
                  shiftTime: "8:00 AM - 4:00 PM",
                  isClockedIn: true,
                  onToggle: () {},
                ),

                const SizedBox(height: 20),

                /// Next Visit (Dynamic)
                if (nextVisit != null)
                  NextVisitCard(
                    patientName: nextVisit.patient.name,
                    time: _formatTime(nextVisit.scheduledTime),
                    address: nextVisit.patient.address ?? "",
                    onStart: () {},
                  ),

                const SizedBox(height: 24),

                /// Today's Visits Title
                const Text(
                  "Today's Visits",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                /// Dynamic Visit List
                ...visits.map(
                  (visit) => VisitTile(
                    patientName: visit.patient.name,
                    time: _formatTime(visit.scheduledTime),
                    address: visit.patient.address ?? "",
                    onTap: () {},
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour > 12 ? time.hour - 12 : time.hour;
    final period = time.hour >= 12 ? "PM" : "AM";
    return "$hour:00 $period";
  }
}
