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
import 'package:store_flutter_clean_code_nodejs/features/auth/presentation/widgets/auth_state_builder.dart';
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
        home: AuthStateBuilder(),
        // home: SignupPage(),
        //  home: LoginPage(),
      ),
    );
  }
}
