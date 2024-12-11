import 'package:employee_monitoring_app/component/em_button.dart';
import 'package:employee_monitoring_app/ui/screen/login/login_page.dart';
import 'package:flutter/material.dart';

class ChooseLoginAsPage extends StatefulWidget {
  const ChooseLoginAsPage({super.key, required this.title});

  final String title;

  @override
  _ChooseLoginAsPageState createState() => _ChooseLoginAsPageState();
}

class _ChooseLoginAsPageState extends State<ChooseLoginAsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/images/app_logo.png',
                height: 175,
                width: 175,
              ),
            ),
          ),
        Align(
            alignment: FractionalOffset.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: double.infinity, // match parent
                    height: 50,
                    child: EmButton(
                      onPressed: (){
                        Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const LoginPage(title: 'Login'),
                          ),
                        );
                      },
                      text: 'Masuk sebagai Member',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity, // match parent
                    height: 50,
                    child: EmButton(
                      onPressed: (){
                        Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const LoginPage(title: 'Login'),
                          ),
                        );
                      },
                      text: 'Masuk sebagai Monitor',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}