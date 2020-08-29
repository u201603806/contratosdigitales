import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:digitalcontractsapp/res/pallete_color.dart';
import 'package:stacked/stacked.dart';

import 'notifications_viewmodel.dart';

class NotificationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationsViewModel>.nonReactive(
      viewModelBuilder: () => NotificationsViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            '',
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
              color: PalleteColor.titleTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            )),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: PalleteColor.titleTextColor,
            ),
            onPressed: () => model.openDrawer(),
          ),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            const SizedBox(height: 20.0),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: SvgPicture.asset(
                'assets/home/unavailable_offers.svg',
                width: MediaQuery.of(context).size.width * 0.9,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
              child: Text(
                'No se encontraron nuevas notificaciones', textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                )),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
