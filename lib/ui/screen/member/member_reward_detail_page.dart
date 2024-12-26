import 'package:employee_monitoring_app/component/em_alert_dialog.dart';
import 'package:employee_monitoring_app/component/em_button/em_button.dart';
import 'package:employee_monitoring_app/ui/screen/monitor/store/monitor_reward_edit_page.dart';
import 'package:flutter/material.dart';

class MemberRewardDetailPage extends StatefulWidget {
  const MemberRewardDetailPage({super.key, required this.title});

  final String title;

  @override
  _MemberRewardDetailPageState createState() => _MemberRewardDetailPageState();
}

class _MemberRewardDetailPageState extends State<MemberRewardDetailPage> {

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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/avatar_placeholder.png',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Text('Nama Reward skdjosdk sjsdjkds idsjids sdij',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Image.asset('assets/images/cash.png', width: 20),
                              const SizedBox(width: 3),
                              const Text('100',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text('Deskripsi Reward',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur in purus metus. Nullam magna arcu, convallis ac aliquam id, congue a sem. In non egestas mi. Sed sed sem sem. Donec et massa nunc."),
                      const SizedBox(height: 150),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Theme(
              data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
              child: Container(
                padding: const EdgeInsets.all(20),
                child: EmButton.elevated(
                  onPressed: () {
                    EmAlertDialog.show(context,
                      onConfirm: (){},
                      title: 'Peringatan!',
                      content: 'Reward yang dipilih akan Anda beli. Apakah Anda yakin ingin membeli reward ini?',
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    backgroundColor: const Color(0xffFFBD20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  text: 'Beli Reward',
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.black
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}