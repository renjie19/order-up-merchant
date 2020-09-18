import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get_it/get_it.dart';
import 'package:order_up_merchant/pages/sign_up.dart';
import 'package:order_up_merchant/services/auth/auth_service.dart';
import 'package:order_up_merchant/services/auth/fire_base_auth.dart';

class Login extends StatelessWidget {
  final GlobalKey<FormBuilderState> _loginFormKey =
      GlobalKey<FormBuilderState>();
  final AuthService _authService = GetIt.I<FireBaseAuth>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
        body: Center(
          child: SingleChildScrollView(
            child: FormBuilder(
              key: _loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 100,
                  ),
                  Card(
                    margin: EdgeInsets.all(15),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      child: Column(
                        children: [
                          FormBuilderTextField(
                            attribute: 'email',
                            initialValue: '',
                            keyboardType: TextInputType.emailAddress,
                            validators: [
                              FormBuilderValidators.required(),
                              FormBuilderValidators.email()
                            ],
                            decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(FontAwesome.envelope)),
                          ),
                          FormBuilderTextField(
                            attribute: 'password',
                            initialValue: '',
                            obscureText: true,
                            validators: [
                              FormBuilderValidators.required(),
                            ],
                            decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: Icon(FontAwesome.lock)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  MaterialButton(
                    child: Text('LOGIN'),
                    color: Colors.red[700],
                    onPressed: () => _loginUser(),
                  ),
                  MaterialButton(
                    child: Text('REGISTER'),
                    onPressed: () {
                      _loadSignUpPage(context);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _loginUser() async {
    try {
      if (_loginFormKey.currentState.saveAndValidate()) {
        BotToast.showLoading();
        var values = _loginFormKey.currentState.value;
        await _authService.signIn(values['email'], values['password']);
        BotToast.closeAllLoading();
      }
    } on PlatformException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showSimpleNotification(title: e.message, backgroundColor: Colors.red);
    }
  }

  void _loadSignUpPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUp()),
    );
  }
}
