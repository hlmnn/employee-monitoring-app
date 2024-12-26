import 'package:employee_monitoring_app/component/em_alert_dialog.dart';
import 'package:employee_monitoring_app/component/em_card/em_card.dart';
import 'package:employee_monitoring_app/ui/screen/member/member_reward_detail_page.dart';
import 'package:flutter/material.dart';

class MemberStorePage extends StatefulWidget {
  const MemberStorePage({super.key, required this.title});

  final String title;

  @override
  _MemberStorePageState createState() => _MemberStorePageState();
}

class _MemberStorePageState extends State<MemberStorePage> {
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
            actions: [
              Row(
                children: [
                  Image.asset('assets/images/cash.png', height: 15),
                  const SizedBox(width: 5),
                  const Text('1500',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200, // Maximum width of each item
              crossAxisSpacing: 2, // Spacing between items
              mainAxisSpacing: 2, // Vertical spacing between items
              childAspectRatio: 3 / 4
          ),
          itemCount: 11,
          itemBuilder: (BuildContext context, int index) {
            return EmCard.item(
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) =>
                    const MemberRewardDetailPage(title: 'Detail Reward'),
                  ),
                );
              },
              image: 'assets/images/avatar_placeholder.png',
              name: 'Item Reward Name ke-${index+1}',
              price: 100,
              onPressedButton: (){
                EmAlertDialog.show(context,
                  onConfirm: (){},
                  title: 'Peringatan!',
                  content: 'Reward yang dipilih akan Anda beli. Apakah Anda yakin ingin membeli reward ini?',
                );
              },
            );
          }
        ),
      ),
    );
  }
}