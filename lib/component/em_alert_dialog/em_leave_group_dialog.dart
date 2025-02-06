import 'package:another_flushbar/flushbar.dart';
import 'package:employee_monitoring_app/component/em_button/em_button.dart';
import 'package:employee_monitoring_app/component/em_circular_loading.dart';
import 'package:employee_monitoring_app/data/data_state.dart';
import 'package:employee_monitoring_app/ui/cubit/edit_group_cubit.dart';
import 'package:employee_monitoring_app/ui/screen/member/member_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmLeaveGroupDialog extends StatelessWidget {
  const EmLeaveGroupDialog({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditGroupCubit, DataState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
              child: EmCircularLoading(size: 30, color: Color(0xffFFBD20))
          );
        } else if (state is SuccessState) {
          context.read<EditGroupCubit>().resetState();
          Future.delayed(Duration.zero, () {
            Flushbar(
              message: 'Keluar grup berhasil!',
              flushbarPosition: FlushbarPosition.BOTTOM,
              margin: const EdgeInsets.all(8),
              borderRadius: BorderRadius.circular(10),
              duration: const Duration(seconds: 1),
              isDismissible: false,
            ).show(context).then((_) {
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const MemberNavigation(title: 'Member Navigation'),
                  ), (Route<dynamic> route) => false,
                );
              }
            });
          });
        }
        return  AlertDialog(
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
              onPressed: (){
                context.read<EditGroupCubit>().leaveGroup();
                if (state is ErrorState) {
                  Flushbar(
                    message: state.message,
                    flushbarPosition: FlushbarPosition.BOTTOM,
                    margin: const EdgeInsets.all(8),
                    borderRadius: BorderRadius.circular(10),
                    duration: const Duration(seconds: 2),
                    isDismissible: false,
                  ).show(context);
                  context.read<EditGroupCubit>().resetState();
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

  static Future<void> show(BuildContext context, {
    required String title,
    required String content,
  }) {
    return showDialog(
      context: context,
      builder: (context) => EmLeaveGroupDialog(
        title: title,
        content: content,
      ),
    );
  }
}