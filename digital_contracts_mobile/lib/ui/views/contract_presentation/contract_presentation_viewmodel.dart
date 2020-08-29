import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:stacked/stacked.dart';

class ContractPresentationViewModel extends BaseViewModel {
  final _pdfController = PdfController(document: PdfDocument.openAsset('assets/contracts/contrato_img.pdf'));

  // * Getters
  get pdfController => _pdfController;

  // * Functions

}
