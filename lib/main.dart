import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_flutter_clean_code_nodejs/config/routes/app_routes.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/repositories/user_repository_impl.dart';
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
  @override
  void initState() {
    _userRepositoryImpl = UserRepositoryImpl(sl(), sl());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: TextButton(
            onPressed: () async {
              await _userRepositoryImpl.getUserDataFromDB();
            },
            child: Text('get data')),
      ),
    );
  }
}
