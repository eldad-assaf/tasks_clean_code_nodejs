import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:store_flutter_clean_code_nodejs/config/routes/app_routes.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/datasources/local/app_database.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/user_model.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/repositories/user_repository_impl.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/presentation/bloc/auth_state_cubit/auth_state_cubit.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/presentation/pages/login_page.dart';
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
        BlocProvider<AuthStateCubit>(create: (context) => AuthStateCubit()),
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
  late UserRepositoryImpl _userRepositoryImpl;
  late FlutterSecureStorage _storage;
  late AppDatabase _appDatabase;
  late AuthStateCubit _authStateCubit;
  late String? token;
  @override
  void initState() {
    _userRepositoryImpl = UserRepositoryImpl(sl(), sl(), sl());
    _storage = FlutterSecureStorage();
    _appDatabase = sl<AppDatabase>();
    _authStateCubit = sl<AuthStateCubit>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<bool?>(
          stream: _authStateCubit.isAuthenticated(),
          // stream: _appDatabase.userDao
          //     .userStreamForAuthState(UserModel.fixedUserId),
          builder: (context, snapshot) {
            log(snapshot.connectionState.toString());
            if (snapshot.connectionState == ConnectionState.active) {
              log(snapshot.data.toString());
              return Container(
                child: TextButton(
                    onPressed: () async {},
                    child: snapshot.data == true
                        ? Text('token is validated')
                        : Text('token is not validated')),
              );
            } else {
              return Container(
                color: Colors.red,
              );
            }
          }),
    );
  }
}
