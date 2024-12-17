import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:employee_monitoring_app/component/em_button/em_button.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.title});

  final String title;

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  File? image;

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _address.dispose();
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
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar_placeholder.png'),
                    radius: 90,
                  ),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffFFBD20),
                      ),
                      child: const Icon(Icons.edit, color: Colors.black, size: 20,),
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 20),
              TextFormField(
                controller: _name,
                validator: (value) {
                  return (value == null || value.isEmpty)
                      ? 'Mohon isi Nama Lengkap anda!'
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
                    borderSide: BorderSide(color: Color(0xff461902)),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  hintText: 'No. HP',
                  hintStyle: TextStyle(
                    fontSize: 15,
                  ),
                  prefixIcon: Icon(Icons.phone_android),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _address,
                validator: (value) {
                  return (value == null || value.isEmpty)
                      ? 'Mohon isi Alamat Lengkap anda!'
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
                  hintText: 'Alamat',
                  hintStyle: TextStyle(
                    fontSize: 15,
                  ),
                  prefixIcon: Icon(Icons.home),
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
                message: 'Profile berhasil diubah!',
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
          text: 'Konfirmasi',
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