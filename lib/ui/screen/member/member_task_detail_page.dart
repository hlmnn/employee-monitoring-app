import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:employee_monitoring_app/component/em_button/em_button.dart';
import 'package:employee_monitoring_app/component/em_card/em_card.dart';
import 'package:employee_monitoring_app/component/em_circular_loading.dart';
import 'package:employee_monitoring_app/data/data_state.dart';
import 'package:employee_monitoring_app/data/model/task_model.dart';
import 'package:employee_monitoring_app/ui/cubit/task_cubit.dart';
import 'package:employee_monitoring_app/ui/screen/member/member_navigation.dart';
import 'package:employee_monitoring_app/utils/date_formatter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberTaskDetailPage extends StatefulWidget {
  const MemberTaskDetailPage({super.key, required this.title, required this.taskId});

  final String title;
  final int taskId;

  @override
  _MemberTaskDetailPageState createState() => _MemberTaskDetailPageState();
}

class _MemberTaskDetailPageState extends State<MemberTaskDetailPage> {
  final TextEditingController _taskReportDescription = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FilePickerResult? result;
  File? fileResult;
  String? fileName;

  void _pickFile() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      fileResult = File(result!.files.single.path!);
      setState(() {
        fileName = result!.files.single.name;
      });
    } else {
      throw Exception("No file selected!");
    }
  }

  void _downloadFile() async {}

  @override
  void dispose() {
    _taskReportDescription.dispose();
    super.dispose();
  }

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
          String title = '';
          int reward = 0;
          int experience = 0;
          String dueDate = '';
          String status = '';
          String description = '';
          String memberName = '';
          String memberRole = '';
          int memberLevel = 0;
          bool isActive = false;

          if (state is LoadingState) {
            return const Center(
                child: EmCircularLoading(size: 30, color: Color(0xffFFBD20))
            );
          } else if (state is SuccessState) {
            if (state.data is TaskModel) {
              title = state.data.title;
              reward = state.data.reward;
              experience = state.data.experience;
              dueDate = DateFormatter.convertToString(state.data.dueDate);
              state.data.isActive == true ? status = 'Aktif' : status = 'Selesai';
              description = state.data.description;
              memberName = state.data.memberCard?.name ?? '';
              state.data.memberCard?.isMonitor == true ? memberRole = 'Monitor' : memberRole = 'Member';
              memberLevel = state.data.memberCard?.level ?? 0;
              isActive = state.data.isActive;
              if (_taskReportDescription.text.isEmpty) {
                _taskReportDescription.text = state.data.resultReport;
              }
            } else if (state.data is bool) {
              context.read<TaskCubit>().resetState();
              Future.delayed(Duration.zero, () {
                if (context.mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const MemberNavigation(title: 'Member Navigation'),
                    ), (Route<dynamic> route) => false,
                  );
                }
              });
            }
          }

          return Stack(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
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
                                  fontSize: 15,
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
                                  fontSize: 15,
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
                                child: Text(status,
                                  style: const TextStyle(
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
                        name: memberName,
                        role: memberRole,
                        level: '$memberLevel',
                      ),
                      const SizedBox(height: 10),
                      const Text('Deskripsi Tugas',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(description),
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
                          onTap: () {
                            isActive == true ? _pickFile() : _downloadFile();
                          },
                          title: Text(fileName ?? 'Pilih file...',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Icon(isActive == true ? Icons.upload : Icons.download),
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
                        readOnly: !isActive,
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
              isActive != true
                ? const SizedBox.shrink()
                : Align(
                  alignment: Alignment.bottomCenter,
                  child: Theme(
                    data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: EmButton.elevated(
                        onPressed: () {
                          if (fileResult == null) {
                            Flushbar(
                              message: 'Mohon upload File Bukti!',
                              flushbarPosition: FlushbarPosition.BOTTOM,
                              margin: const EdgeInsets.all(8),
                              borderRadius: BorderRadius.circular(10),
                              duration: const Duration(seconds: 1),
                              isDismissible: false,
                            ).show(context);
                          }

                          if (_formKey.currentState!.validate() && (fileResult != null)) {
                            context.read<TaskCubit>().updateTaskMember(
                              widget.taskId,
                              reward,
                              experience,
                              _taskReportDescription.text.trim(),
                              fileName!.replaceAll(' ', '-'),
                              fileResult!,
                            );
                          }
                          if (state is ErrorState) {
                            Flushbar(
                              message: state.message,
                              flushbarPosition: FlushbarPosition.BOTTOM,
                              margin: const EdgeInsets.all(8),
                              borderRadius: BorderRadius.circular(10),
                              duration: const Duration(seconds: 1),
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
          );
        }
      ),
    );
  }
}