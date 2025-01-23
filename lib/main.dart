import 'dart:async';

import 'package:employee_monitoring_app/choose_login_as_page.dart';
import 'package:employee_monitoring_app/ui/cubit/login_cubit.dart';
import 'package:employee_monitoring_app/ui/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  final String? url = dotenv.env['URL'];
  final String? anonKey = dotenv.env['ANON_KEY'];

  await Supabase.initialize(
    url: url!,
    anonKey: anonKey!,
  );

  runApp(const MyApp());
}
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterCubit>(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Employee Monitoring',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          fontFamily: 'Poppins',
          useMaterial3: true,
        ),
        home: const SplashScreen(title: 'SplashScreen',),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.title});

  final String title;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ChooseLoginAsPage(title: 'Choose Login As'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 90),
      child:Image.asset(
        'assets/images/app_logo.png',
        height: 175,
        width: 175,
      ),
    );
  }

}
