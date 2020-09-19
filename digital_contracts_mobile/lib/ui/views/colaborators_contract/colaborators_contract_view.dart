import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:digitalcontractsapp/res/pallete_color.dart';
import 'package:digitalcontractsapp/ui/views/colaborators_contract/colaborators_contract_viewmodel.dart';

class ColaboratorsContractView extends StatelessWidget {
  final String idShipment;
  const ColaboratorsContractView({
    Key key,
    this.idShipment,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ColaboratorsContractViewModel>.reactive(
      viewModelBuilder: () => ColaboratorsContractViewModel(idShipment),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Contratos', style: TextStyle(color: PalleteColor.titleTextColor, fontWeight: FontWeight.bold, fontSize: 20)),
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: PalleteColor.titleTextColor),
          centerTitle: true,
        ),
        backgroundColor: Color(0xffFCFCFC),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/home/background_home.jpg"),
                fit: MediaQuery.of(context).viewInsets.bottom > 0
                    ? BoxFit.cover
                    : MediaQuery.of(context).orientation == Orientation.portrait ? BoxFit.fitHeight : BoxFit.fitHeight,
              ),
            ),
            child: model.isBusy
                ? Center(child: CircularProgressIndicator())
                : Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: model.data
                        .map((e) => _ShipmentContractCard(
                              position: e.cargo,
                              dni: e.dni,
                              salary: e.sueldo,
                            ))
                        .toList(),
                  )),
      ),
    );
  }
}

class _ShipmentContractCard extends StatelessWidget {
  const _ShipmentContractCard({
    Key key,
    this.position,
    this.salary,
    this.dni,
  }) : super(key: key);
  final String position;
  final double salary;
  final String dni;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          boxShadow: [BoxShadow(blurRadius: 5.0, color: Colors.black26, offset: Offset(4.0, 6.0), spreadRadius: 2.0)]),
      child: ListTile(
        title: Text('Cargo: $position'),
        subtitle: Text('Salary: $salary\nDNI: $dni'),
        trailing: Icon(Icons.work),
      ),
    );
  }
}
