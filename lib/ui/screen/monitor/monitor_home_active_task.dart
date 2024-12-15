import 'package:employee_monitoring_app/component/em_card/em_card_task.dart';
import 'package:flutter/material.dart';

class MonitorHomeActiveTaskPage extends StatefulWidget {
  const MonitorHomeActiveTaskPage({super.key, required this.title});

  final String title;

  @override
  _MonitorHomeActiveTaskPageState createState() => _MonitorHomeActiveTaskPageState();
}

class _MonitorHomeActiveTaskPageState extends State<MonitorHomeActiveTaskPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 15,
          itemBuilder: (BuildContext context, int index) {
            return EmCardTask(
              onTap: (){},
              title: 'Judul Task Aktif yang ke-${index+1}',
              image: 'assets/images/avatar_placeholder.png',
              name: 'John Doe Hidayat',
              date: '7 Januari 2024',
              cash: '150',
              experience: '50',
            );
          },
        )
      ),
    );
  }
}