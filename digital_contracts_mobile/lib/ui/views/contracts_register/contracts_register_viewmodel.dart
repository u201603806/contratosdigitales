import 'dart:convert';
import 'dart:io';

import 'package:digitalcontractsapp/data_models/contract_colaborator_sample.dart';
import 'package:digitalcontractsapp/data_models/contract_type.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:time_range_picker/time_range_picker.dart';

import 'package:digitalcontractsapp/app/locator.dart';
import 'package:digitalcontractsapp/data_models/business_service.dart';
import 'package:digitalcontractsapp/data_models/country.dart';
import 'package:digitalcontractsapp/data_models/register_form_data.dart';
import 'package:digitalcontractsapp/data_models/rubro.dart';
import 'package:digitalcontractsapp/res/pallete_color.dart';
import 'package:digitalcontractsapp/services/api.dart';
import 'package:digitalcontractsapp/services/media_services.dart';
import 'package:digitalcontractsapp/ui/widgets/alerts/alerts.dart';

enum Day { Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday }

class ContractsRegisterViewModel extends FutureViewModel<void> {
  final Api _api = locator<Api>();
  final NavigationService _navigationService = locator<NavigationService>();
  final MediaService _mediaService = locator<MediaService>();

  int _currentIndex = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<bool> _selectedWeekDays = [true, true, true, true, true, false, false];
  TimeOfDay _startTime;
  TimeOfDay _endTime;

  BuildContext _context;
  final localizationsFormatter = DefaultMaterialLocalizations();
  List<Country> _countries;
  List<Rubro> _rubros;

  String _errorTextFormat;
  String _errorTextDocumentType;

  String _helperGeneralSchedule;
  Color _colorBorderEndHourText = PalleteColor.informationText;

  bool _requireConfirmation = false;
  bool _requireAddedValue = false;

  List<ContractType> _contracTypes = new List();

  List<Contract> _contractss = [
    Contract(documentNumber: '123454365', person: 'Jose Alberto Gonzalez', email: 'chuchau@canvia.com'),
    Contract(documentNumber: '983534534', person: 'Rosa María Placios', email: 'rosa@canvia.com'),
  ];
  List<ContractColaboratorSample> _selectedContracts = [];

  String _documentTypeSelected;
  String _formatSelected;

  String _businessName = '';
  int _quota;
  String _description = '';

  File _pickedFileDocument;
  String _errorTextImage;
  String _errorTextPlace;

  List<ContractColaboratorSample> _contractsUploaded = new List();

  List<TimeRange> _generalScheduleTimeRange = new List();
  List<TimeRange> _mondayTimeRange = new List();
  List<TimeRange> _tuesdayTimeRange = new List();
  List<TimeRange> _wednesdayTimeRange = new List();
  List<TimeRange> _thursdayTimeRange = new List();
  List<TimeRange> _fridayTimeRange = new List();
  List<TimeRange> _saturdayTimeRange = new List();
  List<TimeRange> _sundayTimeRange = new List();

  bool _hasErrorGeneralSchedule = false;
  List<String> _base64FileDocument = new List();

  // * Getters
  GlobalKey<FormState> get formKey => _formKey;
  int get currentIndex => _currentIndex;
  bool get requireConfirmation => _requireConfirmation;
  bool get requireAddedValue => _requireAddedValue;
  List<bool> get selectedWeekDays => _selectedWeekDays;
  String get helperGeneralSchedule => _helperGeneralSchedule;
  Color get colorBorderStartHourText => _colorBorderEndHourText;
  List<ContractColaboratorSample> get selectedContracts => _selectedContracts;
  List<ContractColaboratorSample> get contractsUploaded => _contractsUploaded;

  List<ContractType> get contractTypes => _contracTypes;

  List<Country> get countries => _countries;
  List<Rubro> get rubros => _rubros;
  String get errorTextFormat => _errorTextFormat;
  String get errorTextDocumentType => _errorTextDocumentType;

  String get documentTypeSelected => _documentTypeSelected;
  String get formatSelected => _formatSelected;

