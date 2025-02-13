import 'package:employee_monitoring_app/component/em_alert_dialog/em_create_group_dialog.dart';
import 'package:employee_monitoring_app/component/em_card/em_card.dart';
import 'package:employee_monitoring_app/component/em_circular_loading.dart';
import 'package:employee_monitoring_app/component/em_error.dart';
import 'package:employee_monitoring_app/data/data_state.dart';
import 'package:employee_monitoring_app/data/model/task_model.dart';
import 'package:employee_monitoring_app/ui/cubit/task_list_cubit.dart';
import 'package:employee_monitoring_app/ui/screen/monitor/task/monitor_task_detail_page.dart';
import 'package:employee_monitoring_app/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MonitorHomeActiveTaskPage extends StatefulWidget {
  const MonitorHomeActiveTaskPage({super.key, required this.title, required this.isJoinServer});

  final String title;
  final bool isJoinServer;

  @override
  _MonitorHomeActiveTaskPageState createState() => _MonitorHomeActiveTaskPageState();
}

class _MonitorHomeActiveTaskPageState extends State<MonitorHomeActiveTaskPage> {

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TaskListCubit>(context).getTaskActive();

    if (widget.isJoinServer == false) {
      return EmError(
        onPressed: () {
          EmCreateGroupDialog.show(
            context,
            title: 'Buat Grup',
            content: 'Tulis nama grup sesuai yang Anda inginkan',
          );
        },
        textAbove: 'Anda belum mempunyai grup.',
        textBelow: 'Buat grup terlebih dahulu!',
        isButton: true,
      );
    }

    return BlocBuilder<TaskListCubit, DataState>(
      builder: (context, state) {
        List<TaskCardModel> tasks = [];
        if (state is LoadingState) {
          return const Center(
              child: EmCircularLoading(size: 30, color: Color(0xffFFBD20))
          );
        } else if (state is SuccessState) {
          tasks = state.data;
        }

        if (tasks.isEmpty) {
          return EmError(
            onPressed: () {},
            textAbove: 'Anda belum mempunyai tugas.',
            textBelow: 'Buat tugas terlebih dahulu!',
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          scrollDirection: Axis.vertical,
          itemCount: tasks.length,
          itemBuilder: (BuildContext context, int index) {
            return EmCard.task(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MonitorTaskDetailPage(title: 'Detail Tugas', taskId: tasks[index].id),
                  ),
                );
              },
              image: 'assets/images/avatar_placeholder.png',
              title: tasks[index].title,
              name: tasks[index].member?.name ?? 'null',
              level: '${(tasks[index].member?.level) ?? 0}' ,
              date: DateFormatter.convertToString(tasks[index].dueDate),
              cash: '${tasks[index].reward}',
              experience: '${tasks[index].experience}',
            );
          },
        );
    });
  }
}