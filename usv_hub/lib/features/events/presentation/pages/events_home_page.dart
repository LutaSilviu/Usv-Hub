import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/features/events/domain/entities/event_entity.dart';
import 'package:usv_hub/features/events/presentation/cubit/events_cubit.dart';
import 'package:usv_hub/injection.dart';

class EventsHomePage extends StatefulWidget {
  const EventsHomePage({super.key});

  @override
  State<EventsHomePage> createState() => _EventsHomePageState();
}

class _EventsHomePageState extends State<EventsHomePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  final kFirstDay = DateTime(
      DateTime.now().year, DateTime.now().month - 3, DateTime.now().day);
  final kLastDay = DateTime(
      DateTime.now().year, DateTime.now().month + 3, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventzz'),
      ),
      body: BlocProvider(
        create: (context) => getIt<EventsCubit>()..getEvents(),
        child: Background(
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
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
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
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
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
                    }
                  },
                  onPageChanged: (focusedDay) {
                    // No need to call `setState()` here
                    _focusedDay = focusedDay;
                  },
                ),
                SizedBox(height: 10.h),
                Expanded(
                  child: BlocBuilder<EventsCubit, EventsState>(
                    builder: (context, state) {
                      if (state is EventsLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is EventsError) {
                        return Center(
                          child: Text(state.message),
                        );
                      }
                      if (state is EventsLoaded) {
                        final List<EventEntity> selectedList = state.events
                            .where((e) =>
                                e.startTime.year == _selectedDay!.year &&
                                e.startTime.month == _selectedDay!.month &&
                                e.startTime.day == _selectedDay!.day)
                            .toList();
                        return ListView.builder(
                          itemCount: selectedList.length,
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
                                title: Text(selectedList[index].title),
                                subtitle:
                                    Text(selectedList[index].classWhereHeld),
                                trailing: Text(
                                    selectedList[index].startTime.toString()),
                              ),
                            );
                          },
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
