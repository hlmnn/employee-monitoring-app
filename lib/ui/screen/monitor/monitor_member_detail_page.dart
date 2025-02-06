import 'package:employee_monitoring_app/component/em_card/em_card.dart';
import 'package:employee_monitoring_app/component/em_circular_loading.dart';
import 'package:employee_monitoring_app/data/data_state.dart';
import 'package:employee_monitoring_app/data/model/task_model.dart';
import 'package:employee_monitoring_app/data/model/user_model.dart';
import 'package:employee_monitoring_app/ui/cubit/profile_cubit.dart';
import 'package:employee_monitoring_app/ui/screen/monitor/task/monitor_task_detail_page.dart';
import 'package:employee_monitoring_app/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MonitorMemberDetailPage extends StatefulWidget {
  const MonitorMemberDetailPage({super.key, required this.title, required this.memberId});

  final String title;
  final String memberId;

  @override
  _MonitorMemberDetailPageState createState() => _MonitorMemberDetailPageState();
}

class _MonitorMemberDetailPageState extends State<MonitorMemberDetailPage> {

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfileCubit>(context).getMemberDetail(widget.memberId);
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
      body: BlocBuilder<ProfileCubit, DataState>(
        builder: (context, state) {
          List<TaskCardModel> tasks = [];
          String name = '';
          int level = 0;
          String phone = '';
          String role = '';
          String address = '';
          if (state is LoadingState) {
            return const Center(
                child: EmCircularLoading(size: 30, color: Color(0xffFFBD20))
            );
          } else if (state is SuccessState) {
            if (state.data is AuthUserModel) {
              name = state.data.name;
              level = state.data.level;
              phone = state.data.phone;
              state.data.isMonitor == true ? role = 'Monitor' : role = 'Member';
              address = state.data.address;
              tasks = state.data.tasks;
            }
          }

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/avatar_placeholder.png'),
                      radius: 40,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(name,
                                  style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Lv.',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '$level',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(phone),
                              Text(role),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(address,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Icon(Icons.list, color: Colors.black),
                    SizedBox(width: 5),
                    Text('Daftar Task',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                  ],
                ),

                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: tasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      return EmCard.task(
                        onTap: () {
                          Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context) => MonitorTaskDetailPage(title: 'Detail Tugas', taskId: tasks[index].id,),
                            ),
                          );
                        },
                        image: 'assets/images/avatar_placeholder.png',
                        title: tasks[index].title,
                        name: tasks[index].member?.name,
                        level: '${tasks[index].member?.level}',
                        date: DateFormatter.convertToString(tasks[index].dueDate),
                        cash: '${tasks[index].reward}',
                        experience: '${tasks[index].experience}',
                      );
                    },
                  )
                ),
              ],
            ),
          );
        }
      ),
    );
  }

}