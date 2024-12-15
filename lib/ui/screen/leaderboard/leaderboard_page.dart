import 'package:employee_monitoring_app/component/em_card/em_card_leaderboard.dart';
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
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0)),
                  color: Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x33000000),
                        offset: Offset(0, 2),
                        blurRadius: 4
                    ),
                  ]
              ),
            ),
            AppBar(
              title: Text(widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              backgroundColor: const Color(0xffFFBD20),
            ),
          ]
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  itemCount: 12,
                  itemBuilder: (BuildContext context, int index) {
                    return EmCardLeaderboard(
                      onTap: (){},
                      rank: '${index+1}',
                      image: 'assets/images/avatar_placeholder.png',
                      name: 'John Doe Hidayat',
                      level: '10',
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