import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MonitorRewardCreatePage extends StatefulWidget {
  const MonitorRewardCreatePage({super.key, required this.title});

  final String title;

  @override
  _MonitorRewardCreatePageState createState() => _MonitorRewardCreatePageState();
}

class _MonitorRewardCreatePageState extends State<MonitorRewardCreatePage> {
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
        scrollDirection: Axis.vertical,
        child: Form(
          child: Column(
            children: [
              Text('Reward Create Page'),
            ],
          ),
        ),
      )
    );
  }
  
}