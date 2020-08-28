import 'package:flutter/material.dart';
import 'package:digitalcontractsapp/res/theme.dart' as Theme;

typedef void OnListSelect(String item);

class Alert {
  final BuildContext context;
  final String title;
  final String label;
  final String hint;
  final TextEditingController value;
  final VoidCallback action;
  final OnListSelect listSelect;
  Alert({this.context, this.listSelect, this.title, this.label, this.hint, this.value, this.action});

  void input() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
          title: Text(title, style: TextStyle(color: Theme.Colors.primaryColor)),
          content: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                    keyboardType: TextInputType.phone,
                    controller: value,
                    maxLength: 6,
                    autofocus: true,
                    decoration: InputDecoration(labelText: label, hintText: hint)),
              )
            ],
          ),
          actions: <Widget>[
            Center(
                child: FlatButton(
                    child: Text('Aceptar', style: TextStyle(color: Theme.Colors.primaryColor, fontWeight: FontWeight.bold)),
                    onPressed: action)),
          ],
        );
      },
    );
  }

  void loading(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
            content: Row(mainAxisSize: MainAxisSize.min, children: [
              SizedBox(
                child: CircularProgressIndicator(strokeWidth: 2.0),
                height: 18.0,
                width: 18.0,
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(message),
                ),
              )
            ]));
      },
    );
  }

  void error() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
            title: Center(child: Text(title, style: TextStyle(color: Theme.Colors.primaryColor, fontWeight: FontWeight.bold))),
            content: Text(
              label,
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              Center(
                child: FlatButton(
                    child: Text('Aceptar', style: TextStyle(color: Theme.Colors.primaryColor, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ),
            ]);
      },
    );
  }

  void errorCallBack(VoidCallback action) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
            title: Center(child: Text(title, style: TextStyle(color: Theme.Colors.primaryColor, fontWeight: FontWeight.bold))),
            content: Text(
              label,
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              Center(
                child: FlatButton(
                    child: Text('Aceptar', style: TextStyle(color: Theme.Colors.primaryColor, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.of(context).pop();
                      action();
                    }),
              )
            ]);
      },
    );
  }

  void logout(VoidCallback action) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
            title: Center(child: Text(title, style: TextStyle(color: Theme.Colors.primaryColor, fontSize: 18.0, fontWeight: FontWeight.bold))),
            content: Text(
              label,
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text('Cancelar', style: TextStyle(color: Theme.Colors.primaryColor)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              FlatButton(
                  child: Text('Aceptar', style: TextStyle(color: Theme.Colors.primaryColor)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    action();
                  })
            ]);
      },
    );
  }

  void errorNextDocument(action) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
            title: Text(title, style: TextStyle(color: Theme.Colors.primaryColor)),
            content: Text(
              label,
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              FlatButton(child: Text('Aceptar', style: TextStyle(color: Theme.Colors.primaryColor)), onPressed: action),
            ]);
      },
    );
  }

  void confirmation(String cancel, String actionText) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
          title: Text(title, style: TextStyle(color: Theme.Colors.primaryColor)),
          content: Text(
            label,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            FlatButton(
                child: Text(cancel),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            FlatButton(child: Text(actionText), onPressed: action)
          ],
        );
      },
    );
  }

  void list(List<dynamic> values, TextEditingController p) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
          title: Text(title, style: TextStyle(color: Theme.Colors.primaryColor)),
          content: ListView.builder(
              shrinkWrap: true,
              itemCount: values.length,
              itemBuilder: (BuildContext buildContext, int index) {
                return GestureDetector(
                  child: Padding(padding: EdgeInsets.all(10.0), child: Text(values[index])),
                  onTap: () {
                    listSelect(values[index]);
                  },
                );
              }),
        );
      },
    );
  }

  void errorWithoutDismissible() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
              title: Center(child: Text(title, style: TextStyle(color: Theme.Colors.primaryColor, fontWeight: FontWeight.bold))),
              content: Text(
                label,
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                Center(
                  child: FlatButton(
                    child: Text('Aceptar', style: TextStyle(color: Theme.Colors.primaryColor, fontWeight: FontWeight.bold)),
                    onPressed: action,
                  ),
                ),
              ]),
        );
      },
    );
  }

  Future<bool> confirmAlert(BuildContext _, String title, String label) {
    return showDialog(
          context: _,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
            title: Text(
              title,
              style: TextStyle(color: Colors.blue),
            ),
            content: Text(label, style: TextStyle(color: Colors.black)),
            actions: <Widget>[
              InkWell(
                onTap: () => Navigator.of(context).pop(false),
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Text('No', style: TextStyle(color: Colors.blue)),
                ),
              ),
              SizedBox(height: 16),
              InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () async {
                  Navigator.of(context).pop(true);
                },
                child: Container(padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), child: Text('Sí', style: TextStyle(color: Colors.blue))),
              ),
            ],
          ),
        ) ??
        false;
  }
}
