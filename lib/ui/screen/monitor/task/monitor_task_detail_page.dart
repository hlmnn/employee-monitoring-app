import 'package:employee_monitoring_app/component/em_alert_dialog/em_delete_task_dialog.dart';
import 'package:employee_monitoring_app/component/em_button/em_button.dart';
import 'package:employee_monitoring_app/component/em_card/em_card.dart';
import 'package:employee_monitoring_app/component/em_circular_loading.dart';
import 'package:employee_monitoring_app/data/data_state.dart';
import 'package:employee_monitoring_app/data/model/task_model.dart';
import 'package:employee_monitoring_app/ui/cubit/task_cubit.dart';
import 'package:employee_monitoring_app/ui/screen/monitor/task/monitor_task_edit_page.dart';
import 'package:employee_monitoring_app/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MonitorTaskDetailPage extends StatefulWidget {
  const MonitorTaskDetailPage({super.key, required this.title, required this.taskId});

  final String title;
  final int taskId;

  @override
  _MonitorTaskDetailPageState createState() => _MonitorTaskDetailPageState();
}

class _MonitorTaskDetailPageState extends State<MonitorTaskDetailPage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TaskCubit>(context).getTaskDetail(widget.taskId);
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
      body: BlocBuilder<TaskCubit, DataState>(
        builder: (context, state) {
          int taskId = 0;
          String title = '';
          int reward = 0;
          String dueDate = '';
          String status = '';
          String description = '';
          String resultReport = '';
          String resultFile = '';
          String memberName = '';
          String memberRole = '';
          int memberLevel = 0;

          if (state is LoadingState) {
            return const Center(
                child: EmCircularLoading(size: 30, color: Color(0xffFFBD20))
            );
          } else if (state is SuccessState) {
            if (state.data is TaskModel) {
              taskId = state.data.id;
              title = state.data.title;
              reward = state.data.reward;
              dueDate = DateFormatter.convertToString(state.data.dueDate);
              state.data.isActive == true ? status = 'Aktif' : status = 'Selesai';
              description = state.data.description;
              resultReport = state.data.resultReport;
              resultFile = state.data.resultFile;
              memberName = state.data.memberCard?.name ?? '';
              state.data.memberCard?.isMonitor == true ? memberRole = 'Monitor' : memberRole = 'Member';
              memberLevel = state.data.memberCard?.level ?? 0;
            }
          }

          return Stack(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                      style: const TextStyle(
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
                                Text('$reward'),
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Deadline',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(dueDate),
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
                                color: status == 'Aktif' ? Colors.green.shade100 : Colors.red.shade100,
                                border: Border.all(
                                  color: status == 'Aktif' ? Colors.green.shade300 : Colors.red.shade300
                                  , // Border color
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(status,
                                style: TextStyle(
                                    color: status == 'Aktif' ? Colors.green : Colors.red,
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
                      name: memberName,
                      role: memberRole,
                      level: '$memberLevel',
                    ),
                    const SizedBox(height: 10),
                    const Text('Deskripsi Tugas',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(description),
                    const SizedBox(height: 3),
                    const SizedBox(height: 10),
                    const Text('Laporan Hasil Tugas',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(resultReport == '' ? 'Laporan kosong.' : resultReport),
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
                        title:Text(resultFile == '' ? 'File kosong.' : resultFile),
                        trailing: const Icon(Icons.download_rounded),
                      ),
                    ),
                    const SizedBox(height: 100),
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
                              EmDeleteTaskDialog.show(context,
                                taskId: widget.taskId,
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
                                  builder: (context) => MonitorTaskEditPage(title: 'Edit Tugas', taskId: taskId),
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
          );
        }
      ),
    );
  }
}