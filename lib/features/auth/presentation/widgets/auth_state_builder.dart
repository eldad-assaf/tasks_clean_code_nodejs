import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/datasources/local/app_database.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/user_model.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/presentation/pages/signup_page.dart';
import 'package:store_flutter_clean_code_nodejs/home_page.dart';
import 'package:store_flutter_clean_code_nodejs/injection_container.dart';

class AuthStateBuilder extends StatefulWidget {
  const AuthStateBuilder({super.key});

  @override
  State<AuthStateBuilder> createState() => _AuthStateBuilderState();
}

class _AuthStateBuilderState extends State<AuthStateBuilder> {
  late AppDatabase _appDatabase;

  Future<bool> _isTokenValid({required String? tokenFromServer}) async {
    if (tokenFromServer != null) {
      bool hasExpired = JwtDecoder.isExpired(tokenFromServer);
      return !hasExpired;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    _appDatabase = sl<AppDatabase>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<UserModel?>(
        stream:
            _appDatabase.userDao.userStreamForAuthState(UserModel.fixedUserId),
        builder: (context, tokenSnapshot) {
          if (tokenSnapshot.connectionState == ConnectionState.active) {
            if (tokenSnapshot.data == null) {
              return SignupPage();
            } else {
              return FutureBuilder<bool>(
                future: _isTokenValid(
                  tokenFromServer: tokenSnapshot.data?.token,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == true) {
                      return HomePage();
                    } else {
                      return SignupPage();
                    }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
