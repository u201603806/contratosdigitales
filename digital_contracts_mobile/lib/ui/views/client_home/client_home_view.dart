import 'package:digitalcontractsapp/ui/widgets/buttons/action_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:digitalcontractsapp/data_models/business.dart';
import 'package:digitalcontractsapp/res/pallete_color.dart';
import 'package:stacked/stacked.dart';

import 'client_home_viewmodel.dart';

class ClientHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ClientHomeViewModel>.nonReactive(
        viewModelBuilder: () => ClientHomeViewModel(),
        builder: (_, model, child) => Scaffold(
              appBar: AppBar(
                title: Text('Empresa', style: TextStyle(color: PalleteColor.titleTextColor, fontWeight: FontWeight.bold, fontSize: 20)),
                backgroundColor: Colors.white,
                brightness: Brightness.light,
                iconTheme: IconThemeData(color: PalleteColor.titleTextColor),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () => model.openDrawer(),
                ),
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
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(20.0),
                          child: ActionButtonCustom(action: () => model.goToRegisterBusinessForm(), label: 'Proceso de envio')),
                      Container(padding: const EdgeInsets.all(20.0), child: ActionButtonCustom(action: () {}, label: 'Seguimiento')),
                      Container(padding: const EdgeInsets.all(20.0), child: ActionButtonCustom(action: () {}, label: 'Consultas')),
                    ],
                  )),
            ));
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
