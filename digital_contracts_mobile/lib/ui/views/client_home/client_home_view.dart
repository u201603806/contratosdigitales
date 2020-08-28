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
              body: Center(child: Container(child: Text('No hay procesos de contratos en curso.'),)),
              floatingActionButton: FloatingActionButton(
                onPressed: () => model.goToRegisterBusinessForm(),
                backgroundColor: PalleteColor.actionButtonColor,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
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
