
import 'package:flutter/material.dart';
import 'package:store_flutter_clean_code_nodejs/common/reuseable_button.dart';
import 'package:store_flutter_clean_code_nodejs/common/reuseable_text.dart';
import 'package:store_flutter_clean_code_nodejs/config/theme/app_themes.dart';
import 'package:store_flutter_clean_code_nodejs/common/reusable_text_field.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/register_request_data.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameCtr = TextEditingController();
  final TextEditingController _passwordCtr = TextEditingController();
  final TextEditingController _password2Ctr = TextEditingController();
  final TextEditingController _emailCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('NodeJS Task App'),
    );
  }

  _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Row(
              children: [
                ReusableText(
                    text: 'Sign Up',
                    style: appStyle(20, Colors.black, FontWeight.bold)),
                const Spacer(),
                InkWell(
                  onTap: () => _onGoToLoginPressed(context),
                  child: ReusableText(
                      text: 'Alredy have an account?',
                      style: appStyle(16, Colors.blue, FontWeight.normal)),
                ),
              ],
            ),
          ),
          ReuseableTextField(
            textEditController: _nameCtr,
            hintTextString: 'Enter your name',
            inputType: TextInputType.name,
            maxLength: 20,
          ),
          const SizedBox(
            height: 5,
          ),
          ReuseableTextField(
            textEditController: _emailCtr,
            hintTextString: 'Enter your email',
            inputType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 5,
          ),
          ReuseableTextField(
            textEditController: _passwordCtr,
            hintTextString: 'Enter a password',
            inputType: TextInputType.visiblePassword,
            maxLength: 15,
          ),
          const SizedBox(
            height: 5,
          ),
          ReuseableTextField(
            textEditController: _password2Ctr,
            hintTextString: 'Enter the password again',
            inputType: TextInputType.visiblePassword,
            maxLength: 15,
          ),
          const Spacer(),
          ReuseableButton(
              text: 'Done',
              onPressed: () {
                bool _validated = _validateForm();
                if (_validated) {
                  BlocProvider.of<RegisterBloc>(context)
                      .add(RegisterUser(RegisterRequestData(
                    name: _nameCtr.text.trim(),
                    email: _emailCtr.text.trim(),
                    password: _passwordCtr.text.trim(),
                  )));
                }

             
              })
        ],
      ),
    );
  }

  void _onGoToLoginPressed(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/LoginPage');
  }

  bool validateName() {
    return _nameCtr.text.trim().length > 2 && _nameCtr.text.trim().length <= 20;
  }

  bool validateEmail() {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(_emailCtr.text);
  }

  bool validatePasswordIsMin6AndMax15Characters() {
    return _passwordCtr.text.trim().length > 5 &&
        _passwordCtr.text.trim().length < 16;
  }

  bool validatePasswordsAreTheSame() {
    return _passwordCtr.text.trim() == _password2Ctr.text.trim();
  }

  bool _validateForm() {
    if (!validateName()) {
      _showSnackBar(context, 'Name must be ');
      return false;
    }

    if (!validateEmail()) {
      _showSnackBar(context, 'Email must be ');
      return false;
    }
    if (!validatePasswordIsMin6AndMax15Characters()) {
      _showSnackBar(context, 'Passwords must be between 6-15 characters ');
      return false;
    }
    if (!validatePasswordsAreTheSame()) {
      _showSnackBar(context, 'Passwords must be the same ');
      return false;
    } else {
      return true;
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
