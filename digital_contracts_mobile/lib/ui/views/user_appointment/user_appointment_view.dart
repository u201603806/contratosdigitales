import 'package:digitalcontractsapp/data_models/appointment.dart';
import 'package:digitalcontractsapp/ui/views/user_appointment/user_appointment_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';

class UserAppointmentView extends StatefulWidget {
  UserAppointmentView();

  @override
  _UserAppointmentViewState createState() => _UserAppointmentViewState();
}

class _UserAppointmentViewState extends State<UserAppointmentView> with TickerProviderStateMixin {
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();

    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserAppointmentViewModel>.reactive(
      viewModelBuilder: () => UserAppointmentViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _buildTableCalendarWithBuilders(model),
            if (!model.isBusy && !model.hasError) ...[
              const SizedBox(height: 8.0),
              Expanded(child: AppointmentCalendar()),
            ],
          ],
        ),
      ),
    );
  }

  // Simple TableCalendar configuration (using Styles)

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders(UserAppointmentViewModel model) {
    return TableCalendar(
      calendarController: _calendarController,
      events: model.isBusy ? {} : model.events,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.horizontalSwipe,
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.blue[300],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.black12,
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
              ),
            );
          }

          return children;
        },
      ),
      onDaySelected: (date, events) {
        model.onDaySelected(date, events);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: model.onVisibleDaysChanged,
      onCalendarCreated: model.onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date) ? Colors.deepPurple : _calendarController.isToday(date) ? Colors.deepPurple : Colors.lightBlue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }
}

class AppointmentCalendar extends ViewModelWidget<UserAppointmentViewModel> {
  const AppointmentCalendar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, UserAppointmentViewModel model) {
    return ListView(
      children: model.selectedEvents.map((appointment) {
        if (appointment != null) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.8),
              borderRadius: BorderRadius.circular(12.0),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    title: Text(appointment.service.name),
                    subtitle: Text(appointment.service.businessAppointment.name),
                    onTap: () => model.onTapEvent(appointment, context),
                  ),
                ),
                Text(model.getStatusNameAppointment(appointment)),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Icon(Icons.fiber_manual_record, color: model.getAppointmentStatusColor((appointment as Appointment).status)),
                )
              ],
            ),
          );
        } else {
          return Container();
        }
      }).toList(),
    );
  }
}
