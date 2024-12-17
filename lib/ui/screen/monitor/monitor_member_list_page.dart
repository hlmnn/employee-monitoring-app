import 'package:employee_monitoring_app/component/em_alert_dialog.dart';
import 'package:employee_monitoring_app/component/em_card/em_card_member.dart';
import 'package:flutter/material.dart';

class MonitorMemberListPage extends StatefulWidget {
  const MonitorMemberListPage({super.key, required this.title});

  final String title;

  @override
  _MonitorMemberListPageState createState() => _MonitorMemberListPageState();
}

class _MonitorMemberListPageState extends State<MonitorMemberListPage> {

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
    members.sort((a, b) => a.name.compareTo(b.name)); // sort by name
    members.sort((b, a) => a.role.compareTo(b.role)); // sort by role so monitor is on top
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 1),
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
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: members.length,
            itemBuilder: (BuildContext context, int index) {
              return EmCardMember(
                onTap: (){},
                image: 'assets/images/avatar_placeholder.png',
                name: members[index].name,
                role: members[index].role,
                level: members[index].level,
                onPressedDelete: (){
                  EmAlertDialog.show(context,
                    onConfirm: (){},
                    textHeading: 'Peringatan!',
                    textSubtitle: 'Member yang dipilih akan Anda keluarkan. Apakah Anda yakin ingin mengeluarkan member ini?',
                  );
                },
                isMonitor: true,
              );
            }
        ),
      ),
    );
  }
}

class Member {
  int id;
  String name;
  String role;
  String level;

  Member(this.id, this.name,this.role, this.level);
}