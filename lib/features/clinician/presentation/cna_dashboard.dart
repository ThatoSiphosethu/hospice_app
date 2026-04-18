import 'package:flutter/material.dart';
import 'package:hospice_app/shared/widgets/cards/shift_status_card.dart';
import 'package:hospice_app/shared/widgets/cards/next_visit_card.dart';
import 'package:hospice_app/shared/widgets/cards/visit_tile.dart';
import 'package:hospice_app/features/scheduling/data/mock_visit_repository.dart';
import 'package:hospice_app/features/scheduling/domain/visit.dart';
import 'package:hospice_app/features/visit/presentation/visit_mode_screen.dart';
import '../../../core/auth/auth_session.dart';

class CNADashboard extends StatefulWidget {
  const CNADashboard({super.key});

  String get greeting {
    final hour = DateTime.now().hour;

    if (hour < 12) return "Good Morning";
    if (hour < 17) return "Good Afternoon";
    return "Good Evening";
  }

  @override
  State<CNADashboard> createState() => _CNADashboardState();
}

class _CNADashboardState extends State<CNADashboard> {
  late Future<List<Visit>> _visitsFuture;
  bool _isClockedIn = false; // Start clocked out

  Future<List<Visit>> _refreshVisits(Visit updatedVisit) async {
    final visits = await MockVisitRepository().getTodayVisits();

    return visits.map((visit) {
      if (visit.id == updatedVisit.id) {
        return updatedVisit;
      }
      return visit;
    }).toList();
  }

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
                Text(
                  "${widget.greeting}, ${AuthSession.currentUser?.name ?? 'User'} 👋 ", 

                  // Dynamic greeting based on time of day to be implemented later

                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),

                
                ),
                const SizedBox(height: 20),

                /// Shift Card
                ShiftStatusCard(
                  shiftTime: "08:00 - 16:00 ", // This can be made dynamic based on actual shift data  
                  isClockedIn: _isClockedIn,
                  onToggle: () {
                    setState(() {
                      _isClockedIn = !_isClockedIn;
                    });
                  },
                ),

                const SizedBox(height: 20),

                /// Next Visit (Dynamic)
                if (nextVisit != null)
                  NextVisitCard(
                    patientName: nextVisit.patient.name,
                    time: _formatTime(nextVisit.scheduledTime),
                    address: nextVisit.patient.address ?? "",
                    onStart: () async {
                      final updatedVisit = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VisitModeScreen(visit: nextVisit),
                        ),
                      );

                      if (updatedVisit != null) {
                        setState(() {
                          _visitsFuture = _refreshVisits(updatedVisit);
                        });
                      }
                    },
                  ),

                const SizedBox(height: 24),

                /// Today's Visits Title
                const Text(
                  "Today's Visits",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                /// Dynamic Visit List
                ...visits.map(
                  (visit) => VisitTile(
                    visit: visit,
                    onTap: () async {
                      final updatedVisit = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VisitModeScreen(visit: visit),
                        ),
                      );

                      if (updatedVisit != null) {
                        setState(() {
                          _visitsFuture = _refreshVisits(updatedVisit);
                        });
                      }
                    },
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