  String get businessName => _businessName;
  int get quota => _quota;
  String get description => _description;

  File get pickedFileDocument => _pickedFileDocument;
  List<String> get base64FileDocument => _base64FileDocument;
  String get errorTextImage => _errorTextImage;

  String _idEnvio = '';

  String get errorTextPlace => _errorTextPlace;

  List<TimeRange> get generalScheduleTimeRange => _generalScheduleTimeRange;
  List<TimeRange> get mondayTimeRange => _mondayTimeRange;
  List<TimeRange> get tuesdayTimeRange => _tuesdayTimeRange;
  List<TimeRange> get wednesdayTimeRange => _wednesdayTimeRange;
  List<TimeRange> get thursdayTimeRange => _thursdayTimeRange;
  List<TimeRange> get fridayTimeRange => _fridayTimeRange;
  List<TimeRange> get saturdayTimeRange => _saturdayTimeRange;
  List<TimeRange> get sundayTimeRange => _sundayTimeRange;

  bool get hasErrorGeneralSchedule => _hasErrorGeneralSchedule;

  // * Functions

  void initialize(BuildContext context) {
    this._context = context;
    _startTime = TimeOfDay(hour: 7, minute: 0);
    _endTime = TimeOfDay(hour: 18, minute: 0);
  }

  @override
  Future<void> futureToRun() => _fetchRegisterFormData();

  @override
  void onError(error) {}

  Future<void> _fetchRegisterFormData() async {
    var result = await _api.getContractTypes();
    result.forEach((element) {
      _contracTypes.add(ContractType.fromJson(element));
    });
  }

  void updateIndex(int index) {
    this._currentIndex = index;
    notifyListeners();
  }

  void updatebusinessName(String value) {
    _businessName = value;
  }

  void updateQuota(String value) {
    _quota = int.tryParse(value);
  }

  void updateDescription(String value) {
    _description = value;
  }

  void selectWeekDay(int index) {
    FocusScope.of(_context).unfocus();
    _selectedWeekDays[index] = !_selectedWeekDays[index];
    notifyListeners();
  }

  void updateRequireConfirmation(bool value) {
    FocusScope.of(_context).unfocus();
    _requireConfirmation = value;
    notifyListeners();
  }

  void updateRequireAddedValue(value) {
    FocusScope.of(_context).unfocus();
    _requireAddedValue = value;
    notifyListeners();
  }

  void showTimeRangeSchedule({List<TimeRange> dayTimeRange}) async {
    FocusScope.of(_context).unfocus();
    TimeRange range = await showTimeRangePicker(
      context: _context,
      start: _startTime,
      end: _endTime,
      disabledColor: Colors.red.withOpacity(0.5),
      strokeWidth: 4,
      ticks: 24,
      ticksOffset: -7,
      ticksLength: 15,
      fromText: 'Desde',
      toText: 'Hasta',
      strokeColor: Colors.lightBlue,
      handlerColor: Colors.blueGrey,
      use24HourFormat: true,
      ticksColor: Colors.grey,
      labels: ["12 pm", "3 am", "6 am", "9 am", "12 am", "3 pm", "6 pm", "9 pm"].asMap().entries.map((e) {
        return ClockLabel.fromIndex(idx: e.key, length: 8, text: e.value);
      }).toList(),
      labelOffset: 35,
      rotateLabels: false,
      padding: 60,
    );
    if (range != null) {
      _getHourFormat(range.endTime);
      _addTimeRange(timeRangeSelected: range, dayTimeRange: dayTimeRange);
    }
  }

  void _addTimeRange({TimeRange timeRangeSelected, List<TimeRange> dayTimeRange}) {
    bool registerTimeRange = true;
    for (var timeRange in dayTimeRange) {
      if (_isTimeRangeSelectedBetweenTimeRange(timeRange, timeRangeSelected)) {
        Future.delayed(Duration(milliseconds: 500)).then((value) {
          Alert(context: _context, title: 'Alerta', label: 'Seleccione un rango de horas que no se encuentren previamente registrados.').error();
        });
        registerTimeRange = false;
        break;
      }
    }
    if (registerTimeRange) {
      dayTimeRange.add(TimeRange(startTime: timeRangeSelected.startTime, endTime: timeRangeSelected.endTime));
      if (_generalScheduleTimeRange.isNotEmpty && _currentIndex == 0) {
        _hasErrorGeneralSchedule = false;
      }
      notifyListeners();
    }
  }

