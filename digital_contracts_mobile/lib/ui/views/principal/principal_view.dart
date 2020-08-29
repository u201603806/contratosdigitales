import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morpheus/widgets/morpheus_tab_view.dart';
import 'package:stacked/stacked.dart';

import 'package:digitalcontractsapp/data_models/user_login.dart';
import 'package:digitalcontractsapp/res/pallete_color.dart';
import 'package:digitalcontractsapp/ui/views/principal/principal_viewmodel.dart';
import 'package:digitalcontractsapp/utils/network_image.dart';

class PrincipalView extends StatefulWidget {
  final int currentIndex;
  final UserLogin userLogin;
  PrincipalView({
    Key key,
    this.currentIndex = 0,
    @required this.userLogin,
  }) : super(key: key);

  @override
  _PrincipalViewState createState() => _PrincipalViewState();
}

class _PrincipalViewState extends State<PrincipalView> with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  final Duration duration = const Duration(milliseconds: 400);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool _roundCornersForm = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double initial = 0;
    double distance = 0;
    return ViewModelBuilder<PrincipalViewModel>.reactive(
      viewModelBuilder: () => PrincipalViewModel(),
      onModelReady: (model) => model.initialize(context, widget.currentIndex, openMenuDrawer, widget.userLogin),
      builder: (_, model, child) => !model.isBusy
          ? Container(
              color: isCollapsed ? Colors.white : PalleteColor.backgroundMenuDrawerColor,
              child: SafeArea(
                child: GestureDetector(
                  onPanStart: (DragStartDetails details) {
                    initial = details.globalPosition.dx;
                  },
                  onPanUpdate: (DragUpdateDetails details) {
                    distance = details.globalPosition.dx - initial;
                  },
                  onPanEnd: (DragEndDetails details) {
                    initial = 0.0;
                    if (distance > 180 && isCollapsed) openMenuDrawer();
                    if (distance < -180 && !isCollapsed) openMenuDrawer();
                    debugPrint('$distance');
                  },
                  child: Scaffold(
                    backgroundColor: PalleteColor.backgroundMenuDrawerColor,
                    body: SafeArea(
                      child: Stack(
                        children: <Widget>[
                          _MenuDrawer(),
                          AnimatedContainer(
                            transform: Matrix4.translationValues(xOffset, yOffset, 0)..scale(scaleFactor),
                            duration: Duration(milliseconds: 250),
                            onEnd: () {
                              if (isCollapsed)
                                setState(() {
                                  _roundCornersForm = false;
                                });
                            },
                            child: ScaleTransition(
                              scale: _scaleAnimation,
                              alignment: Alignment.center,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(_roundCornersForm ? 40.0 : 0.0),
                                child: Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.only(top: _roundCornersForm ? 8.0 : 0.0),
                                  child: WillPopScope(
                                      onWillPop: () async {
                                        model.logout();
                                        return false;
                                      },
                                      child: Scaffold(
                                        appBar: PreferredSize(
                                            preferredSize: Size.fromHeight(0),
                                            child: AppBar(
                                              backgroundColor: Colors.black,
                                            )),
                                        body: _BodyPrincipal(),
                                        bottomNavigationBar: _BottomNavigationBar(),
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(0),
                  child: AppBar(
                    backgroundColor: Colors.black,
                  )),
              body: Center(child: CircularProgressIndicator())),
    );
  }

  void openMenuDrawer() {
    setState(() {
      if (isCollapsed) {
        xOffset = 300;
        _roundCornersForm = true;
        yOffset = 150;
        scaleFactor = 0.6;
        _controller.forward();
      } else {
        xOffset = 0;
        yOffset = 0;
        scaleFactor = 1;
        _controller.reverse();
      }

      isCollapsed = !isCollapsed;
    });
  }
}

class _MenuDrawer extends ViewModelWidget<PrincipalViewModel> {
  const _MenuDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, PrincipalViewModel model) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
          Color(0xff1357BD),
          Color(0x0f0B203A),
          PalleteColor.backgroundMenuDrawerColor,
        ]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(height: 50.0),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Mi cuenta", style: TextStyle(color: Colors.white, fontSize: 22)),
                              Icon(Icons.help_outline, color: Colors.white),
                            ],
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 40,
                                child: ClipOval(
                                  child: PNetworkImage(
                                    model.user.image.isEmpty ? 'https://cdn.onlinewebfonts.com/svg/img_568657.png' : model.user.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text('${model.user.name}',
                                    textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17.0)),
                                Text('${model.user.email}', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          _OptionMenuDrawer(
                            title: 'Principal',
                            onTap: () => model.updateCurrentIndex(0, closeHiddenDrawer: true),
                            iconURL: 'assets/home/home_icon.svg',
                          ),
                          const SizedBox(height: 10),
                          _OptionMenuDrawer(
                            title: 'Agenda',
                            onTap: () => model.updateCurrentIndex(1, closeHiddenDrawer: true),
                            iconURL: 'assets/home/reserve_schedule.svg',
                          ),
                          const SizedBox(height: 10),
                          _OptionMenuDrawer(
                            title: 'Notificaciones',
                            onTap: () => model.updateCurrentIndex(2, closeHiddenDrawer: true),
                            iconURL: 'assets/home/bell.svg',
                          ),
                          const SizedBox(height: 10),
                          _OptionMenuDrawer(
                            title: 'Perfil',
                            onTap: () => model.updateCurrentIndex(3, closeHiddenDrawer: true),
                            iconURL: 'assets/home/user_icon.svg',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => model.logout(),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.exit_to_app, color: Colors.white),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Salir', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OptionMenuDrawer extends StatelessWidget {
  const _OptionMenuDrawer({
    Key key,
    @required this.title,
    @required this.onTap,
    @required this.iconURL,
  })  : assert(title != null),
        assert(onTap != null),
        assert(iconURL != null),
        super(key: key);
  final String title;
  final VoidCallback onTap;
  final String iconURL;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkResponse(
        onTap: this.onTap,
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20.0,
              child: SvgPicture.asset(
                this.iconURL,
                height: 25.0,
                fit: BoxFit.cover,
                color: PalleteColor.backgroundMenuDrawerColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                this.title,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BodyPrincipal extends ViewModelWidget<PrincipalViewModel> {
  const _BodyPrincipal({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, PrincipalViewModel model) {
    return SafeArea(child: MorpheusTabView(child: model.tabWidgets[model.currentIndex]));
  }
}

class _BottomNavigationBar extends ViewModelWidget<PrincipalViewModel> {
  const _BottomNavigationBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, PrincipalViewModel model) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (index) => model.updateCurrentIndex(index),
      backgroundColor: Colors.white,
      fixedColor: Colors.white,
      currentIndex: model.currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/home/home_icon.svg',
            height: 25.0,
            fit: BoxFit.cover,
            color: model.getColorBottomButton(index: 0),
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text('Principal',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: model.getColorBottomButton(index: 0),
                )),
          ),
        ),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/home/reserve_schedule.svg',
              height: 25.0,
              fit: BoxFit.cover,
              color: model.getColorBottomButton(index: 1),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text('Agenda',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: model.getColorBottomButton(index: 1),
                  )),
            )),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/home/bell.svg',
            semanticsLabel: 'Password Logo',
            height: 25.0,
            fit: BoxFit.cover,
            color: model.getColorBottomButton(index: 2),
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: new Text('Notificaciones',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: model.getColorBottomButton(index: 2),
                )),
          ),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/home/user_icon.svg',
            semanticsLabel: 'Password Logo',
            height: 25.0,
            fit: BoxFit.cover,
            color: model.getColorBottomButton(index: 3),
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text('Perfil',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: model.getColorBottomButton(index: 3),
                )),
          ),
        ),
      ],
    );
  }
}
