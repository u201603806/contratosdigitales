import 'package:digitalcontractsapp/app/locator.dart';
import 'package:digitalcontractsapp/app/router.gr.dart';
import 'package:digitalcontractsapp/data_models/shipment.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:digitalcontractsapp/services/api.dart';

class ConsultingContractsViewModel extends FutureViewModel<List<Shipment>> {
  final Api _api = locator<Api>();
  final NavigationService _navigationService = locator<NavigationService>();

  // * Functions

  void goToConsultingContracts(String idShipment) {
    _navigationService.navigateTo(Routes.colaboratorsContractViewRoute, arguments: ColaboratorsContractViewArguments(idShipment: idShipment));
  }

  @override
  Future<List<Shipment>> futureToRun() => getShipments();

  Future<List<Shipment>> getShipments() async {
    var shipmentsResponse = await _api.getShipments();
    List<Shipment> shipments = new List();
    shipmentsResponse.forEach((shipment) {
      shipments.add(Shipment.fromJson(shipment));
    });
    return shipments;
  }
}
