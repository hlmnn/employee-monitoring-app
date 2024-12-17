import 'package:employee_monitoring_app/component/em_card/em_card.dart';
import 'package:employee_monitoring_app/component/em_card/em_card_leaderboard.dart';
import 'package:employee_monitoring_app/ui/screen/monitor/monitor_member_list_page.dart';
import 'package:flutter/material.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key, required this.title});

  final String title;

  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage>{

  List<Member> members = [
    Member(1,'Alice', 'Member', '20'),
    Member(2,'David', 'Member', '12'),
    Member(3,'Ryan Ahmad Gosling', 'Monitor', '5'),
    Member(4,'Zendaya', 'Member', '10'),
    Member(5,'Broski', 'Member', '22'),
    Member(6,'Sigma', 'Member', '8'),
    Member(7,'Chad', 'Member', '15'),
    Member(8,'Hilman Fauzi Herdiana aaaaaaaaaaaa', 'Member', '19'),
    Member(9,'Fauzi', 'Member', '3'),
    Member(10,'Ahmad', 'Member', '7'),
    Member(11,'John Doe Hidayat', 'Member', '17'),
  ];

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
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: members.length,
                  itemBuilder: (BuildContext context, int index) {
                    return EmCard.leaderboard(
                      onTap: (){},
                      rank: '${index+1}',
                      image: 'assets/images/avatar_placeholder.png',
                      name: members[index].name,
                      level: members[index].level,
                      taskTotal: '${30-(index*2+5)}',
                    );
                  }
              ),
            ),
          ],
        )
      ),
    );
  }
}