  bool _isTimeRangeSelectedBetweenTimeRange(TimeRange timeRange, TimeRange rangeSelected) {
    if (!_timeRangeEquals(timeRange, rangeSelected)) {
      if (_isTimeBetweenTimeRange(timeRange, rangeSelected.startTime)) return true;
      if (_isTimeBetweenTimeRange(timeRange, rangeSelected.endTime, isFinal: true)) return true;
      return false;
    } else {
      return true;
    }
  }

  bool _timeRangeEquals(TimeRange timeRange, TimeRange rangeSelected) {
    return toDouble(timeRange.startTime) == toDouble(rangeSelected.startTime) && toDouble(timeRange.endTime) == toDouble(rangeSelected.endTime);
  }

  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

  bool _isTimeBetweenTimeRange(TimeRange timeRange, TimeOfDay timeSelected, {bool isFinal = false}) {
    if (timeRange.startTime.hour < timeSelected.hour && timeSelected.hour < timeRange.endTime.hour) {
      return true;
    } else if (timeRange.startTime.hour == timeSelected.hour) {
      if (timeRange.startTime.minute < timeSelected.minute || (!isFinal && timeRange.startTime.minute <= timeSelected.minute)) {
        return true;
      }
    } else if (timeSelected.hour == timeRange.endTime.hour) {
      if (timeSelected.minute < timeRange.endTime.minute || (isFinal && timeSelected.minute <= timeRange.endTime.minute)) {
        return true;
      }
    }
    return false;
  }

  void onSelectedRow(bool selected, ContractColaboratorSample service) async {
    if (selected) {
      _selectedContracts.add(service);
    } else {
      _selectedContracts.remove(service);
    }
    notifyListeners();
  }

  void deleteSelected() async {
    if (_selectedContracts.isNotEmpty) {
      List<ContractColaboratorSample> temp = [];
      temp.addAll(_selectedContracts);
      for (ContractColaboratorSample contract in temp) {
        _contractsUploaded.remove(contract);
        _selectedContracts.remove(contract);
      }
    }
    notifyListeners();
  }

  void addContract() {
    var service = new ContractColaboratorSample();
    _contractsUploaded.add(service);
    notifyListeners();
  }

  void updateDocumentType(type) {
    _documentTypeSelected = type;
    _errorTextDocumentType = null;
    notifyListeners();
  }

  void updateFormat(format) {
    _formatSelected = format;
    _errorTextFormat = null;
    notifyListeners();
  }

  Future pickDocument() async {
    _pickedFileDocument = await FilePicker.getFile(type: FileType.custom, allowedExtensions: ['xls', 'xlsx']);
    if (_pickedFileDocument != null) {
      _base64FileDocument.add(base64Encode(await _pickedFileDocument.readAsBytes()));
    }
    notifyListeners();
  }

  void completeStepOne() async {
    if (_validationStepOne()) {
      try {
        await uploadContracts();
        _currentIndex = 1;
        notifyListeners();
      } catch (e) {}
    }
  }

  void _generateTimeRangeByDaySelected() {
    if (selectedWeekDays[0]) _mondayTimeRange.addAll(_generalScheduleTimeRange);
    if (selectedWeekDays[1]) _tuesdayTimeRange.addAll(_generalScheduleTimeRange);
    if (selectedWeekDays[2]) _wednesdayTimeRange.addAll(_generalScheduleTimeRange);
    if (selectedWeekDays[3]) _thursdayTimeRange.addAll(_generalScheduleTimeRange);
    if (selectedWeekDays[4]) _fridayTimeRange.addAll(_generalScheduleTimeRange);
    if (selectedWeekDays[5]) _saturdayTimeRange.addAll(_generalScheduleTimeRange);
    if (selectedWeekDays[6]) _sundayTimeRange.addAll(_generalScheduleTimeRange);
  }

