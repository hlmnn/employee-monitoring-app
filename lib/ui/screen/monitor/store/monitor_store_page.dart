import 'package:flutter/material.dart';

class MonitorStorePage extends StatefulWidget {
  const MonitorStorePage({super.key, required this.title});

  final String title;

  @override
  _MonitorStorePageState createState() => _MonitorStorePageState();
}

class _MonitorStorePageState extends State<MonitorStorePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFBD20),
      ),
      body: const Text('Store'),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffFFBD20),
        onPressed: () {},
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}