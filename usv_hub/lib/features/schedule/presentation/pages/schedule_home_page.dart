import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/features/schedule/presentation/widgets/event.dart';

class ScheduleHomePage extends StatefulWidget {
  const ScheduleHomePage({super.key});

  @override
  State<ScheduleHomePage> createState() => _ScheduleHomePageState();
}

class _ScheduleHomePageState extends State<ScheduleHomePage> {
  late final ValueNotifier<List<Event>> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    //TODO: Implement this method
    log("day:$day");

    if (day.year == DateTime.now().year &&
        day.month == DateTime.now().month &&
        day.day == DateTime.now().day) {
      return [const Event('Today\'s Event 1'), const Event('Today\'s Event 2')];
    }
    return [const Event('Event 1'), const Event('Event 2')];
  }

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  final kToday = DateTime.now();
  final kFirstDay = DateTime(
      DateTime.now().year, DateTime.now().month - 3, DateTime.now().day);
  final kLastDay = DateTime(
      DateTime.now().year, DateTime.now().month + 3, DateTime.now().day);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
      ),
      body: Background(
        child: Padding(
          padding: EdgeInsets.only(top: 30.h),
          child: Column(
            children: [
              TableCalendar(
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                rowHeight: 50.h,
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, date, focusedDay) => Container(
                    height: 40.h,
                    width: 40.h,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            width: 2)),
                    child: Center(
                      child: Text(
                        date.day.toString(),
                      ),
                    ),
                  ),
                  selectedBuilder: (context, date, events) => Container(
                    height: 40.h,
                    width: 40.h,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          width: 2,
                        )),
                    child: Center(
                      child: Text(
                        date.day.toString(),
                      ),
                    ),
                  ),
                  todayBuilder: (context, date, focusedDay) => Container(
                    height: 40.h,
                    width: 40.h,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2)),
                    child: Center(
                      child: Text(
                        date.day.toString(),
                      ),
                    ),
                  ),
                ),
                firstDay: kFirstDay,
                lastDay: kLastDay,
                focusedDay: _focusedDay,
                //      eventLoader: _getEventsForDay,
                selectedDayPredicate: (day) {
                  // Use `selectedDayPredicate` to determine which day is currently selected.
                  // If this returns true, then `day` will be marked as selected.

                  // Using `isSameDay` is recommended to disregard
                  // the time-part of compared DateTime objects.
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    // Call `setState()` when updating the selected day
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                    _selectedEvents.value = _getEventsForDay(selectedDay);
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: ValueListenableBuilder<List<Event>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: ListTile(
                            onTap: () => print('${value[index]}'),
                            title: Text('${value[index]}'),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
