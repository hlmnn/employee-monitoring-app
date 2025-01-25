import 'package:employee_monitoring_app/component/em_button/em_button.dart';
import 'package:employee_monitoring_app/component/em_circular_loading.dart';
import 'package:employee_monitoring_app/data/data_state.dart';
import 'package:employee_monitoring_app/main.dart';
import 'package:employee_monitoring_app/ui/cubit/login_cubit.dart';
import 'package:employee_monitoring_app/ui/screen/member/member_navigation.dart';
import 'package:employee_monitoring_app/ui/screen/monitor/monitor_navigation.dart';
import 'package:employee_monitoring_app/ui/screen/register/register_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isChoiceMonitor = ModalRoute.of(context)!.settings.arguments as bool?;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocBuilder<LoginCubit, DataState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return const EmCircularLoading(size: 30, color: Color(0xffFFBD20));
              } else if (state is SuccessState) {
                final session = supabase.auth.currentSession;
                if (session?.user.userMetadata!['is_monitor'] == true){
                  context.read<LoginCubit>().resetState();
                  Future.delayed(Duration.zero, () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const MonitorNavigation(title: 'Monitor Navigation'),
                      ), (Route<dynamic> route) => false);
                  });
                } else {
                  context.read<LoginCubit>().resetState();
                  Future.delayed(Duration.zero, () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const MemberNavigation(title: 'Member Navigation'),
                        ), (Route<dynamic> route) => false);
                  });
                }
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Image.asset(
                          'assets/images/app_logo.png',
                          height: 175,
                          width: 175,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _email,
                              validator: (value) {
                                return (value == null || value.isEmpty)
                                    ? 'Email tidak boleh kosong!'
                                    : null;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff461902)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                contentPadding: EdgeInsets.all(10),
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                  fontSize: 15,
                                ),
                                prefixIcon: Icon(Icons.email),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _password,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Kata Sandi tidak boleh kosong';
                                }
                                if ((value.isNotEmpty) && value.length < 8) {
                                  return 'Kata Sandi setidaknya memiliki panjang 8 karakter';
                                }
                                return null;
                              },
                              obscureText: _isObscure,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xff461902),
                                  ),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                contentPadding: const EdgeInsets.all(10),
                                hintText: 'Kata Sandi',
                                hintStyle: const TextStyle(
                                  fontSize: 15,
                                ),
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(_isObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      EmButton.elevated(
                        onPressed: (){
                          if (_formKey.currentState!.validate()) {
                            context.read<LoginCubit>().login(
                              _email.value.text.trim(),
                              _password.value.text.trim()
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 4,
                          backgroundColor: const Color(0xffFFBD20),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        text: "Masuk",
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.black
                        ),
                      ),
                      const SizedBox(height: 18),
                      RichText(
                        text: TextSpan(
                            text: 'Belum mempunyai akun?',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                            ),
                            children: [
                              TextSpan(text: ' Daftar sekarang disini!',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                    color: Colors.black,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      isChoiceMonitor == true
                                          ? Navigator.push(context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                          const RegisterPage(title: 'Register', isMonitor: true),
                                        ),
                                      )
                                          : Navigator.push(context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                          const RegisterPage(title: 'Register', isMonitor: false),
                                        ),
                                      );
                                    }
                              )
                            ]
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}