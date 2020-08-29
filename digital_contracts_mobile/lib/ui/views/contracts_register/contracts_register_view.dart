import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:digitalcontractsapp/res/pallete_color.dart';
import 'package:digitalcontractsapp/ui/widgets/buttons/action_button_custom.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:time_range_picker/time_range_picker.dart';

import 'contracts_register_viewmodel.dart';

class ContractsRegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => ContractsRegisterViewModel(),
      onModelReady: (model) => model.initialize(context),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Cargo y envío contrato', style: TextStyle(color: PalleteColor.titleTextColor, fontWeight: FontWeight.bold, fontSize: 20.0)),
          backgroundColor: Colors.white,
          centerTitle: true,
          iconTheme: IconThemeData(color: PalleteColor.titleTextColor),
        ),
        backgroundColor: Colors.grey[100],
        body: model.isBusy
            ? Container(child: Center(child: CircularProgressIndicator()))
            : model.hasError
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(child: Text('Registro de contratos no esta habilitado temporalmente')),
                  )
                : Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        _StepsRegister(),
                        const _SeparatorFields(),
                        Form(
                          key: model.formKey,
                          child: Expanded(
                            child: _StepsFormRegister(),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}

class _StepsFormRegister extends ViewModelWidget<ContractsRegisterViewModel> {
  @override
  Widget build(BuildContext context, ContractsRegisterViewModel model) {
    switch (model.currentIndex) {
      case 0:
        return _LoadContractForm();
        break;
      case 1:
        return _ReviewSamples();
        break;
      case 2:
        return _ReviewSamples();
        break;
      default:
        return _LoadContractForm();
    }
  }
}

class _ReviewSamples extends ViewModelWidget<ContractsRegisterViewModel> {
  @override
  Widget build(BuildContext context, ContractsRegisterViewModel model) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2.0, spreadRadius: 1.0, offset: Offset(2.0, 2.0))]),
        child: Column(children: <Widget>[
          _TitleStep(title: 'Muestra'),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text('Numero de documento', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Persona', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Correo', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Opciones', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
              rows: model.contracts
                  .map(
                    (contract) => DataRow(
                        selected: model.selectedContracts.contains(contract),
                        onSelectChanged: (b) {
                          model.onSelectedRow(b, contract);
                        },
                        cells: [
                          DataCell(
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(contract.documentNumber),
                            ),
                          ),
                          DataCell(
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(contract.person),
                            ),
                          ),
                          DataCell(
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(contract.email),
                            ),
                          ),
                          DataCell(
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(Icons.visibility, color: Colors.blue),
                            ),
                          ),
                        ]),
                  )
                  .toList(),
            ),
          ),
          const _SeparatorFields(),
          Wrap(
            spacing: 10.0,
            children: <Widget>[
              OutlineButton(
                child: Text('ELIMINAR ${model.selectedContracts.length}'),
                onPressed: model.selectedContracts.isEmpty
                    ? null
                    : () {
                        model.deleteSelected();
                      },
              ),
            ],
          ),
          const _SeparatorFields(),
          Container(padding: const EdgeInsets.all(20.0), child: ActionButtonCustom(action: () => model.registerBusiness(), label: 'Guardar')),
        ]),
      ),
    );
  }
}

class _SeparatorFields extends StatelessWidget {
  const _SeparatorFields({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 15.0);
  }
}

typedef OnChangeDropdown = Function(dynamic item);

class _RegisterBusinessDropdown extends StatelessWidget {
  const _RegisterBusinessDropdown({
    Key key,
    @required this.items,
    @required this.selectedItem,
    @required this.title,
    @required this.defaultHint,
    @required this.onChanged,
    @required this.errorText,
  })  : assert(items != null),
        assert(title != null),
        assert(defaultHint != null),
        assert(onChanged != null),
        super(key: key);

  final List items;
  final dynamic selectedItem;
  final String title;
  final String defaultHint;
  final OnChangeDropdown onChanged;
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0, left: 4.0, top: 0),
          child: Text(this.title),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            border: Border.all(color: Colors.black, width: 1.2),
          ),
          padding: EdgeInsets.only(right: 15, left: 10),
          width: double.infinity,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<dynamic>(
              onTap: () => FocusScope.of(context).unfocus(),
              hint: Text(this.defaultHint),
              value: this.selectedItem,
              items: this.items.map((item) {
                return DropdownMenuItem<dynamic>(
                  value: item,
                  child: FittedBox(child: Text(item, overflow: TextOverflow.fade)),
                );
              }).toList(),
              onChanged: this.onChanged,
            ),
          ),
        ),
        if (this.errorText != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
            child: Text(
              this.errorText,
              style: TextStyle(color: Colors.redAccent, fontSize: 12),
            ),
          ),
      ],
    );
  }
}

typedef TimeRangeCallBack = Function(TimeRange, List<TimeRange>);
typedef PickTimeRangeCallBack = Function({List<TimeRange> dayTimeRange});

class _ScheduleRange extends ViewModelWidget<ContractsRegisterViewModel> {
  const _ScheduleRange({
    Key key,
    this.dayName,
    @required this.dayTimeRanges,
  })  : assert(dayTimeRanges != null),
        super(key: key);
  final String dayName;
  final List<TimeRange> dayTimeRanges;

