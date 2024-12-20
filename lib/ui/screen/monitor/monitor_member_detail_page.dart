import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MonitorMemberDetailPage extends StatefulWidget {
  const MonitorMemberDetailPage({super.key, required this.title});

  final String title;

  @override
  _MonitorMemberDetailPageState createState() => _MonitorMemberDetailPageState();
}

class _MonitorMemberDetailPageState extends State<MonitorMemberDetailPage> {

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
      body: Column(
        children: [
          Text('Member Detail Page'),
        ],
      ),
    );
  }

}