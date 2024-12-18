import 'package:employee_monitoring_app/data/model/achievement_model.dart';
import 'package:flutter/material.dart';

class AchievementPage extends StatefulWidget {
  const AchievementPage({super.key, required this.title});

  final String title;

  @override
  _AchievementPageState createState() => _AchievementPageState();
}

class _AchievementPageState extends State<AchievementPage> {

  List<AchievementModel> achievements = [
    AchievementModel(
      'assets/images/app_logo.png',
      'Menyelesaikan Tugas Pertama Kali',
      'Anda telah menyelesaikan tugas untuk pertama kalinya!',
      100,
      1,
    ),
    AchievementModel(
      'assets/images/app_logo.png',
      'Selesaikan Tugas 3 Kali',
      'Anda telah menyelesaikan tugas sebanyak 3 kali!',
      100,
      3,
    ),
    AchievementModel(
      'assets/images/app_logo.png',
      'Selesaikan Tugas 5 Kali',
      'Anda telah menyelesaikan tugas sebanyak 5 kali!',
      100,
      5,
    ),
    AchievementModel(
      'assets/images/app_logo.png',
      'Selesaikan Tugas 10 Kali',
      'Anda telah menyelesaikan tugas sebanyak 10 kali!',
      100,
      10,
    ),
    AchievementModel(
      'assets/images/app_logo.png',
      'Selesaikan Tugas 25 Kali',
      'Anda telah menyelesaikan tugas sebanyak 25 kali!',
      100,
      25,
    ),
    AchievementModel(
      'assets/images/app_logo.png',
      'Capai Level Berikutnya Pertama Kali',
      'Anda telah mencapai level berikutnya untuk pertama kalinya!',
      2,
      100,
    ),
    AchievementModel(
      'assets/images/app_logo.png',
      'Capai Level 3',
      'Anda telah mencapai level 3 pertama kalinya!',
      3,
      100,
    ),
    AchievementModel(
      'assets/images/app_logo.png',
      'Capai Level 5',
      'Anda telah mencapai level 5 pertama kalinya!',
      5,
      100,
    ),
    AchievementModel(
      'assets/images/app_logo.png',
      'Capai Level 10',
      'Anda telah mencapai level 10 pertama kalinya!',
      10,
      100,
    ),
    AchievementModel(
      'assets/images/app_logo.png',
      'Capai Level 25',
      'Anda telah mencapai level 25 pertama kalinya!',
      25,
      100,
    ),
    AchievementModel(
      'assets/images/app_logo.png',
      'Capai Level 50',
      'Anda telah mencapai level 50 pertama kalinya!',
      50,
      100,
    ),
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: achievements.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == achievements.length-1) {
                return ListTile(
                  leading: Image.asset(achievements[index].image, width: 50),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(achievements[index].title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(achievements[index].description,
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  child: ListTile(
                    leading: Image.asset(achievements[index].image, width: 50),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(achievements[index].title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(achievements[index].description,
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }
          ),
        ),
      )
    );
  }
}