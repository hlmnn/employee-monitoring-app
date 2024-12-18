import 'package:flutter/material.dart';

class MonitorTaskDetailPage extends StatefulWidget {
  const MonitorTaskDetailPage({super.key, required this.title});

  final String title;

  @override
  _MonitorTaskDetailPageState createState() => _MonitorTaskDetailPageState();
}

class _MonitorTaskDetailPageState extends State<MonitorTaskDetailPage> {
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
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text('Task Detail Page'),
          ],
        ),
      ),
    );
  }

}