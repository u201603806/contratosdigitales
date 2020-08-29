import 'package:digitalcontractsapp/res/pallete_color.dart';
import 'package:digitalcontractsapp/ui/views/contract_presentation/contract_presentation_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:stacked/stacked.dart';

class ContractPresentationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ContractPresentationViewModel>.nonReactive(
      viewModelBuilder: () => ContractPresentationViewModel(),
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            brightness: Brightness.dark,
            iconTheme: IconThemeData(color: PalleteColor.actionButtonColor),
            title: Text('Contrato', style: TextStyle(color: PalleteColor.titleTextColor)),
          ),
          body: Center(
              child: PdfView(
            controller: model.pdfController,
          ))),
    );
  }
}
