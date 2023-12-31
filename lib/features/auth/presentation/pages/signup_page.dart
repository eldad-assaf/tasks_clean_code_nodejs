import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:store_flutter_clean_code_nodejs/common/helpers/helpers.dart';
import 'package:store_flutter_clean_code_nodejs/common/reuseable_button.dart';
import 'package:store_flutter_clean_code_nodejs/common/reuseable_text.dart';
import 'package:store_flutter_clean_code_nodejs/config/theme/app_themes.dart';
import 'package:store_flutter_clean_code_nodejs/common/reusable_text_field.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/register_request.dart';
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
      automaticallyImplyLeading: false,
    );
  }

  _buildBody() {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) async {
        if (state is RegistrationError) {
          String error = '';
          if (state.error != null) {
            error = state.error!.response?.data['msg'] ?? 'Unknown Error';
          } else {
            error = 'Unknown Error';
          }

          await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('error'),
                // content: Text(state.error!.response!.data['msg'].toString()),
                content: Text(error),
              );
            },
          );
        }
        if (state is RegisteredSuccessfully) {
          log('state is RegisteredSuccessfully');
          Navigator.of(context).pushReplacementNamed('/HomePage');
        }
      },
      child: Padding(
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
            BlocBuilder<RegisterBloc, RegisterState>(
              builder: (context, state) {
                if (state is RegisterInProgress) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ReuseableButton(
                    text: 'Done',
                    onPressed: () {
                      bool _validated = validateSignupForm(context, _nameCtr,
                          _emailCtr, _passwordCtr, _password2Ctr);
                      if (_validated) {
                        BlocProvider.of<RegisterBloc>(context)
                            .add(RegisterUserEvent(RegisterRequest(
                          name: _nameCtr.text.trim(),
                          email: _emailCtr.text.trim(),
                          password: _passwordCtr.text.trim(),
                        )));
                      }
                    });
              },
            )
          ],
        ),
      ),
    );
  }

  void _onGoToLoginPressed(BuildContext context) {
    // Navigator.pushReplacementNamed(context, '/LoginPage');
    Navigator.pushNamed(context, '/LoginPage');
  }
}
