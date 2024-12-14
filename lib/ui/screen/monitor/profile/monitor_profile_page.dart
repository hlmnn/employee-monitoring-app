import 'package:employee_monitoring_app/component/em_button/em_button.dart';
import 'package:flutter/material.dart';

class MonitorProfilePage extends StatefulWidget {
  const MonitorProfilePage({super.key, required this.title});

  final String title;

  @override
  _MonitorProfilePageState createState() => _MonitorProfilePageState();
}

class _MonitorProfilePageState extends State<MonitorProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xffFFBD20),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20,top: 20),
        child: Column(
          children: [
            EmButton.elevated(
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                elevation: 4,
                backgroundColor: const Color(0xffDD0000),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              text: 'Logout',
              icon: const Icon(Icons.logout, color: Colors.black),
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.black
              ),
            ),
          ],
        )
      ),
    );
  }
}