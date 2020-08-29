import 'package:flutter/material.dart';
import 'package:digitalcontractsapp/data_models/enums/user_type.dart';
import 'package:digitalcontractsapp/res/pallete_color.dart';
import 'package:digitalcontractsapp/services/api.dart';
import 'package:digitalcontractsapp/ui/widgets/alerts/alerts.dart';
import 'package:digitalcontractsapp/ui/widgets/buttons/action_button_custom.dart';
import 'package:digitalcontractsapp/ui/widgets/text_fields/text_field_custom.dart';

class ServiceRegister extends StatefulWidget {
  @override
  _ServiceRegisterState createState() => _ServiceRegisterState();
}

class _ServiceRegisterState extends State<ServiceRegister> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _id = new TextEditingController();
  final TextEditingController _name = new TextEditingController();
  final TextEditingController _description = new TextEditingController();
  final TextEditingController _cost = new TextEditingController();
  final TextEditingController _time = new TextEditingController();
  final TextEditingController _stock = new TextEditingController();
  final FocusNode _focusName = FocusNode();
  final FocusNode _focusDescription = FocusNode();
  final FocusNode _focusCost = FocusNode();

  UserType typeRegisterSelect = UserType.User;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _id.dispose();
    _name.dispose();
    _description.dispose();
    _cost.dispose();
    _time.dispose();
    _stock.dispose();
    _focusName.dispose();
    _focusDescription.dispose();
    super.dispose();
  }

  void setTypeRegister(UserType typeLogin) {
    setState(() {
      _formKey.currentState.reset();
      typeRegisterSelect = typeLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          _TopPresentation(),
          Expanded(
            child: Container(
              color: PalleteColor.backgroundColor,
              child: Container(
                padding: EdgeInsets.only(top: 10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    )),
                child: Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: SingleChildScrollView(
                            child: buildServiceForm(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column buildServiceForm() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: TextFieldCustom(
            controller: _id,
            name: 'Id Empresa',
            nextFocus: _focusName,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: TextFieldCustom(
            controller: _name,
            name: 'Nombre Servicio',
            focus: _focusName,
            nextFocus: _focusDescription,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: TextFieldCustom(
            controller: _description,
            name: 'Descripcion',
            focus: _focusDescription,
            nextFocus: _focusCost,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: TextFieldCustom(
            controller: _cost,
            name: 'Costo',
            focus: _focusCost,
            nextFocus: new FocusNode(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: TextFieldCustom(
            controller: _time,
            name: 'Tiempo',
            nextFocus: new FocusNode(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: TextFieldCustom(
            controller: _stock,
            name: 'Cupos',
            nextFocus: new FocusNode(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          child: ActionButtonCustom(
            action: () => _registerRubro(),
            label: 'Registrarse',
          ),
        ),
      ],
    );
  }

  void _registerRubro() async {
    if (_formKey.currentState.validate()){}
     
  }
}

class _TopPresentation extends StatelessWidget {
  const _TopPresentation({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: PalleteColor.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, right: 10.0),
                  child: Text(
                    'Servicio',
                    style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0, top: 15.0, bottom: 15.0),
                  child: Text(
                    'Llene el formulario para poder registrar un servicio',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
