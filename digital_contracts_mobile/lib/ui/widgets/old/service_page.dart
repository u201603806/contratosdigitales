import 'package:flutter/material.dart';
import 'package:digitalcontractsapp/ui/widgets/old/service_register.dart';

class Services extends StatefulWidget {
  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClientOption(
              title: 'Servicio',
              description: 'Puede registar sus servicios',
              icon: Icon(
                Icons.room_service,
                color: Colors.white,
                size: 40.0,
              ),
              action: () => goTo(ServiceRegister()),
            ),
            ClientOption(
              title: 'Rubro',
              description: 'Puede registar su rubro',
              icon: Icon(
                Icons.store,
                color: Colors.white,
                size: 40.0,
              ),
              action: () {},
            )
          ],
        ),
      ),
    );
  }

  void goTo(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}

class ClientOption extends StatelessWidget {
  const ClientOption({
    Key key,
    @required this.title,
    @required this.description,
    @required this.icon,
    @required this.action,
  }) : super(key: key);

  final String title;
  final String description;
  final Widget icon;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          boxShadow: [
            BoxShadow(
              blurRadius: 5.0,
              color: Colors.black26,
              offset: Offset(
                4.0,
                6.0,
              ),
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: ListTile(
          onTap: action,
          title: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            description,
            style: TextStyle(color: Colors.white),
          ),
          leading: icon,
        ),
      ),
    );
  }
}
