import 'package:flutter/material.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/presentation/pages/login_page.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/presentation/pages/signup_page.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/presentation/widgets/auth_state_builder.dart';
import 'package:store_flutter_clean_code_nodejs/home_page.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const AuthStateBuilder());

      case '/SignupPage':
        return _materialRoute(const SignupPage());

      case '/LoginPage':
        return _materialRoute(const LoginPage());
      case '/HomePage':
        return _materialRoute(const HomePage());

      default:
        return _materialRoute(const AuthStateBuilder());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