  @override
  Widget build(BuildContext context, ContractsRegisterViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (this.dayName != null)
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(this.dayName, overflow: TextOverflow.ellipsis),
              )),
        Expanded(
          flex: this.dayName != null ? 4 : 5,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 40.0,
            ),
            child: Container(
              padding: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2.0, spreadRadius: 1.0, offset: Offset(2.0, 2.0))],
              ),
              child: Wrap(
                  children: dayTimeRanges
                      .map((timeRange) => _TimeDayRange(
                            deleteTimeRange: () => model.deleteTimeRange(timeRange, dayTimeRanges),
                            timeRange: '${timeRange.startTime.format(context)} - ${timeRange.endTime.format(context)}',
                          ))
                      .toList()),
            ),
          ),
        ),
        Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(left: 0.0, top: 10.0),
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                    borderRadius: BorderRadius.circular(25.0), onTap: () => model.showTimeRangeSchedule(dayTimeRange: dayTimeRanges), child: Icon(Icons.add)),
              ),
            )),
      ],
    );
  }
}

class _TimeDayRange extends StatelessWidget {
  const _TimeDayRange({
    Key key,
    @required this.timeRange,
    @required this.deleteTimeRange,
  }) : super(key: key);
  final String timeRange;
  final VoidCallback deleteTimeRange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.grey[200],
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Material(type: MaterialType.transparency, child: InkResponse(onTap: this.deleteTimeRange, child: Icon(Icons.close))),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(this.timeRange),
          ),
        ]),
      ),
    );
  }
}

class _LoadContractForm extends HookViewModelWidget<ContractsRegisterViewModel> {
  _LoadContractForm({
    Key key,
  }) : super(key: key);

  @override
  Widget buildViewModelWidget(BuildContext context, ContractsRegisterViewModel model) {
    final TextEditingController businessNameController = useTextEditingController();
    businessNameController.text = model.businessName;
    final TextEditingController quotaController = useTextEditingController();
    quotaController.text = '${model.quota ?? ''}';
    final TextEditingController descriptionController = useTextEditingController();
    descriptionController.text = model.description;
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowGlow();
        return;
      },
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2.0, spreadRadius: 1.0, offset: Offset(2.0, 2.0))]),
          child: Column(
            children: <Widget>[
              _TitleStep(title: 'Cargar Contrato'),
              const _SeparatorFields(),
              _RegisterBusinessDropdown(
                title: 'Tipo Documento',
                items: ['Contratos', 'Otro'],
                selectedItem: model.documentTypeSelected,
                defaultHint: 'Seleccione...',
                onChanged: model.updateDocumentType,
                errorText: model.errorTextDocumentType,
              ),
              const _SeparatorFields(),
              _RegisterBusinessDropdown(
                title: 'Formatos',
                items: List<String>.generate(model.contractTypes.length, (index) => model.contractTypes[index].nombre),
                selectedItem: model.formatSelected,
                defaultHint: 'Seleccione un formato',
                onChanged: model.updateFormat,
                errorText: model.errorTextFormat,
              ),
              const _SeparatorFields(),
              _FileField(),
              const _SeparatorFields(),
              Divider(height: 15, color: Colors.black),
              const _SeparatorFields(),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: ActionButtonCustom(action: () => model.completeStepOne(), label: 'Siguiente'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FileField extends ViewModelWidget<ContractsRegisterViewModel> {
  const _FileField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ContractsRegisterViewModel model) {
    return Column(
      children: <Widget>[
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0, bottom: 15.0),
              child: Text('Adjunte el archivo', style: TextStyle(fontWeight: FontWeight.bold)),
            )),
        Container(
            height: 200.0,
            alignment: Alignment.center,
            child: model.pickedImage == null
                ? Text('Ningún archivo seleccionado')
                : Image.file(
                    model.pickedImage,
                    fit: BoxFit.contain,
                  )),
        RaisedButton(
          color: PalleteColor.actionButtonColor,
          onPressed: () => model.getFile(),
          child: Icon(Icons.file_upload, color: Colors.white),
        ),
        if (model.errorTextImage != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(model.errorTextImage, style: TextStyle(color: Colors.redAccent, fontSize: 12)),
          ),
      ],
    );
  }
}

class _TitleStep extends StatelessWidget {
  const _TitleStep({
    Key key,
    @required this.title,
  })  : assert(title != null),
        super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(this.title,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          )),
    );
  }
}

class _StepsRegister extends ViewModelWidget<ContractsRegisterViewModel> {
  const _StepsRegister({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ContractsRegisterViewModel model) {
    return Container(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Positioned(top: 25.0, child: Container(height: 2.0, width: MediaQuery.of(context).size.width * 0.5, color: Colors.grey)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    color: Colors.grey[100],
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CircleAvatar(
                        radius: 20.0,
                        child: model.currentIndex >= 1
                            ? Icon(Icons.check, color: Colors.white)
                            : Text('1', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
                        backgroundColor: PalleteColor.actionButtonColor,
                      ),
                    ),
                  ),
                  Text(
                    'Cargar\nContrato',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(color: Colors.black, fontSize: 10.0),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    color: Colors.grey[100],
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CircleAvatar(
                        radius: 20.0,
                        child: model.currentIndex >= 2
                            ? Icon(Icons.check, color: Colors.white)
                            : Text('2', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
                        backgroundColor: PalleteColor.actionButtonColor,
                      ),
                    ),
                  ),
                  Text(
                    'Revisar\nMuestras',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(color: Colors.black, fontSize: 10.0),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    color: Colors.grey[100],
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CircleAvatar(
                        radius: 20.0,
                        child: model.currentIndex > 2
                            ? Icon(Icons.check, color: Colors.white)
                            : Text('3', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
                        backgroundColor: PalleteColor.actionButtonColor,
                      ),
                    ),
                  ),
                  Text(
                    'Iniciar\nProceso',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(color: Colors.black, fontSize: 10.0),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
