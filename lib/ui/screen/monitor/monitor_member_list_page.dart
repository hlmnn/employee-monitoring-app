import 'package:employee_monitoring_app/component/em_alert_dialog.dart';
import 'package:employee_monitoring_app/component/em_card/em_card.dart';
import 'package:employee_monitoring_app/data/model/user_model.dart';
import 'package:flutter/material.dart';

class MonitorMemberListPage extends StatefulWidget {
  const MonitorMemberListPage({super.key, required this.title});

  final String title;

  @override
  _MonitorMemberListPageState createState() => _MonitorMemberListPageState();
}

class _MonitorMemberListPageState extends State<MonitorMemberListPage> {

  Future<void> sortList() async {
    members.sort((a, b) => a.name.compareTo(b.name)); // sort by name
    members.sort((b, a) => a.role.compareTo(b.role)); // sort by role so monitor is on top
  }

  @override
  Widget build(BuildContext context) {
    sortList();
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
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: members.length,
            itemBuilder: (BuildContext context, int index) {
              return EmCard.member(
                onTap: (){},
                image: 'assets/images/avatar_placeholder.png',
                name: members[index].name,
                role: members[index].role,
                level: members[index].level,
                onPressedDelete: (){
                  EmAlertDialog.show(context,
                    onConfirm: (){},
                    title: 'Peringatan!',
                    content: 'Member yang dipilih akan Anda keluarkan. Apakah Anda yakin ingin mengeluarkan member ini?',
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