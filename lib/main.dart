import 'dart:async';

import 'package:employee_monitoring_app/choose_login_as_page.dart';
import 'package:employee_monitoring_app/ui/cubit/edit_group_cubit.dart';
import 'package:employee_monitoring_app/ui/cubit/group_cubit.dart';
import 'package:employee_monitoring_app/ui/cubit/edit_profile_cubit.dart';
import 'package:employee_monitoring_app/ui/cubit/home_cubit.dart';
import 'package:employee_monitoring_app/ui/cubit/leaderboard_cubit.dart';
import 'package:employee_monitoring_app/ui/cubit/login_cubit.dart';
import 'package:employee_monitoring_app/ui/cubit/profile_cubit.dart';
import 'package:employee_monitoring_app/ui/cubit/register_cubit.dart';
import 'package:employee_monitoring_app/ui/cubit/splash_cubit.dart';
import 'package:employee_monitoring_app/ui/screen/member/member_navigation.dart';
import 'package:employee_monitoring_app/ui/screen/monitor/monitor_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'data/data_state.dart';

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
        BlocProvider<SplashCubit>(
          create: (context) => SplashCubit(),
        ),
        BlocProvider<RegisterCubit>(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(),
        ),
        BlocProvider<EditProfileCubit>(
          create: (context) => EditProfileCubit(),
        ),
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(),
        ),
        BlocProvider<GroupCubit>(
          create: (context) => GroupCubit(),
        ),
        BlocProvider<EditGroupCubit>(
          create: (context) => EditGroupCubit(),
        ),
        BlocProvider<LeaderboardCubit>(
          create: (context) => LeaderboardCubit(),
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
  Widget build(BuildContext context) {
    BlocProvider.of<SplashCubit>(context).getCurrentSession();
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 90),
      child: BlocBuilder<SplashCubit, DataState>(
        builder: (context, state) {
          Future.delayed(const Duration(seconds: 4), () {
            if (!mounted) return;
            if (state is SuccessState) {
              print(state.data);
              if (state.data != null) {
                if (state.data == true) {
                  context.read<SplashCubit>().resetState();
                  if (mounted) {
                    Navigator.pushReplacement(
                      context, MaterialPageRoute(
                        builder: (context) => const MonitorNavigation(title: 'Monitor Navigation')),
                    );
                  }
                } else {
                  context.read<SplashCubit>().resetState();
                  if (mounted) {
                    Navigator.pushReplacement(
                      context, MaterialPageRoute(
                        builder: (context) => const MemberNavigation(title: 'Member Navigation')),
                    );
                  }
                }
              } else {
                context.read<SplashCubit>().resetState();
                if (mounted) {
                  Navigator.pushReplacement(
                    context, MaterialPageRoute(
                      builder: (context) => const ChooseLoginAsPage(title: 'Choose Login As')),
                  );
                }
              }
            }
          });
          return Image.asset(
            'assets/images/app_logo.png',
            height: 175,
            width: 175,
          );
        }
      ),
    );
  }
}
