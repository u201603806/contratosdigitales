import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:digitalcontractsapp/data_models/enums/user_type.dart';
import 'package:digitalcontractsapp/res/pallete_color.dart';
import 'package:digitalcontractsapp/ui/views/login/login_viewmodel.dart';
import 'package:digitalcontractsapp/ui/widgets/buttons/action_button_custom.dart';
import 'package:digitalcontractsapp/ui/widgets/buttons/google_button.dart';
import 'package:digitalcontractsapp/ui/widgets/buttons/outline_button_custom.dart';
import 'package:digitalcontractsapp/ui/widgets/text_fields/text_field_custom.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.nonReactive(
      viewModelBuilder: () => LoginViewModel(),
      onModelReady: (model) => model.initialize(context),
      builder: (_, model, child) => Scaffold(
        backgroundColor: PalleteColor.backgroundColor,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/home/login_background.png"),
              fit: MediaQuery.of(context).viewInsets.bottom > 0
                  ? BoxFit.cover
                  : MediaQuery.of(context).orientation == Orientation.portrait ? BoxFit.fitHeight : BoxFit.fitWidth,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: model.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _WelcomeLabel(),
                    _IntroductionText(),
                    const SizedBox(height: 20.0),
                    _UserTypeButtons(),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    _LoginForm(),
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

class _LoginForm extends HookViewModelWidget<LoginViewModel> {
  _LoginForm({
    Key key,
  }) : super(key: key, reactive: false);

  @override
  Widget buildViewModelWidget(BuildContext context, LoginViewModel model) {
    var emailController = useTextEditingController();
    var passwordController = useTextEditingController();
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFieldCustom(
              controller: emailController,
              name: 'Email',
              nextFocus: model.focusPassword,
              keyboardType: TextInputType.emailAddress,
              onChanged: model.updateEmail,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: TextFieldCustom(
              controller: passwordController,
              name: 'Password',
              focus: model.focusPassword,
              onChanged: model.updatePassword,
              isPassword: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
            child: ActionButtonCustom(
              action: () => model.loginValidate(context),
              label: 'Iniciar Sesión',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GoogleButton(action: () {}),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () => model.goToEnroll(context),
                child: Text(
                  'Registrarse Ahora',
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
          )
        ],
      ),
    );
  }
}

class _UserTypeButtons extends ViewModelWidget<LoginViewModel> {
  const _UserTypeButtons({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, LoginViewModel model) {
    return Row(
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
    );
  }
}

class _IntroductionText extends ViewModelWidget<LoginViewModel> {
  const _IntroductionText({
    Key key,
  }) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, LoginViewModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Text(
        'Inicia sesión para continuar con Digital Contracts',
        style: GoogleFonts.allerta(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
    );
  }
}

class _WelcomeLabel extends ViewModelWidget<LoginViewModel> {
  const _WelcomeLabel({
    Key key,
  }) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, LoginViewModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Text(
        'Bienvenido',
        style: GoogleFonts.rammettoOne(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 36.0,
        ),
      ),
    );
  }
}