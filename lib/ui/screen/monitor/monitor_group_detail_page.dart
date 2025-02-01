import 'package:another_flushbar/flushbar.dart';
import 'package:employee_monitoring_app/component/em_alert_dialog.dart';
import 'package:employee_monitoring_app/component/em_alert_dialog/em_create_group_dialog.dart';
import 'package:employee_monitoring_app/component/em_card/em_card.dart';
import 'package:employee_monitoring_app/component/em_circular_loading.dart';
import 'package:employee_monitoring_app/data/data_state.dart';
import 'package:employee_monitoring_app/data/model/group_model.dart';
import 'package:employee_monitoring_app/data/model/user_model.dart';
import 'package:employee_monitoring_app/ui/cubit/group_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MonitorGroupDetailPage extends StatefulWidget {
  const MonitorGroupDetailPage({super.key, required this.title});

  final String title;

  @override
  _MonitorGroupDetailPageState createState() => _MonitorGroupDetailPageState();
}

class _MonitorGroupDetailPageState extends State<MonitorGroupDetailPage> {


  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GroupCubit>(context).getGroupDetail();
    return Scaffold(
      body: BlocBuilder<GroupCubit, DataState>(
        builder: (context, state) {
          String groupName = '';
          String groupCode = '';
          int memberCount = 0;
          List<AuthUserModel> members = [];

          if (state is LoadingState) {
            return const Center(
                child: EmCircularLoading(size: 30, color: Color(0xffFFBD20))
            );
          } else if (state is SuccessState) {
            if (state.data is GroupModel) {
              groupName = state.data.name;
              groupCode = state.data.groupCode;
              memberCount = state.data.memberCount;
              members = state.data.members;
            }
          }

          return NestedScrollView(
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
                actions: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.black),
                    tooltip: 'Edit Group',
                    onPressed: () {
                      EmCreateGroupDialog.show(
                        context,
                        title: 'Edit Server',
                        content: 'Edit nama server sesuai yang Anda inginkan',
                      );
                    },
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right:20, top: 10, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Nama Group'),
                                Text(groupName,
                                  style: const TextStyle(
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
                                  Text(groupCode,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  InkWell(
                                    onTap: () async {
                                      await Clipboard.setData(ClipboardData(text: groupCode)).then((result) {
                                        Flushbar(
                                          message: 'Kode grup berhasil disalin!',
                                          flushbarPosition: FlushbarPosition.BOTTOM,
                                          margin: const EdgeInsets.all(8),
                                          borderRadius: BorderRadius.circular(10),
                                          duration: const Duration(seconds: 2),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('Member'),
                              Text('$memberCount',
                                style: const TextStyle(
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
                  role: members[index].isMonitor == true ? 'Monitor' : 'Member',
                  level: '${members[index].level}',
                  onPressedButton: (){
                    EmAlertDialog.show(context,
                      onConfirm: () {
                        BlocBuilder<GroupCubit, DataState>(
                          builder: (context, state) {
                            context.read<GroupCubit>().removeUserFromGroup(members[index].id);
                            if (state is ErrorState) {
                              Flushbar(
                                message: state.message,
                                flushbarPosition: FlushbarPosition.BOTTOM,
                                margin: const EdgeInsets.all(8),
                                borderRadius: BorderRadius.circular(10),
                                duration: const Duration(seconds: 3),
                                isDismissible: false,
                              ).show(context);
                              context.read<GroupCubit>().resetState();
                            } else if (state is SuccessState) {
                              Flushbar(
                                message: 'Profile berhasil diubah!',
                                flushbarPosition: FlushbarPosition.BOTTOM,
                                margin: const EdgeInsets.all(8),
                                borderRadius: BorderRadius.circular(10),
                                duration: const Duration(seconds: 3),
                                isDismissible: false,
                              ).show(context);
                              Future.delayed(const Duration(seconds: 1), () {
                                BlocProvider.of<GroupCubit>(context).getGroupDetail();
                                Navigator.pop(context);
                              });
                              context.read<GroupCubit>().resetState();
                            }
                            return const SizedBox.shrink();
                          }
                        );
                      },
                      title: 'Peringatan!',
                      content: 'Member yang dipilih akan Anda keluarkan. Apakah Anda yakin ingin mengeluarkan member ini?',
                    );
                  },
                  isMonitor: true,
                );
              }
          ),
        );
      }),
    );
  }
}