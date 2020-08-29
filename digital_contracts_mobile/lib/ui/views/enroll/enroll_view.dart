import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:digitalcontractsapp/data_models/enums/user_type.dart';
import 'package:digitalcontractsapp/ui/views/enroll/enroll_viewmodel.dart';
import 'package:digitalcontractsapp/ui/widgets/buttons/action_button_custom.dart';
import 'package:digitalcontractsapp/ui/widgets/buttons/google_button.dart';
import 'package:digitalcontractsapp/ui/widgets/buttons/outline_button_custom.dart';
import 'package:digitalcontractsapp/ui/widgets/text_fields/text_field_custom.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class EnrollView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EnrollViewModel>.reactive(
      viewModelBuilder: () => EnrollViewModel(),
      builder: (_, model, child) => Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/home/login_background.png"),
              fit: MediaQuery.of(context).viewInsets.bottom > 0 ? BoxFit.cover : MediaQuery.of(context).orientation == Orientation.portrait ? BoxFit.fitHeight : BoxFit.fitWidth,
            ),
          ),
          child: Form(
            key: model.formKey,
            child: Center(
              child: Column(
                children: <Widget>[
                  _TopPresentation(),
                  _UserTypeButtons(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: model.userTypeSelected == UserType.User ? _UserForm() : _ClientForm(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _UserTypeButtons extends ViewModelWidget<EnrollViewModel> {
  const _UserTypeButtons({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, EnrollViewModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 10.0),
              child: model.userTypeSelected == UserType.User
                  ? ActionButtonCustom(
                      action: () {},
                      label: 'Usuario',
                    )
                  : OutlineButtonCustom(
                      action: () => model.setUserType(UserType.User),
                      label: 'Usuario',
                    ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: model.userTypeSelected == UserType.Business
                  ? ActionButtonCustom(
                      action: () {},
                      label: 'Empresa',
                    )
                  : OutlineButtonCustom(
                      action: () => model.setUserType(UserType.Business),
                      label: 'Empresa',
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UserForm extends HookViewModelWidget<EnrollViewModel> {
  _UserForm({
    Key key,
  }) : super(key: key, reactive: false);

  @override
  Widget buildViewModelWidget(BuildContext context, EnrollViewModel model) {
    var emailController = useTextEditingController();
    var nameController = useTextEditingController();
    var phoneController = useTextEditingController();
    var passwordController = useTextEditingController();
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: TextFieldCustom(
            controller: emailController,
            name: 'Email',
            keyboardType: TextInputType.emailAddress,
            nextFocus: model.focusName,
            onChanged: model.updateEmail,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: TextFieldCustom(
              controller: nameController,
              name: 'Nombre',
              focus: model.focusName,
              nextFocus: model.focusPhone,
              onChanged: model.updateName,),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: TextFieldCustom(
            controller: phoneController,
            name: 'Phone',
            focus: model.focusPhone,
            keyboardType: TextInputType.phone,
            nextFocus: model.focusPassword,
            onChanged: model.updatePhone,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: TextFieldCustom(
              focus: model.focusPassword,
              name: 'Password',
              controller: passwordController,
              onChanged: model.updatePassword,
              isPassword: true,),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: ActionButtonCustom(
            action: () => model.registerAccount(context),
            label: 'Registrarse',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GoogleButton(action: model.signInGoogle),
        ),
        _LoginButton()
      ],
    );
  }
}

class _ClientForm extends HookViewModelWidget<EnrollViewModel> {
  _ClientForm({
    Key key,
  }) : super(key: key, reactive: false);

  @override
  Widget buildViewModelWidget(BuildContext context, EnrollViewModel model) {
    var emailController = useTextEditingController();
    var nameController = useTextEditingController();
    var passwordController = useTextEditingController();
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: TextFieldCustom(
              controller: emailController,
              name: 'Email',
              nextFocus: model.focusName,
              keyboardType: TextInputType.emailAddress,
              onChanged: model.updateEmail,),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: TextFieldCustom(
              controller: nameController,
              name: 'Nombre',
              focus: model.focusName,
              nextFocus: model.focusPassword,
              onChanged: model.updateName,),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: TextFieldCustom(
              focus: model.focusPassword,
              name: 'Password',
              controller: passwordController,
              onChanged: model.updatePassword,
              isPassword: true,),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: ActionButtonCustom(
            action: () => model.registerAccount(context),
            label: 'Registrarse',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GoogleButton(action: model.signInGoogle),
        ),
        _LoginButton()
      ],
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20.0,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
            Navigator.of(context).pop();
          },
          child: Text(
            'Iniciar Sesion',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              decoration: TextDecoration.underline,
              decorationThickness: 2.0,
            ),
          ),
        ),
      ),
    );
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
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 10.0),
            child: Text(
              'Bienvenido a Digital Contracts',
              style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0, top: 15.0, bottom: 15.0),
            child: Text(
              'Por favor, regístrate en nuestra aplicación para continuar',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
