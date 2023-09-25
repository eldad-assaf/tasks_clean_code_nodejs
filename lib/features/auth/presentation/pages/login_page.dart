import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_flutter_clean_code_nodejs/common/helpers/helpers.dart';
import 'package:store_flutter_clean_code_nodejs/common/reuseable_button.dart';
import 'package:store_flutter_clean_code_nodejs/common/reuseable_text.dart';
import 'package:store_flutter_clean_code_nodejs/config/theme/app_themes.dart';
import 'package:store_flutter_clean_code_nodejs/common/reusable_text_field.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/login_request_data.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/presentation/bloc/login_bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _passwordCtr = TextEditingController();
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
                    text: 'Login',
                    style: appStyle(20, Colors.black, FontWeight.bold)),
                const Spacer(),
                InkWell(
                  onTap: () => _onGoToSignupPressed(context),
                  child: ReusableText(
                      text: 'First time?\nCreate an account',
                      maxLines: 2,
                      style: appStyle(16, Colors.blue, FontWeight.normal)),
                ),
              ],
            ),
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
            hintTextString: 'Enter  password',
            inputType: TextInputType.visiblePassword,
            maxLength: 20,
          ),
          const SizedBox(
            height: 5,
          ),
          const Spacer(),
          ReuseableButton(
              text: 'Done',
              onPressed: () {
                bool _validated =
                    validateLoginForm(context, _emailCtr, _passwordCtr);
                if (_validated) {
                  BlocProvider.of<LoginBloc>(context).add(LoginUser(
                      LoginRequestData(
                          email: _emailCtr.text.trim(),
                          password: _passwordCtr.text.trim())));
                }
              })
        ],
      ),
    );
  }

  void _onGoToSignupPressed(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/SignupPage');
  }
}
