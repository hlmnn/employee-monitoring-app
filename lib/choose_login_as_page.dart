import 'package:employee_monitoring_app/component/em_button/em_button.dart';
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
                    child: EmButton.elevated(
                      onPressed: (){
                        Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const LoginPage(title: 'Login'),
                            settings: const RouteSettings(
                              arguments: false,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 4,
                        backgroundColor: const Color(0xffFFBD20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      text: 'Masuk sebagai Member',
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.black
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity, // match parent
                    height: 50,
                    child: EmButton.elevated(
                      onPressed: (){
                        Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const LoginPage(title: 'Login'),
                            settings: const RouteSettings(
                              arguments: true,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 4,
                        backgroundColor: const Color(0xffFFBD20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      text: 'Masuk sebagai Monitor',
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.black
                      ),
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