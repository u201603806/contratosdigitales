import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:digitalcontractsapp/ui/views/user_profile.dart/user_profile_viewmodel.dart';
import 'package:digitalcontractsapp/ui/widgets/buttons/action_button_custom.dart';
import 'package:digitalcontractsapp/ui/widgets/buttons/outline_button_custom.dart';
import 'package:digitalcontractsapp/utils/network_image.dart';
import 'package:stacked/stacked.dart';

class UserProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserProfileViewModel>.reactive(
      viewModelBuilder: () => UserProfileViewModel(),
      onModelReady: (model) => model.initialize(context),
      builder: (context, model, child) => Scaffold(
        extendBody: true,
          body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          ClipPath(
            child: Container(color: Colors.black.withOpacity(0.8)),
            clipper: GetClipper(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () => model.openDrawer(),
            ),
          ),
          Positioned(
              width: 350.0,
              top: MediaQuery.of(context).size.height / 8,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 130,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [Colors.white, Colors.black])),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 60,
                      child: ClipOval(
                        child: SizedBox(
                          height: 200,
                          child: PNetworkImage(
                            model.user.image.isEmpty ? 'https://cdn.onlinewebfonts.com/svg/img_568657.png' : model.user.image,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50.0),
                  Text(
                    model.user.name,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    )),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _TitleText(text: 'Usuario:'),
                            const SizedBox(height: 15),
                            _TitleText(text: 'Telefono:'),
                            const SizedBox(height: 15),
                            _TitleText(text: 'Documento:'),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _DescriptionText(text: model.user.email),
                            const SizedBox(height: 15),
                            _DescriptionText(text: model.user.phone),
                            const SizedBox(height: 15),
                            _DescriptionText(text: model.user.documentNumber),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        ActionButtonCustom(label: 'Actualizar datos', action: () => model.showUpdateUserPopup()),
                        const SizedBox(height: 25.0),
                        OutlineButtonCustom(label: 'Cerrar Sesión', labelColor: Color(0xff1357BD), action: () => model.logout()),
                      ],
                    ),
                  ),
                ],
              ))
        ],
      )),
    );
  }
}

class _TitleText extends StatelessWidget {
  const _TitleText({Key key, @required this.text})
      : assert(text != null),
        super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      this.text,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 14.0,
      )),
    );
  }
}

class _DescriptionText extends StatelessWidget {
  const _DescriptionText({
    Key key,
    @required this.text,
  })  : assert(text != null),
        super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      this.text,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
        color: Colors.black,
        fontSize: 14.0,
      )),
    );
  }
}

class GetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
