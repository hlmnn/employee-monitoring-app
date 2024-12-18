import 'package:another_flushbar/flushbar.dart';
import 'package:employee_monitoring_app/component/em_button/em_button.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key, required this.title});

  final String title;

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _passwordOld = TextEditingController();
  final TextEditingController _passwordNew = TextEditingController();
  final TextEditingController _passwordNewRepeat = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final bool _isObscureOld = true;
  bool _isObscureNew = true;
  bool _isObscureNewRepeat = true;

  @override
  void dispose() {
    _passwordOld.dispose();
    _passwordNew.dispose();
    _passwordNewRepeat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
              ),
            ],
          ),
          child: AppBar(
            title: Text(widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            backgroundColor: const Color(0xffFFBD20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _passwordOld,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon isi kata sandi lama anda!';
                  }
                  if ((value.isNotEmpty) && value.length < 8) {
                    return 'Kata sandi setidaknya memiliki panjang 8 karakter';
                  }
                  return null;
                },
                obscureText: _isObscureOld,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff461902),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Kata Sandi Lama',
                  hintStyle: TextStyle(
                    fontSize: 15,
                  ),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordNew,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon buat kata sandi baru anda!';
                  }
                  if ((value.isNotEmpty) && value.length < 8) {
                    return 'Kata sandi setidaknya memiliki panjang 8 karakter';
                  }
                  return null;
                },
                obscureText: _isObscureNew,
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
                  hintText: 'Kata Sandi Baru',
                  hintStyle: const TextStyle(
                    fontSize: 15,
                  ),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(_isObscureNew
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _isObscureNew = !_isObscureNew;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordNewRepeat,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon ulangi kata sandi baru anda!';
                  }
                  if ((value.isNotEmpty) && value.length < 8) {
                    return 'Kata sandi setidaknya memiliki panjang 8 karakter';
                  }
                  if (value != _passwordNew.text) {
                    return 'Kata sandi baru anda harus sama!';
                  }
                  return null;
                },
                obscureText: _isObscureNewRepeat,
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
                  hintText: 'Ulangi Kata Sandi Baru',
                  hintStyle: const TextStyle(
                    fontSize: 15,
                  ),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(_isObscureNewRepeat
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _isObscureNewRepeat = !_isObscureNewRepeat;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        )
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
        child: EmButton.elevated(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Flushbar(
                message: 'Kata sandi berhasil diubah!',
                flushbarPosition: FlushbarPosition.BOTTOM,
                margin: const EdgeInsets.all(8),
                borderRadius: BorderRadius.circular(10),
                duration: const Duration(seconds: 3),
                isDismissible: false,
              ).show(context);
            }
          },
          style: ElevatedButton.styleFrom(
            elevation: 4,
            backgroundColor: const Color(0xffFFBD20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          text: 'Ubah Kata Sandi',
          textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Colors.black
          ),
        ),
      ),
    );
  }

}