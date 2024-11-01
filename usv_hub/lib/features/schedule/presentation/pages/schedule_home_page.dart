import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/core/utils/functions.dart';
import 'package:usv_hub/features/schedule/domain/entities/schedule_entity.dart';
import 'package:usv_hub/features/schedule/presentation/cubit/schedule_cubit.dart';

class ScheduleHomePage extends StatefulWidget {
  const ScheduleHomePage({super.key});

  @override
  State<ScheduleHomePage> createState() => _ScheduleHomePageState();
}

class _ScheduleHomePageState extends State<ScheduleHomePage> {
  late final ValueNotifier<List<ScheduleEntity>> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _selectedEvents =
        ValueNotifier(_getEventsForDay(DateTime.now().weekday, []));
    Future.microtask(() async {
      if (mounted) await context.read<ScheduleCubit>().getSchedule();
    }).then(
      (_) {
        if (mounted && context.read<ScheduleCubit>().state is ScheduleLoaded) {
          final state = context.read<ScheduleCubit>().state as ScheduleLoaded;

          _selectedEvents.value =
              _getEventsForDay(DateTime.now().weekday, state.schedule);
        }
      },
    );
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<ScheduleEntity> _getEventsForDay(
      int day, List<ScheduleEntity> schedule) {
    List<ScheduleEntity> selectedEvents = [];

    for (final event in schedule) {
      if (event.dayOfWeek == day) {
        selectedEvents.add(event);
      }
    }
    return selectedEvents;
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
          child: BlocBuilder<ScheduleCubit, ScheduleState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ErrorState) {
                return Center(
                  child: Text(state.message),
                );
              }
              if (state is ScheduleLoaded) {
                return Column(
                  children: [
                    TableCalendar(
                      headerStyle: const HeaderStyle(
                        leftChevronVisible: false,
                        rightChevronVisible: false,
                        formatButtonVisible: false,
                        titleCentered: true,
                      ),
                      rowHeight: 50.h,
                      calendarBuilders: CalendarBuilders(
                        defaultBuilder: (context, date, focusedDay) =>
                            Container(
                          height: 40.h,
                          width: 40.h,
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  width: 2)),
                        ),
                        selectedBuilder: (context, date, events) => Container(
                          height: 40.h,
                          width: 40.h,
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                                width: 2,
                              )),
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
                        ),
                      ),
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: _focusedDay,
                      availableGestures: AvailableGestures.none,
                      //      eventLoader: _getEventsForDay,
                      calendarFormat: CalendarFormat.week,
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
                          _selectedEvents.value = _getEventsForDay(
                              selectedDay.weekday, state.schedule);
                        }
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                    ),
                    SizedBox(height: 10.h),
                    Expanded(
                      child: ValueListenableBuilder<List<ScheduleEntity>>(
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
                                  title: Text(
                                    value[index].courseTitle,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing: Text(
                                    value[index].sala,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text(
                                    '${dayFromInt(value[index].dayOfWeek)} ${value[index].startingHour} - ${value[index].endingHour}',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
