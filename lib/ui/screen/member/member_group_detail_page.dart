import 'package:another_flushbar/flushbar.dart';
import 'package:employee_monitoring_app/component/em_card/em_card.dart';
import 'package:employee_monitoring_app/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MemberGroupDetailPage extends StatefulWidget {
  const MemberGroupDetailPage({super.key, required this.title});

  final String title;

  @override
  _MemberGroupDetailPageState createState() => _MemberGroupDetailPageState();
}

class _MemberGroupDetailPageState extends State<MemberGroupDetailPage> {

  Future<void> sortList() async {
    members.sort((a, b) => a.name.compareTo(b.name)); // sort by name
    members.sort((b, a) => a.role.compareTo(b.role)); // sort by role so monitor is on top
  }

  @override
  Widget build(BuildContext context) {
    sortList();
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget> [
            SliverAppBar(
              title: Text(widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              pinned: true,
              forceElevated: innerBoxIsScrolled,
              backgroundColor: const Color(0xffFFBD20),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.only(left: 20, right:20, top: 10, bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Nama Group'),
                              Text('PDIP Demokrat Golkar Gerindra PKB PPPPP',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Kode Invite Group'),
                            Row(
                              children: [
                                const Text('DDXFSQ6F',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17
                                  ),
                                ),
                                const SizedBox(width: 10),
                                InkWell(
                                  onTap: () async {
                                    await Clipboard.setData(ClipboardData(text: "DDXFSQ6F")).then((result) {
                                      Flushbar(
                                        message: 'Kode grup berhasil disalin!',
                                        flushbarPosition: FlushbarPosition.BOTTOM,
                                        margin: const EdgeInsets.all(8),
                                        borderRadius: BorderRadius.circular(10),
                                        duration: const Duration(seconds: 3),
                                        isDismissible: false,
                                      ).show(context);
                                    });
                                  },
                                  child: const Icon(Icons.copy, size: 18),
                                )
                              ],
                            ),
                          ],
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Member'),
                            Text('10',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: ListView.builder(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
          scrollDirection: Axis.vertical,
          itemCount: members.length,
          itemBuilder: (BuildContext context, int index) {
            return EmCard.member(
              onTap: (){},
              image: 'assets/images/avatar_placeholder.png',
              name: members[index].name,
              role: members[index].role,
              level: members[index].level,
            );
          }
        ),
      ),
    );
  }
}