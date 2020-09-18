import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:order_up_merchant/commons/models/account.dart';
import 'package:order_up_merchant/commons/utils/user_util.dart';
import 'package:order_up_merchant/services/account/account_service.dart';
import 'package:order_up_merchant/services/auth/auth_service.dart';
import 'package:order_up_merchant/services/auth/fire_base_auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormBuilderState> _signUpKey = GlobalKey<FormBuilderState>();
  final AccountService _accountService = GetIt.I<AccountService>();
  final AuthService _authService = GetIt.I<FireBaseAuth>();

  int _age;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: FormBuilder(
              key: _signUpKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      margin: EdgeInsets.all(15),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            FormBuilderTextField(
                              attribute: 'store',
                              validators: [FormBuilderValidators.required()],
                              decoration:
                                  InputDecoration(labelText: 'Store Name'),
                            ),
                            FormBuilderTextField(
                              attribute: 'firstName',
                              validators: [FormBuilderValidators.required()],
                              decoration:
                                  InputDecoration(labelText: 'First Name'),
                            ),
                            FormBuilderTextField(
                              attribute: 'lastName',
                              validators: [FormBuilderValidators.required()],
                              decoration:
                                  InputDecoration(labelText: 'Last Name'),
                            ),
                            FormBuilderDateTimePicker(
                              attribute: 'birthDate',
                              validators: [
                                FormBuilderValidators.required(),
                              ],
                              valueTransformer: (value) {
                                DateTime time = value;
                                return time.millisecondsSinceEpoch;
                              },
                              onChanged: (value) => _getAge(value),
                              inputType: InputType.date,
                              format: DateFormat('MMMM dd, yyyy'),
                              decoration:
                                  InputDecoration(labelText: 'Birthday'),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _age == null
                                    ? SizedBox()
                                    : Expanded(
                                        child: FormBuilderTextField(
                                          attribute: 'age',
                                          readOnly: true,
                                          initialValue:
                                              _age == null ? '' : '$_age',
                                          validators: [
                                            FormBuilderValidators.required()
                                          ],
                                          valueTransformer: (value) =>
                                              value == null
                                                  ? null
                                                  : int.parse(value),
                                          decoration: InputDecoration(
                                            labelText: 'Age',
                                          ),
                                        ),
                                      ),
                                Expanded(
                                  child: FormBuilderDropdown(
                                    isDense: true,
                                    attribute: 'gender',
                                    decoration:
                                        InputDecoration(labelText: 'Gender'),
                                    items: [
                                      DropdownMenuItem(
                                        value: 'Male',
                                        child: Text('Male'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Female',
                                        child: Text('Female'),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            FormBuilderTextField(
                              attribute: 'location',
                              validators: [FormBuilderValidators.required()],
                              decoration:
                                  InputDecoration(labelText: 'Location'),
                            ),
                            FormBuilderPhoneField(
                              attribute: 'contactNo',
                              defaultSelectedCountryIsoCode: 'PH',
                              decoration:
                                  InputDecoration(labelText: 'Contact No.'),
                              validators: [
                                FormBuilderValidators.required(),
                                FormBuilderValidators.minLength(10),
                                FormBuilderValidators.maxLength(13),
                              ],
                            ),
                            FormBuilderTextField(
                              attribute: 'email',
                              validators: [FormBuilderValidators.required()],
                              decoration: InputDecoration(labelText: 'Email'),
                            ),
                            FormBuilderTextField(
                              attribute: 'password',
                              obscureText: true,
                              validators: [FormBuilderValidators.required()],
                              decoration:
                                  InputDecoration(labelText: 'Password'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    MaterialButton(
                      child: Text('REGISTER'),
                      onPressed: () => _signUpUser(),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  void _getAge(DateTime value) {
    if (value != null) {
      setState(() {
        _age = ((DateTime.now().difference(value).inDays) / 365).floor();
        print(_age);
      });
    }
  }

  void _signUpUser() async {
    try {
      BotToast.showLoading();
      if (_signUpKey.currentState.saveAndValidate()) {
        var map = _signUpKey.currentState.value;
        await _signUpAccount(map);
        var account = _buildAccount(map);
        _accountService.create(account);
        BotToast.closeAllLoading();
        Navigator.pop(context);
      }
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showSimpleNotification(title: e);
    }
  }

  Future<void> _signUpAccount(Map<String, Object> map) async {
    var authResult = await _authService.signUp(map['email'], map['password']);
    map['id'] = authResult.user.uid;
  }

  Account _buildAccount(Map<String, Object> map) {
    Account account = Account();
    _addAuditInfo(map);
    account.user = UserUtil.toEntity(map);
    return account;
  }

  void _addAuditInfo(Map<String, Object> map) {
    map['dateCreated'] = DateTime.now().millisecondsSinceEpoch;
    map['createdBy'] = 'System';
    map['isActive'] = true;
  }
}
