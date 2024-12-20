import 'package:employee_monitoring_app/component/em_card/em_card.dart';
import 'package:employee_monitoring_app/ui/screen/monitor/store/monitor_reward_create_page.dart';
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
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200, // Maximum width of each item
              crossAxisSpacing: 2, // Spacing between items
              mainAxisSpacing: 2, // Vertical spacing between items
              childAspectRatio: 3 / 4
            ),
            itemCount: 11,
            itemBuilder: (BuildContext context, int index) {
            return EmCard.item(
              onTap: () {},
              image: 'assets/images/avatar_placeholder.png',
              name: 'Item Reward Name ke-${index+1}',
              price: 100,
              isMonitor: true,
              onPressedButton: (){},
            );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffFFBD20),
        onPressed: () {
          Navigator.push(context,
            MaterialPageRoute(
              builder: (context) =>
              const MonitorRewardCreatePage(title: 'Buat Reward'),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}