import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:digitalcontractsapp/ui/widgets/text_fields/text_field_custom.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import 'user_update_information_popup_viewmodel.dart';

class UserUpdateInformationPopupView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserUpdateInformationPopupViewState();
}

class UserUpdateInformationPopupViewState extends State<UserUpdateInformationPopupView> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserUpdateInformationPopupViewModel>.reactive(
      viewModelBuilder: () => UserUpdateInformationPopupViewModel(),
      onModelReady: (model) => model.initialize(),
      builder: (context, model, child) => ScaleTransition(
        scale: scaleAnimation,
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: ShapeDecoration(color: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))),
                child: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              alignment: Alignment.center,
                              child: NotificationListener<OverscrollIndicatorNotification>(
                                  onNotification: (OverscrollIndicatorNotification overscroll) {
                                    overscroll.disallowGlow();
                                    return;
                                  },
                                  child: SingleChildScrollView(
                                    child: _FormUserUpdate(),
                                  )),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: new RaisedButton(
                            onPressed: () => model.updateUserInformation(context),
                            color: Color(0xff5C93FF),
                            child: new Text('Actualizar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.only(bottomRight: Radius.circular(15.0), bottomLeft: Radius.circular(15.0))),
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      right: 10.0,
                      top: 10.0,
                      child: InkResponse(
                        onTap: () => model.closePopup(context),
                        child: Image.asset('assets/home/close.png', color: Color(0xff5C93FF), height: 30.0, fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FormUserUpdate extends HookViewModelWidget<UserUpdateInformationPopupViewModel> {
  _FormUserUpdate({
    Key key,
  }) : super(key: key, reactive: false);

  @override
  Widget buildViewModelWidget(BuildContext context, UserUpdateInformationPopupViewModel model) {
    final TextEditingController nameController = useTextEditingController();
    nameController.text = model.name;
    final TextEditingController phoneController = useTextEditingController();
    phoneController.text = model.phone;
    final TextEditingController documentNumberController = useTextEditingController();
    documentNumberController.text = model.documentNumber;
    final FocusNode phoneFocus = useFocusNode();
    final FocusNode documentNumberFocus = useFocusNode();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        TextFieldCustom(
          name: 'Nombre',
          theme: TextFormTheme.Dark,
          controller: nameController,
          nextFocus: phoneFocus,
          onChanged: model.updateName,
        ),
        const SizedBox(height: 10.0),
        TextFieldCustom(
          name: 'Telefono',
          controller: phoneController,
          focus: phoneFocus,
          nextFocus: documentNumberFocus,
          keyboardType: TextInputType.phone,
          theme: TextFormTheme.Dark,
          onChanged: model.updatePhone,
        ),
        const SizedBox(height: 10.0),
        TextFieldCustom(
          name: 'Número de Documento',
          controller: documentNumberController,
          focus: documentNumberFocus,
          theme: TextFormTheme.Dark,
          onChanged: model.updateDocumentNumber,
        ),
      ],
    );
  }
}
