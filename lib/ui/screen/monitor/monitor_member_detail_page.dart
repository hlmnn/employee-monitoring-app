import 'package:employee_monitoring_app/component/em_card/em_card.dart';
import 'package:employee_monitoring_app/component/em_error.dart';
import 'package:employee_monitoring_app/data/model/task_model.dart';
import 'package:employee_monitoring_app/ui/screen/monitor/task/monitor_task_detail_page.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/avatar_placeholder.png'),
                  radius: 40,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text('Ryan Ahmad Gosling',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          RichText(
                            text: const TextSpan(
                              text: 'Lv.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                              ),
                              children: [
                                TextSpan(
                                  text: '10',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('085123456789'),
                          Text('Monitor'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Text('Jl. Gatot Subroto No.40 RT01/06, Desa Nordschleife, Kec. Nurburgring',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(Icons.list, color: Colors.black),
                SizedBox(width: 5),
                Text('Daftar Task',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
              ],
            ),
            Expanded(
              child: tasks.any((task) => task.status == 'active')
                  ? ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  if (tasks[index].status != 'active') return const SizedBox.shrink();
                  return EmCard.task(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MonitorTaskDetailPage(title: 'Detail Tugas'),
                        ),
                      );
                    },
                    image: 'assets/images/avatar_placeholder.png',
                    title: '${tasks[index].title} yang ke-${index + 1}',
                    name: tasks[index].member.name,
                    level: tasks[index].member.level,
                    date: tasks[index].lastDate,
                    cash: tasks[index].cash,
                    experience: tasks[index].exp,
                  );
                },
              )
                  : EmError(
                onPressed: () {},
                textAbove: 'Member Belum mempunyai task.',
                textBelow: 'Buat tugas terlebih dahulu!',
              ),
            ),
          ],
        ),
      ),
    );
  }

}