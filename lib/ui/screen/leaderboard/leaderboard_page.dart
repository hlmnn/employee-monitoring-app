import 'package:employee_monitoring_app/component/em_card/em_card.dart';
import 'package:employee_monitoring_app/component/em_circular_loading.dart';
import 'package:employee_monitoring_app/component/em_error.dart';
import 'package:employee_monitoring_app/data/data_state.dart';
import 'package:employee_monitoring_app/data/model/user_model.dart';
import 'package:employee_monitoring_app/ui/cubit/leaderboard_cubit.dart';
import 'package:employee_monitoring_app/ui/screen/monitor/monitor_member_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key, required this.title});

  final String title;

  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage>{

  @override
  Widget build(BuildContext context) {
    context.read<LeaderboardCubit>().getLeaderboard();
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
      body: BlocBuilder<LeaderboardCubit, DataState>(
        builder: (context, state) {
          List<AuthUserModel> members = [];
          if (state is LoadingState) {
            return const Center(
                child: EmCircularLoading(size: 30, color: Color(0xffFFBD20))
            );
          } else if (state is SuccessState) {
            members = state.data;
          }

          if (members.isEmpty) {
            return EmError(
              onPressed: () {},
              textAbove: 'Peringkat masih kosong.',
              textBelow: 'Tambah member terlebih dahulu!',
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Peringkat'),
                      Text('Task Selesai'),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: members.length,
                    itemBuilder: (BuildContext context, int index) {
                      return EmCard.leaderboard(
                        onTap: () {
                          Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const MonitorMemberDetailPage(title: 'Detail Member'),
                            ),
                          );
                        },
                        rank: '${index + 1}',
                        image: 'assets/images/avatar_placeholder.png',
                        name: members[index].name,
                        level: '${members[index].level}',
                        taskTotal: '${members[index].taskCompletedMonth}',
                      );
                    },
                  )
              ),
            ],
          )
        );
      }),
    );
  }
}