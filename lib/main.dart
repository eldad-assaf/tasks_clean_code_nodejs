import 'package:flutter/material.dart';
import 'package:store_flutter_clean_code_nodejs/config/routes/app_routes.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/presentation/pages/login_page.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/presentation/pages/signup_page.dart';

Future<void> main() async {
  //WidgetsFlutterBinding.ensureInitialized();
//  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: theme(),
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      home: SignupPage(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
