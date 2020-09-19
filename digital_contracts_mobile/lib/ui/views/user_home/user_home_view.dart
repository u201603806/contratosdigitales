import 'package:digitalcontractsapp/res/pallete_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:digitalcontractsapp/data_models/business.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import 'user_home_viewmodel.dart';

class UserHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserHomeViewModel>.nonReactive(
        viewModelBuilder: () => UserHomeViewModel(),
        builder: (_, model, child) => Scaffold(
              appBar: PreferredSize(
                preferredSize: Size(double.infinity, 70.0),
                child: _SeachAppBar(),
              ),
              backgroundColor: Color(0xffFCFCFC),
              body: _ContractsBody(),
            ));
  }
}

class _ContractsBody extends ViewModelWidget<UserHomeViewModel> {
  const _ContractsBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, UserHomeViewModel model) {
    return model.isBusy
        ? Container(child: Center(child: CircularProgressIndicator()))
        : model.errorFetchingRubros
            ? Center(child: Text(''))
            : RefreshIndicator(
                onRefresh: () {
                  return Future.value();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: model.isSearching
                      ? Column(
                          children: <Widget>[
                            _ContractsBuilder(contracts: model.contractsFound),
                          ],
                        )
                      : _ContractsFound(),
                ),
              );
  }
}

class _ContractsFound extends ViewModelWidget<UserHomeViewModel> {
  const _ContractsFound({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, UserHomeViewModel model) {
    return model.fetchingBusiness
        ? Container(height: MediaQuery.of(context).size.height * 0.5, child: Center(child: CircularProgressIndicator()))
        : model.errorFetchingBusiness
            ? Center(child: Text('No se logró obtener información de contratos'))
            : model.contracts.isEmpty ? _ContractsBuilder(contracts: model.contracts) : _SectionHeader(title: "0 Contratos");
  }
}

class _ContractsBuilder extends ViewModelWidget<UserHomeViewModel> {
  const _ContractsBuilder({
    Key key,
    @required this.contracts,
  })  : assert(contracts != null),
        super(key: key);
  final List<Business> contracts;

  @override
  Widget build(BuildContext context, UserHomeViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _SectionHeader(title: "${1} Contrato${this.contracts.length > 1 ? 's' : ''}"),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              width: 400,
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => model.goToContractView(),
                                          child: Card(
                        elevation: 10.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.chrome_reader_mode, color: PalleteColor.actionButtonColor),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('LAC', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                  Text('Contrato de Tiempo Completo'),
                                  Text('Fecha de validez: 28.08 - 10.09'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        margin: const EdgeInsets.all(5.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0), side: BorderSide(color: PalleteColor.informationActionColor, width: 1.0, style: BorderStyle.solid)),
                      ),
                    );
                  }),
            ),
          ),
        )
      ],
    );
  }
}

class _SeachAppBar extends HookViewModelWidget<UserHomeViewModel> {
  _SeachAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget buildViewModelWidget(BuildContext context, UserHomeViewModel model) {
    var searchController = useTextEditingController();
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      flexibleSpace: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          elevation: 10.0,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              TextField(
                controller: searchController,
                onSubmitted: (business) {
                  model.searchBusiness(business);
                  FocusScope.of(context).unfocus();
                },
                autofocus: false,
                textAlignVertical: TextAlignVertical.bottom,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0), borderSide: BorderSide(color: Colors.grey, width: 0.1)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0), borderSide: BorderSide(color: Colors.grey, width: 0.1)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0), borderSide: BorderSide(color: Colors.grey, width: 0.1)),
                  hintText: "Buscar",
                  hintStyle: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                  )),
                  prefixIcon: Icon(Icons.menu, color: Colors.transparent),
                  alignLabelWithHint: true,
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      if (model.isSearching)
                        GestureDetector(
                          onTap: () {
                            model.closeSearch(searchController.text);
                            searchController.clear();
                            Future.delayed(Duration(milliseconds: 200)).then((value) => FocusScope.of(context).unfocus());
                          },
                          child: Icon(Icons.close),
                        ),
                      IconButton(
                        onPressed: () {
                          model.searchBusiness(searchController.text);
                          FocusScope.of(context).unfocus();
                        },
                        icon: Icon(Icons.search),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: new Icon(Icons.menu),
                onPressed: () => model.openDrawer(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    Key key,
    @required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, top: 10.0),
      child: Text(
        title,
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        )),
      ),
    );
  }
}
