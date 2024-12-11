import 'package:employee_monitoring_app/component/em_button.dart';
import 'package:employee_monitoring_app/ui/screen/register/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
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
                          contentPadding: const EdgeInsets.all(10),
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
                EmButton(
                    onPressed: (){},
                    text: "Masuk"
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
                      children: <TextSpan>[
                        TextSpan(text: ' Daftar sekarang disini!',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                                color: Colors.black,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterPage(title: 'Register'),
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
        ),
      ),
    );
  }
}