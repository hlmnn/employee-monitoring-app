import 'package:another_flushbar/flushbar.dart';
import 'package:employee_monitoring_app/component/em_button/em_button.dart';
import 'package:employee_monitoring_app/component/em_card/em_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MemberTaskDetailPage extends StatefulWidget {
  const MemberTaskDetailPage({super.key, required this.title});

  final String title;

  @override
  _MemberTaskDetailPageState createState() => _MemberTaskDetailPageState();
}

class _MemberTaskDetailPageState extends State<MemberTaskDetailPage> {
  final TextEditingController _taskReportDescription = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _taskReportDescription.dispose();
    super.dispose();
  }

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
            child: Form(
              key: _formKey,
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
                              fontSize: 15,
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
                              fontSize: 15,
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
                              fontSize: 15,
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
                      fontSize: 15,
                    ),
                  ),
                  const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur in purus metus.'),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Text('File Bukti',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.black54,
                      ),
                    ),
                    child: ListTile(
                      onTap: () {},
                      title: const Text('Pilih file...',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: const Icon(Icons.upload),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Text('Laporan Hasil Tugas',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  TextFormField(
                    controller: _taskReportDescription,
                    validator: (value) {
                      return (value == null || value.isEmpty)
                          ? 'Mohon isi Laporan Tugas!'
                          : null;
                    },
                    maxLines: 7,
                    maxLength: 300,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff461902),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'Tulis laporan tugas...',
                      hintStyle: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
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
                    if (_formKey.currentState!.validate()) {
                      Flushbar(
                        message: 'Tugas selesai berhasil dikirim!',
                        flushbarPosition: FlushbarPosition.BOTTOM,
                        margin: const EdgeInsets.all(8),
                        borderRadius: BorderRadius.circular(10),
                        duration: const Duration(seconds: 3),
                        isDismissible: false,
                      ).show(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    backgroundColor: const Color(0xffFFBD20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  text: 'Selesai',
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