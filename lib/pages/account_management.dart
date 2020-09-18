import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:order_up_merchant/commons/models/account.dart';
import 'package:order_up_merchant/commons/models/user.dart';
import 'package:order_up_merchant/commons/utils/user_tracker.dart';
import 'package:order_up_merchant/services/account/account_service.dart';

class AccountManagement extends StatefulWidget {
  @override
  _AccountManagementState createState() => _AccountManagementState();
}

class _AccountManagementState extends State<AccountManagement> {
  final AccountService _accountService = GetIt.I<AccountService>();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  int _age = 0;
  User _user = User();

  Account _account;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: FormBuilder(
              key: _formKey,
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
                            initialValue: _user.store ?? '',
                            validators: [FormBuilderValidators.required()],
                            decoration:
                            InputDecoration(labelText: 'Store Name'),
                          ),
                          FormBuilderTextField(
                            attribute: 'firstName',
                            initialValue: _user.firstName ?? '',
                            validators: [FormBuilderValidators.required()],
                            decoration:
                            InputDecoration(labelText: 'First Name'),
                          ),
                          FormBuilderTextField(
                            attribute: 'lastName',
                            initialValue: _user.lastName ?? '',
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: 'Last Name'),
                          ),
                          FormBuilderDateTimePicker(
                            attribute: 'birthDate',
                            initialValue: _getBirthDate(_user.birthDate),
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
                            decoration: InputDecoration(labelText: 'Birthday'),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: FormBuilderTextField(
                                  attribute: 'age',
                                  readOnly: true,
                                  initialValue: '${_user.age}' ?? '0',
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
                              SizedBox(width: 30),
                              Expanded(
                                child: FormBuilderDropdown(
                                  isDense: true,
                                  initialValue: _user.gender,
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
                            initialValue: _user.location ?? '',
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: 'Location'),
                          ),
                          FormBuilderPhoneField(
                            attribute: 'contactNo',
                            initialValue: _user.contactNo ?? '',
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
                            decoration: InputDecoration(labelText: 'Password'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  MaterialButton(
                    child: Text('UPDATE'),
                    onPressed: () => _updateUserInfo(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  void initializeData() async {
    var account = await _accountService.get();
    print(account);
    setState(() {
      if(account != null) {
        _account = account;
        _user = _account.user;
      }
    });
  }

  void _getAge(DateTime value) {
    if (value != null) {
      setState(() {
        _age = ((DateTime.now().difference(value).inDays) / 365).floor();
        print(_age);
      });
    }
  }

  void _updateUserInfo() {

  }

  DateTime _getBirthDate(int birthDate) {
    if(birthDate != null && birthDate > 0) {
      return DateTime.fromMicrosecondsSinceEpoch(_user.birthDate);
    }
    return null;
  }


}
