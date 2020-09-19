import 'package:digitalcontractsapp/app/locator.dart';
import 'package:digitalcontractsapp/data_models/document_by_shipment.dart';
import 'package:digitalcontractsapp/services/api.dart';
import 'package:stacked/stacked.dart';

class ColaboratorsContractViewModel extends FutureViewModel<List<DocumentByShipment>> {
  final Api _api = locator<Api>();
  final _idShipment;

  ColaboratorsContractViewModel(this._idShipment);

  // * Functions
  @override
  Future<List<DocumentByShipment>> futureToRun() => getColaboratorByShipmentContract();

  Future<List<DocumentByShipment>> getColaboratorByShipmentContract() async {
    var documents = await _api.getDocumentsByShipment(_idShipment);
    List<DocumentByShipment> colaborators = new List();
    documents.forEach((colaborator) {
      colaborators.add(DocumentByShipment.fromJson(colaborator));
    });
    return colaborators;
  }
}
