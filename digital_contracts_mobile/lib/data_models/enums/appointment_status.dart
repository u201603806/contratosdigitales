import 'package:flutter/material.dart';

enum AppointmentStatus {
  Libre,
  Reservado,
  EnAtencion,
  NoSePresento,
  Finalizado,
  Cancelado,
  None,
}

class AppointmenteStatusHelper {
  static String getValue(AppointmentStatus appointmentStatus) {
    switch (appointmentStatus) {
      case AppointmentStatus.Libre:
        return 'Libre';
      case AppointmentStatus.Reservado:
        return 'Reservado';
      case AppointmentStatus.EnAtencion:
        return 'En atención';
      case AppointmentStatus.NoSePresento:
        return 'No se presentó';
      case AppointmentStatus.Finalizado:
        return 'Finalizado';
      case AppointmentStatus.Cancelado:
        return 'Cancelado';
      default:
        return "";
    }
  }

  static Color getColor(AppointmentStatus appointmentStatus) {
    switch (appointmentStatus) {
      case AppointmentStatus.Libre:
        return Colors.lightBlue;
        break;
      case AppointmentStatus.Reservado:
        return Colors.orange;
        break;
      case AppointmentStatus.EnAtencion:
        return Colors.purple;
        break;
      case AppointmentStatus.NoSePresento:
        return Colors.red;
        break;
      case AppointmentStatus.Finalizado:
        return Colors.green;
        break;
      case AppointmentStatus.Cancelado:
        return Colors.black;
        break;
      default:
        return Colors.white;
    }
  }
}
