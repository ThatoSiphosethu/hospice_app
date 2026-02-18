import 'package:flutter/material.dart';
import 'scheduler_colors.dart';
import '../../../features/ehr/domain/appointment.dart';

enum CalendarView { day, week, month }

class AppScheduler extends StatefulWidget {
  final List<Appointment> items;

  const AppScheduler({super.key, required this.items});

  @override
  State<AppScheduler> createState() => _AppSchedulerState();
}

class _AppSchedulerState extends State<AppScheduler> {
  // FIXED: Added missing variable to track the view state
  CalendarView _currentView = CalendarView.day; 
  DateTime selectedDate = DateTime.now();

  void _updateSchedule(Appointment item, int newHour) {
    setState(() {
      item.startHour = newHour;
    });
  }

  void _changeDate(int direction) {
    setState(() {
      if (_currentView == CalendarView.day) {
        selectedDate = selectedDate.add(Duration(days: direction));
      } else if (_currentView == CalendarView.week) {
        selectedDate = selectedDate.add(Duration(days: 7 * direction));
      } else {
        selectedDate = DateTime(
          selectedDate.year,
          selectedDate.month + direction,
          1,
        );
      }
    });
  }

  // --------------------------------------------------
  // HEADER — With Toggle Logic
  // --------------------------------------------------
  Widget _buildHeader() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () => _changeDate(-1),
            ),
            Text(
              "${selectedDate.month}/${selectedDate.day}/${selectedDate.year}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () => _changeDate(1),
            ),
          ],
        ),
        // Added SegmentedButton to actually toggle the views
        SegmentedButton<CalendarView>(
          segments: const [
            ButtonSegment(value: CalendarView.day, label: Text('Day')),
            ButtonSegment(value: CalendarView.week, label: Text('Week')),
            ButtonSegment(value: CalendarView.month, label: Text('Month')),
          ],
          selected: {_currentView},
          onSelectionChanged: (Set<CalendarView> newSelection) {
            setState(() => _currentView = newSelection.first);
          },
        ),
      ],
    );
  }

  // --------------------------------------------------
  // BLOCKS & CARDS
  // --------------------------------------------------
  Widget _buildScheduleBlock(Appointment item) {
    return Draggable<Appointment>(
      data: item,
      feedback: Material(child: _scheduleCard(item, true)),
      childWhenDragging: Container(),
      child: _scheduleCard(item, false),
    );
  }

  Widget _scheduleCard(Appointment item, bool isFeedback) {
    return Container(
      // Ensure feedback doesn't stretch weirdly
      width: isFeedback ? 150 : double.infinity,
      height: 60 * item.duration.toDouble(),
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: scheduleColor(item.type),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        item.title, 
        style: const TextStyle(color: Colors.white, fontSize: 10),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  // --------------------------------------------------
  // VIEW BUILDERS
  // --------------------------------------------------
  @override
  Widget build(BuildContext context) {
    Widget view;
    switch (_currentView) {
      case CalendarView.day:
        view = ListView.builder(
          itemCount: 24,
          itemBuilder: (_, hour) => _buildHourRow(hour),
        );
        break;
      case CalendarView.week:
        view = _buildWeekView();
        break;
      case CalendarView.month:
        view = _buildMonthGrid();
        break;
    }

    return Column(
      children: [
        _buildHeader(),
        const SizedBox(height: 12),
        Expanded(child: view),
      ],
    );
  }

  Widget _buildHourRow(int hour) {
    final itemsHere = widget.items.where((e) => 
      e.startHour == hour && 
      e.date.day == selectedDate.day &&
      e.date.month == selectedDate.month
    ).toList();

    return Row(
      children: [
        SizedBox(width: 50, child: Text("$hour:00", style: const TextStyle(fontSize: 12))),
        Expanded(
          child: DragTarget<Appointment>(
            onAccept: (data) => _updateSchedule(data, hour),
            builder: (context, _, __) {
              return Container(
                height: 60,
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                ),
                child: Stack(
                  children: itemsHere.map((e) => _buildScheduleBlock(e)).toList(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWeekView() {
    final startOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));

    return Row(
      children: List.generate(7, (dayIndex) {
        final dayDate = startOfWeek.add(Duration(days: dayIndex));
        return Expanded(
          child: Column(
            children: [
              Text("${dayDate.day}", style: const TextStyle(fontWeight: FontWeight.bold)),
              Expanded(
                child: ListView.builder(
                  itemCount: 24,
                  itemBuilder: (_, hour) {
                    final itemsHere = widget.items.where((e) =>
                        e.startHour == hour &&
                        e.date.day == dayDate.day &&
                        e.date.month == dayDate.month).toList();

                    return DragTarget<Appointment>(
                      onAccept: (data) {
                        setState(() {
                          data.startHour = hour;
                          data.date = dayDate;
                        });
                      },
                      builder: (_, __, ___) => Container(
                        height: 50,
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade100)),
                        child: Stack(
                          children: itemsHere.map((e) => _buildScheduleBlock(e)).toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildMonthGrid() {
    final daysInMonth = DateTime(selectedDate.year, selectedDate.month + 1, 0).day;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
      itemCount: daysInMonth,
      itemBuilder: (_, index) {
        final day = index + 1;
        final itemsHere = widget.items.where((e) => 
          e.date.day == day && e.date.month == selectedDate.month
        ).toList();

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedDate = DateTime(selectedDate.year, selectedDate.month, day);
              _currentView = CalendarView.day;
            });
          },
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade200)),
            child: Column(
              children: [
                Text("$day"),
                Wrap(
                  children: itemsHere.take(3).map((_) => Container(
                    margin: const EdgeInsets.all(1),
                    height: 4, width: 4,
                    decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                  )).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}