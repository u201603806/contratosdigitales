import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:digitalcontractsapp/res/pallete_color.dart';
import 'package:digitalcontractsapp/ui/views/consulting_contracts/consulting_contracts_viewmodel.dart';

class ConsultingContractsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ConsultingContractsViewModel>.reactive(
      viewModelBuilder: () => ConsultingContractsViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Envio de Contratos', style: TextStyle(color: PalleteColor.titleTextColor, fontWeight: FontWeight.bold, fontSize: 20)),
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
                : model.hasError
                    ? Text('${model.modelError}')
                    : Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: model.data
                            .map((e) => _ShipmentContractCard(
                                  fechaRegistro: e.fechaRegistro,
                                  amountColaborators: e.cantidad,
                                  idShipment: '${e.idEnvio}',
                                ))
                            .toList(),
                      )),
      ),
    );
  }
}

class _ShipmentContractCard extends ViewModelWidget<ConsultingContractsViewModel> {
  const _ShipmentContractCard({
    Key key,
    this.fechaRegistro,
    this.idShipment,
    this.amountColaborators,
  }) : super(key: key);
  final String fechaRegistro;
  final String idShipment;
  final int amountColaborators;

  @override
  Widget build(BuildContext context, ConsultingContractsViewModel model) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          boxShadow: [BoxShadow(blurRadius: 5.0, color: Colors.black26, offset: Offset(4.0, 6.0), spreadRadius: 2.0)]),
      child: ListTile(
        title: Text('Fecha Registro: $fechaRegistro'),
        subtitle: Text('Cantidad de contratado: $amountColaborators'),
        trailing: Icon(Icons.work),
        focusColor: Colors.red,
        onTap: () => model.goToConsultingContracts(idShipment),
      ),
    );
  }
}
