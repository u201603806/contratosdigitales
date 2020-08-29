import 'package:digitalcontractsapp/app/locator.dart';
import 'package:digitalcontractsapp/data_models/appointment.dart';
import 'package:digitalcontractsapp/data_models/enums/appointment_status.dart';
import 'package:digitalcontractsapp/services/api.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class UserAppointmentViewModel extends FutureViewModel<Map> {
  final Api _api = locator<Api>();

  Map<DateTime, List> _events;
  List _selectedEvents = new List();

  final DateFormat _dateFormatyyyyMMdd = DateFormat("yyyy-MM-dd");
  final DateFormat _dateFormatyyyyMM = DateFormat("yyyy-MM");

  bool _errorFetchingDayAppointments = false;
  bool _errorFetchingMonthAppointments = false;

  DateTime _now = new DateTime.now();

  // * Getters

  List get selectedEvents => _selectedEvents;
  Map<DateTime, List> get events => _events;
  bool get errorFetchingDayAppointments => _errorFetchingDayAppointments;
  bool get errorFetchingMonthAppointments => _errorFetchingMonthAppointments;

  // * Functions

  @override
  Future<Map> futureToRun() => _getUserMonthAppointments(_now);

  @override
  void onError(error) {
    print('ssdasd');
  }

  Future<Map> _getUserMonthAppointments(DateTime dateMonth) async {
  }

  Map<DateTime, List> _getEventsFromMonthAppointments(List appointments) {
    Map<DateTime, List> eventsUser = new Map();
    appointments.forEach((a) {
      DateTime appointmentDay = _dateFormatyyyyMMdd.parse(a['fechaInicio']);

      eventsUser[appointmentDay.toLocal()] = createAppointments(a['cantidad']);
    });
    return eventsUser;
  }

  List createAppointments(int numberAppointments) {
    List appointmentsCreated = new List(numberAppointments);
    return appointmentsCreated;
  }

  Future<List> getUserAppointments(DateTime day) async {
    try {
      throw Exception('Error fetching data');
    } catch (e) {
      return null;
    }
  }


  void onDaySelected(DateTime day, List eventsDay) async {
    if (eventsDay.isNotEmpty) {
      _selectedEvents = await getUserAppointments(day) ?? [];
    } else {
      _selectedEvents = [];
    }
    notifyListeners();
  }

  void onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) async {
    await _getUserMonthAppointments(first);
    notifyListeners();
  }

  void onCalendarCreated(DateTime first, DateTime last, CalendarFormat format) async {
    _selectedEvents = await getUserAppointments(_now) ?? [];
    notifyListeners();
  }

  void onTapEvent(Appointment appointment, BuildContext _) {
  }

  Color getAppointmentStatusColor(int statusAppointment) {
    return AppointmenteStatusHelper.getColor(AppointmentStatus.values[statusAppointment]);
  }

  String getStatusNameAppointment(Appointment appointment) {
    return AppointmenteStatusHelper.getValue(AppointmentStatus.values[appointment.status]);
  }
}
