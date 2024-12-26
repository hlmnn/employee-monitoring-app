import 'package:employee_monitoring_app/component/em_alert_dialog.dart';
import 'package:employee_monitoring_app/component/em_button/em_button.dart';
import 'package:employee_monitoring_app/component/em_card/em_card.dart';
import 'package:employee_monitoring_app/ui/screen/monitor/task/monitor_task_edit_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MonitorTaskDetailPage extends StatefulWidget {
  const MonitorTaskDetailPage({super.key, required this.title});

  final String title;

  @override
  _MonitorTaskDetailPageState createState() => _MonitorTaskDetailPageState();
}

class _MonitorTaskDetailPageState extends State<MonitorTaskDetailPage> {
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
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Lorem ipsum dolor sit amet, consectetur elit. Curabitur in purus metus.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Text('Reward',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset('assets/images/cash.png', width: 14),
                            const SizedBox(width: 3),
                            const Text('50'),
                          ],
                        )
                      ],
                    ),
                    const Column(
                      children: [
                        Text('Deadline',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('28 Des 2024'),
                      ],
                    ),
                    Column(
                      children: [
                        const Text('Status',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            border: Border.all(
                              color: Colors.green.shade300, // Border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text('Aktif',
                            style: TextStyle(
                              color: Colors.green
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                EmCard.member(
                  onTap: (){},
                  image: 'assets/images/avatar_placeholder.png',
                  name: 'Hilman Fauzi Herdiana',
                  role: 'Member',
                  level: '10',
                ),
                const SizedBox(height: 10),
                const Text('Deskripsi Tugas',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur in purus metus.'),
                const SizedBox(height: 3),
                const SizedBox(height: 10),
                const Text('Laporan Hasil Tugas',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                const Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur in purus metus. Nullam magna arcu, convallis ac aliquam id, congue a sem. In non egestas mi. Sed sed sem sem. Donec et massa nunc."),
                const SizedBox(height: 10),
                const Text('File Bukti',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  child: ListTile(
                    onTap: () {},
                    title: const Text('Laporan-Hasil-Rapat.pdf'),
                    trailing: const Icon(Icons.download_rounded),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 165,
                        child: EmButton.elevated(
                          onPressed: () {
                            EmAlertDialog.show(context,
                              onConfirm: (){},
                              title: 'Peringatan!',
                              content: 'Task yang dipilih akan Anda hapus. Apakah Anda yakin ingin menghapus task ini?',
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 4,
                            backgroundColor: const Color(0xffDD0000),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          text: 'Hapus',
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.black
                          ),
                          icon: const Icon(Icons.delete, color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 9),
                      SizedBox(
                        width: 165,
                        child: EmButton.elevated(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MonitorTaskEditPage(title: 'Edit Tugas'),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 4,
                            backgroundColor: const Color(0xffFFBD20),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          text: 'Edit',
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.black
                          ),
                          icon: const Icon(Icons.edit, color: Colors.black),
                        ),
                      ),
                    ],
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}