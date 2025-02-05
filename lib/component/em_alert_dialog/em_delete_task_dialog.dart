import 'package:another_flushbar/flushbar.dart';
import 'package:employee_monitoring_app/component/em_button/em_button.dart';
import 'package:employee_monitoring_app/component/em_circular_loading.dart';
import 'package:employee_monitoring_app/data/data_state.dart';
import 'package:employee_monitoring_app/ui/cubit/create_task_cubit.dart';
import 'package:employee_monitoring_app/ui/screen/monitor/monitor_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmDeleteTaskDialog extends StatelessWidget {
  const EmDeleteTaskDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.taskId,
  }) : super(key: key);

  final String title;
  final String content;
  final int taskId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTaskCubit, DataState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
              child: EmCircularLoading(size: 30, color: Color(0xffFFBD20))
          );
        } else if (state is SuccessState) {
          context.read<CreateTaskCubit>().resetState();
          Future.delayed(Duration.zero, () {
            Flushbar(
              message: 'Tugas berhasil dihapus!',
              flushbarPosition: FlushbarPosition.BOTTOM,
              margin: const EdgeInsets.all(8),
              borderRadius: BorderRadius.circular(10),
              duration: const Duration(seconds: 1),
              isDismissible: false,
            ).show(context).then((_) {
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const MonitorNavigation(title: 'Monitor Navigation'),
                  ), (Route<dynamic> route) => false,
                );
              }
            });
          });
        }
        return AlertDialog(
          title: Text(title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(content),
          actions: [
            EmButton.elevated(
              onPressed: (){
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                elevation: 4,
                backgroundColor: const Color(0xffFFF3C6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              text: 'Tidak',
              textStyle: const TextStyle(color: Color(0xffDD7402), fontWeight: FontWeight.bold),
              isExpand: false,
            ),
            EmButton.elevated(
              onPressed: () {
                context.read<CreateTaskCubit>().deleteTask(taskId);
                if (state is ErrorState) {
                  Flushbar(
                    message: state.message,
                    flushbarPosition: FlushbarPosition.BOTTOM,
                    margin: const EdgeInsets.all(8),
                    borderRadius: BorderRadius.circular(10),
                    duration: const Duration(seconds: 2),
                    isDismissible: false,
                  ).show(context);
                  context.read<CreateTaskCubit>().resetState();
                }
              },
              style: ElevatedButton.styleFrom(
                elevation: 4,
                backgroundColor: const Color(0xffFFBD20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              text: 'Ya',
              textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              isExpand: false,
            ),
          ],
        );
      }
    );
  }

  /// Static method to display the dialog easily
  static Future<void> show(BuildContext context, {
    required String title,
    required String content,
    required int taskId,
  }) {
    return showDialog(
      context: context,
      builder: (context) => EmDeleteTaskDialog(
        title: title,
        content: content,
        taskId: taskId,
      ),
    );
  }
}