  bool _validationStepOne() {
    bool validatedForm = true;
    if (!_formKey.currentState.validate()) validatedForm = false;
    if (_formatSelected == null) {
      validatedForm = false;
      _errorTextFormat = 'Seleccione un formato';
    } else {
      _errorTextFormat = null;
    }
    if (_documentTypeSelected == null) {
      validatedForm = false;
      _errorTextDocumentType = 'Seleccione un tipo de documento';
    } else {
      _errorTextDocumentType = null;
    }
    if (_pickedFileDocument == null) {
      validatedForm = false;
      _errorTextImage = 'Seleccione un archivo';
    } else {
      _errorTextImage = null;
    }
    return validatedForm;
  }

  void deleteTimeRange(TimeRange timeRange, List<TimeRange> daytimeRanges) {
    daytimeRanges.remove(timeRange);
    notifyListeners();
  }

  Future<void> uploadContracts() async {
    if (_validationFinalStep()) {
      Alert(context: _context).loading('Subiendo contratos');
      try {
        var idTipo = _contracTypes.firstWhere((element) => element.nombre == _formatSelected);
        var response = await _api.uploadData({
          'datos': _base64FileDocument.first,
          'idTipo': idTipo.idTipo,
        });
        _idEnvio = '${response['parametros']['idEnvio']}';
        debugPrint(response.toString());
        if (response['estadoRespuesta'] == 'OK') {
          var responseSampleContractsUploaded = await _api.getSample(_idEnvio, '-');
          if (responseSampleContractsUploaded['estadoRespuesta'] == 'OK') {
            var documentUploaded = responseSampleContractsUploaded['parametros']['lstDocumentos'];
            for (var i = 0; i < documentUploaded.length; i++) {
              _contractsUploaded.add(ContractColaboratorSample.fromJson(documentUploaded[i]));
            }
            Navigator.of(_context, rootNavigator: true).pop();
            Alert(
              context: _context,
              title: '',
              label: 'Contratos registrados correctamente',
            ).error();
          } else {
            throw Exception('No se pudo obtener registros');
          }
        }
      } catch (e) {
        Navigator.of(_context, rootNavigator: true).pop();
        Alert(
          context: _context,
          title: 'Alerta',
          label: 'No se pudo completar el registro intente mas tarde.',
        ).error();
        rethrow;
      }
    } else {
      Alert(
        context: _context,
        title: 'Alerta',
        label:
            'Debe crear al menos un servicio y llenar todos los campos de los servicios del formulario correctamente. No se permite costo o tiempo igual a 0',
      ).error();
    }
  }

  void processContracts() async {
    try {
      Alert(context: _context).loading('Procesando contratos...');
      var response = await _api.processShipment({'idEnvio': _idEnvio});
      if (response['estadoRespuesta'] == 'OK') {
        _navigationService.back(result: 'Created');
        Navigator.of(_context, rootNavigator: true).pop();
        Alert(
          context: _context,
          title: '',
          label: 'Contratos procesados correctamente',
        ).error();
      } else {
        throw Exception('Error processing');
      }
    } catch (e) {
      Navigator.of(_context, rootNavigator: true).pop();
      Alert(
        context: _context,
        title: 'Alerta',
        label: 'Contratos no se procesaron correctamente. Intente más tarde',
      ).error();
    }
  }

  void updateCost(String text, BusinessService service) {
    service.cost = int.tryParse(text);
  }

  void updateTime(String text, BusinessService service) {
    service.time = int.tryParse(text);
  }

  bool _validationFinalStep() {
    bool servicesFilled = true;
    return servicesFilled;
  }

  String _getHourFormat(TimeOfDay time) => localizationsFormatter.formatTimeOfDay(time, alwaysUse24HourFormat: true);
}

class Contract {
  String documentNumber;
  String person;
  String email;
  Contract({
    this.documentNumber,
    this.person,
    this.email,
  });
}
