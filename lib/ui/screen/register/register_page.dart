import 'package:another_flushbar/flushbar.dart';
import 'package:employee_monitoring_app/component/em_button/em_button.dart';
import 'package:employee_monitoring_app/component/em_circular_loading.dart';
import 'package:employee_monitoring_app/data/data_state.dart';
import 'package:employee_monitoring_app/ui/cubit/register_cubit.dart';
import 'package:employee_monitoring_app/ui/screen/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.title, required this.isMonitor});

  final String title;
  final bool isMonitor;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  bool _isObscure = true;

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocBuilder<RegisterCubit, DataState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return const EmCircularLoading(size: 30, color: Color(0xffFFBD20));
              } else if (state is SuccessState) {
                context.read<RegisterCubit>().resetState();
                Future.delayed(Duration.zero, () {
                  Flushbar(
                    message: 'Register berhasil!',
                    flushbarPosition: FlushbarPosition.BOTTOM,
                    margin: const EdgeInsets.all(8),
                    borderRadius: BorderRadius.circular(10),
                    duration: const Duration(seconds: 2),
                    isDismissible: false,
                  ).show(context).then((_) {
                    Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) =>
                      const LoginPage(title: 'Login'))
                    );
                  });
                });
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
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
                          TextFormField(
                            controller: _name,
                            validator: (value) {
                              return (value == null || value.isEmpty)
                                  ? 'Mohon isi Nama Lengkap anda!'
                                  : null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff461902)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              contentPadding: EdgeInsets.all(10),
                              hintText: 'Nama Lengkap',
                              hintStyle: TextStyle(
                                fontSize: 15,
                              ),
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _phone,
                            validator: (value) {
                              return (value == null || value.isEmpty)
                                  ? 'Mohon isi No. HP anda!'
                                  : null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff461902)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              contentPadding: EdgeInsets.all(10),
                              hintText: 'No. HP',
                              hintStyle: TextStyle(
                                fontSize: 15,
                              ),
                              prefixIcon: Icon(Icons.phone_android),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _email,
                            validator: (value) {
                              return (value == null || value.isEmpty)
                                  ? 'Mohon isi Email anda!'
                                  : null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff461902)),
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
                                return 'Mohon isi Kata Sandi anda!';
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
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                          activeColor: const Color(0xffFFBD20),
                        ),
                        Expanded(
                            child: RichText(
                              text: const TextSpan(
                                text: 'Saya setuju dengan semua ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Syarat & Ketentuan',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: ' yang berlaku.'),
                                ],
                              ),
                            )
                        ),
                      ],
                    ),
                    EmButton.elevated(
                      onPressed: () {
                        if (!isChecked) {
                          Flushbar(
                            message: 'Silahkan menyetujui Syarat & Ketentuan yang berlaku terlebih dahulu!',
                            flushbarPosition: FlushbarPosition.BOTTOM,
                            margin: const EdgeInsets.all(8),
                            borderRadius: BorderRadius.circular(10),
                            duration: const Duration(seconds: 3),
                            isDismissible: false,
                          ).show(context);
                        }
                        if (_formKey.currentState!.validate() && isChecked) {
                            context.read<RegisterCubit>().register(
                              _name.value.text,
                              _phone.value.text,
                              _email.value.text,
                              _password.value.text,
                              widget.isMonitor,
                            );
                        }
                        if (state is ErrorState) {
                          Flushbar(
                            message: state.message,
                            flushbarPosition: FlushbarPosition.BOTTOM,
                            margin: const EdgeInsets.all(8),
                            borderRadius: BorderRadius.circular(10),
                            duration: const Duration(seconds: 3),
                            isDismissible: false,
                          ).show(context);
                          context.read<RegisterCubit>().resetState();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 4,
                        backgroundColor: const Color(0xffFFBD20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius
                            .circular(10)),
                      ),
                      text: 'Daftar Sekarang',
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.black
                      ),
                    )
                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }

}