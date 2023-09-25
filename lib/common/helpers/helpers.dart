import 'package:flutter/material.dart';

bool validateName(TextEditingController nameCtr) {
  return nameCtr.text.trim().length > 2 && nameCtr.text.trim().length <= 20;
}

bool validateEmail(TextEditingController emailCtr) {
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  return emailRegex.hasMatch(emailCtr.text);
}

bool validatePasswordIsMin6AndMax15Characters(
    TextEditingController passwordCtr) {
  return passwordCtr.text.trim().length > 5 &&
      passwordCtr.text.trim().length < 16;
}

bool validatePasswordsAreTheSame(
    TextEditingController passwordCtr, TextEditingController password2Ctr) {
  return passwordCtr.text.trim() == password2Ctr.text.trim();
}

bool validateSignupForm(
    BuildContext context,
    TextEditingController nameCtr,
    TextEditingController emailCtr,
    TextEditingController passwordCtr,
    TextEditingController password2Ctr) {
  if (!validateName(nameCtr)) {
    _showSnackBar(context, 'Name must be between 3-20 characters');
    return false;
  }

  if (!validateEmail(emailCtr)) {
    _showSnackBar(context, 'The email you entered is not valid ');
    return false;
  }
  if (!validatePasswordIsMin6AndMax15Characters(passwordCtr)) {
    _showSnackBar(context, 'Passwords must be between 6-15 characters');
    return false;
  }
  if (!validatePasswordsAreTheSame(passwordCtr, password2Ctr)) {
    _showSnackBar(context, 'Passwords must be the same');
    return false;
  } else {
    return true;
  }
}

bool validateLoginForm(BuildContext context, TextEditingController emailCtr,
    TextEditingController passwordCtr) {
  if (!validateEmail(emailCtr)) {
    _showSnackBar(context, 'The email you entered is not valid ');
    return false;
  }
  if (!validatePasswordIsMin6AndMax15Characters(passwordCtr)) {
    _showSnackBar(context, 'Passwords must be between 6-15 characters');
    return false;
  } else {
    return true;
  }
}

void _showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
