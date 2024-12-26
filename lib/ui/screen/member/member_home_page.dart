import 'package:employee_monitoring_app/ui/screen/leaderboard/leaderboard_page.dart';
import 'package:employee_monitoring_app/ui/screen/member/member_task_active_page.dart';
import 'package:employee_monitoring_app/ui/screen/member/member_task_completed_page.dart';
import 'package:flutter/material.dart';

class MemberHomePage extends StatefulWidget {
  const MemberHomePage({super.key, required this.title});

  final String title;

  @override
  _MemberHomePageState createState() => _MemberHomePageState();
}

class _MemberHomePageState extends State<MemberHomePage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget> [
              SliverAppBar(
                pinned: true,
                floating: true,
                forceElevated: innerBoxIsScrolled,
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
                    tooltip: 'Detail Group',
                    onPressed: () {
                      // Navigator.push(context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //     const MonitorGroupDetailPage(title: 'Detail Group'),
                      //   ),
                      // );
                    },
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.leaderboard, color: Colors.black),
                    tooltip: 'Peringkat',
                    onPressed: () {
                      Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) =>
                          const LeaderboardPage(title: 'Peringkat'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 20),
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(56),
                  child: Container(
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
                ),
              ),
            ];
          },
          body: const SafeArea(
            top: false,
            bottom: false,
            child: TabBarView(
              children: [
                MemberTaskActivePage(title: 'Active Task'),
                MemberTaskCompletedPage(title: 'Task Selesai')
              ],
            ),
          ),
        ),
      ),
    );
  }
}