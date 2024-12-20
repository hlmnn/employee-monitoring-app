import 'package:employee_monitoring_app/component/em_card/em_card.dart';
import 'package:employee_monitoring_app/component/em_error.dart';
import 'package:employee_monitoring_app/data/model/user_model.dart';
import 'package:employee_monitoring_app/ui/screen/monitor/monitor_member_detail_page.dart';
import 'package:flutter/material.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key, required this.title});

  final String title;

  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage>{

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
              child: members.any((member) => member.role == 'Member')
                ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: members.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (members[index].role != 'Member') return const SizedBox.shrink();
                    return EmCard.leaderboard(
                      onTap: () {
                        Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const MonitorMemberDetailPage(title: 'Detail Member'),
                          ),
                        );
                      },
                      rank: '${members.where((member) => member.role == 'Member').toList().indexOf(members[index]) + 1}',
                      image: 'assets/images/avatar_placeholder.png',
                      name: members[index].name,
                      level: members[index].level,
                      taskTotal: '${30 - (index * 2 + 5)}',
                    );
                  },
                )
              : EmError(
                onPressed: (){},
                textAbove: 'Peringkat progress masih kosong.',
                textBelow: 'Tambah member terlebih dahulu!',
              ),
            ),
          ],
        )
      ),
    );
  }
}