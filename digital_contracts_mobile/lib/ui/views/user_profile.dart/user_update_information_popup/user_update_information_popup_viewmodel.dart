import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:digitalcontractsapp/app/locator.dart';
import 'package:digitalcontractsapp/data_models/appointment.dart';
import 'package:digitalcontractsapp/data_models/user.dart';
import 'package:digitalcontractsapp/services/api.dart';
import 'package:digitalcontractsapp/services/app_model_service.dart';
import 'package:digitalcontractsapp/ui/widgets/alerts/alerts.dart';
import 'package:stacked/stacked.dart';

class UserUpdateInformationPopupViewModel extends BaseViewModel {
  Appointment appointment;

  final Api _api = locator<Api>();
  final AppModel _appModel = locator<AppModel>();

  String _name = "";
  String _phone = "";
  String _documentNumber = "";

  String get name => _name;
  String get phone => _phone;
  String get documentNumber => _documentNumber;

  void initialize() {
    _name = _appModel.user.name;
    _phone = _appModel.user.phone;
    _documentNumber = _appModel.user.documentNumber;
  }

  // * Functions

  void updateUserInformation(BuildContext _) async {
    new Alert(context: _).loading('Wait please');
    try {
      Navigator.of(_).pop();
      Navigator.of(_).pop();
    } on DioError catch (e) {
      Navigator.of(_).pop();
      showError(_, error: e.response.data['description']);
    } catch (e) {
      Navigator.of(_).pop();
      showError(_, error: 'Vuelva a ingresar para visualizar sus datos actualizados');
    }
  }

  void showError(context, {String error}) {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0), side: BorderSide(color: Colors.black, width: 2.0)),
                  shadows: [
                    BoxShadow(blurRadius: 3, color: Colors.black26, spreadRadius: 3),
                  ],
                ),
                child: Material(
                  type: MaterialType.transparency,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: Container(
                              child: Center(
                                  child: Text(error ?? 'Llene los campos requeridos',
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      )))))),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: RaisedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          color: Color(0xff5C93FF),
                          child: Text('Registrar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.only(bottomRight: Radius.circular(15.0), bottomLeft: Radius.circular(15.0))),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }

  void updateName(String value) {
    _name = value;
  }

  void updatePhone(String value) {
    _phone = value;
  }

  void updateDocumentNumber(String value) {
    _documentNumber = value;
  }

  void closePopup(BuildContext _) {
    Navigator.of(_).pop();
  }
}
