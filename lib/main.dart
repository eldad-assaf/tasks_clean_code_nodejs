import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:store_flutter_clean_code_nodejs/config/routes/app_routes.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/datasources/local/app_database.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/user_model.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/presentation/pages/signup_page.dart';
import 'package:store_flutter_clean_code_nodejs/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(sl()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //theme: theme(),
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        home: Home(),
        // home: SignupPage(),
        //  home: LoginPage(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late FlutterSecureStorage _flutterSecureStorage;
  late AppDatabase _appDatabase;
  // late String? tokenStoredInSecureStorage; //on the device

  Future<bool> _isTokenValid({required String? tokenFromServer}) async {
    String? tokenStoredInSecureStorage =
        await _flutterSecureStorage.read(key: 'token');
    if (tokenFromServer != null &&
        tokenStoredInSecureStorage != null &&
        tokenFromServer == tokenStoredInSecureStorage) {
      bool hasExpired = JwtDecoder.isExpired(tokenStoredInSecureStorage);

      return !hasExpired;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    _flutterSecureStorage = sl<FlutterSecureStorage>();
    _appDatabase = sl<AppDatabase>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<UserModel?>(
          stream: _appDatabase.userDao
              .userStreamForAuthState(UserModel.fixedUserId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              return FutureBuilder<bool>(
                future: _isTokenValid(tokenFromServer: snapshot.data!.token),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == true) {
                      return Container(
                        color: Colors.amber,
                      );
                    } else {
                      return SignupPage();
                    }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
