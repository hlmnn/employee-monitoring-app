import 'package:another_flushbar/flushbar.dart';
import 'package:employee_monitoring_app/component/em_button/em_button.dart';
import 'package:employee_monitoring_app/component/em_circular_loading.dart';
import 'package:employee_monitoring_app/data/data_state.dart';
import 'package:employee_monitoring_app/ui/cubit/group_cubit.dart';
import 'package:employee_monitoring_app/ui/screen/member/member_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmJoinGroupDialog extends StatelessWidget {
  EmJoinGroupDialog({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String title;
  final String content;

  final TextEditingController _groupCode = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupCubit, DataState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
                child: EmCircularLoading(size: 30, color: Color(0xffFFBD20))
            );
          } else if (state is SuccessState) {
            context.read<GroupCubit>().resetState();
            Future.delayed(Duration.zero, () {
              Flushbar(
                message: 'Join grup berhasil!',
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
          return AlertDialog(
            title: Text(title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(content),
                const SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _groupCode,
                    validator: (value) {
                      return (value == null || value.isEmpty)
                          ? 'Mohon isi kode grup!'
                          : null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff461902)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'Tulis kode grup',
                      hintStyle: TextStyle(
                        fontSize: 15,
                      ),
                      prefixIcon: Icon(Icons.login),
                    ),
                  ),
                ),
              ],
            ),
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
                  if (_formKey.currentState!.validate()) {
                    context.read<GroupCubit>().joinGroup(_groupCode.text.trim());
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
      builder: (context) => EmJoinGroupDialog(
        title: title,
        content: content,
      ),
    );
  }
}