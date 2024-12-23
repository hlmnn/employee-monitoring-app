import 'package:employee_monitoring_app/component/em_button/em_button.dart';
import 'package:employee_monitoring_app/ui/screen/leaderboard/leaderboard_page.dart';
import 'package:employee_monitoring_app/ui/screen/monitor/monitor_home_active_task.dart';
import 'package:employee_monitoring_app/ui/screen/monitor/monitor_home_completed%20task.dart';
import 'package:employee_monitoring_app/ui/screen/monitor/monitor_member_list_page.dart';
import 'package:employee_monitoring_app/ui/screen/monitor/task/monitor_task_create_page.dart';
import 'package:flutter/material.dart';

class MonitorHomePage extends StatefulWidget {
  const MonitorHomePage({super.key, required this.title});

  final String title;

  @override
  _MonitorHomePageState createState() => _MonitorHomePageState();
}

class _MonitorHomePageState extends State<MonitorHomePage> {

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
              actions: [
                IconButton(
                  icon: const Icon(Icons.group, color: Colors.black),
                  tooltip: 'Daftar Member',
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const MonitorMemberListPage(title: 'Daftar Member'),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.leaderboard, color: Colors.black),
                  tooltip: 'Peringkat Progress',
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const LeaderboardPage(title: 'Peringkat Progress'),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: const Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nama Group'),
                            Text('PDIP Demokrat Golkar Gerindra PKB PPPPP',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Kode Invite Group'),
                          Text('DDXFSQ6F',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Member'),
                          Text('10',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelColor: const Color(0xffDD7402),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
                unselectedLabelColor:Colors.black38,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), // Creates border
                  color: const Color(0xffFFE588),
                ),
                tabs: const [
                  Tab(
                    text: 'Task Aktif',
                  ),
                  Tab(
                    text: 'Task Selesai',
                  )
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  MonitorHomeActiveTaskPage(title: 'Active Task'),
                  MonitorHomeCompletedTaskPage(title: 'Task Selesai')
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xffFFBD20),
          onPressed: () {
            Navigator.push(context,
              MaterialPageRoute(
                builder: (context) =>
                const MonitorTaskCreatePage(title: 'Buat Tugas')
              )
            );
          },
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ),
    );
  }
}