import 'package:employee_monitoring_app/component/em_circular_loading.dart';
import 'package:employee_monitoring_app/data/data_state.dart';
import 'package:employee_monitoring_app/ui/cubit/home_cubit.dart';
import 'package:employee_monitoring_app/ui/screen/leaderboard/leaderboard_page.dart';
import 'package:employee_monitoring_app/ui/screen/monitor/monitor_home_active_task.dart';
import 'package:employee_monitoring_app/ui/screen/monitor/monitor_home_completed_task.dart';
import 'package:employee_monitoring_app/ui/screen/monitor/monitor_group_detail_page.dart';
import 'package:employee_monitoring_app/ui/screen/monitor/task/monitor_task_create_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MonitorHomePage extends StatefulWidget {
  const MonitorHomePage({super.key, required this.title});

  final String title;

  @override
  _MonitorHomePageState createState() => _MonitorHomePageState();
}

class _MonitorHomePageState extends State<MonitorHomePage> {

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeCubit>(context).getIsJoinServer();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: BlocBuilder<HomeCubit, DataState>(
          builder: (context, state) {
            bool isJoinServer = false;
            if (state is LoadingState) {
              return const Center(
                  child: EmCircularLoading(size: 30, color: Color(0xffFFBD20))
              );
            } else if (state is SuccessState) {
              print('is join server: ${state.data}');
              isJoinServer = state.data;
            }
            return NestedScrollView(
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
                      isJoinServer == false
                        ? const SizedBox.shrink()
                        : Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.group, color: Colors.black),
                              tooltip: 'Detail Group',
                              onPressed: () {
                                Navigator.push(context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                    const MonitorGroupDetailPage(title: 'Detail Group'),
                                  ),
                                );
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
                            const SizedBox(width: 20)
                          ],
                        ),
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
              body: SafeArea(
                top: false,
                bottom: false,
                child: TabBarView(
                  children: [
                    MonitorHomeActiveTaskPage(title: 'Active Task', isJoinServer: isJoinServer),
                    MonitorHomeCompletedTaskPage(title: 'Task Selesai', isJoinServer: isJoinServer)
                  ],
                ),
              ),
            );
          }
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