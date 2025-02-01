import 'package:another_flushbar/flushbar.dart';
import 'package:employee_monitoring_app/component/em_button/em_button.dart';
import 'package:employee_monitoring_app/component/em_circular_loading.dart';
import 'package:employee_monitoring_app/data/data_state.dart';
import 'package:employee_monitoring_app/ui/cubit/group_cubit.dart';
import 'package:employee_monitoring_app/ui/screen/monitor/monitor_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmCreateGroupDialog extends StatelessWidget {
  EmCreateGroupDialog({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String title;
  final String content;

  final TextEditingController _groupName = TextEditingController();
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
          print('create group: ${state.data}');
          context.read<GroupCubit>().resetState();
          Future.delayed(Duration.zero, () {
            Flushbar(
              message: 'Grup berhasil dibuat!',
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
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(content),
              const SizedBox(height: 10),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _groupName,
                  validator: (value) {
                    return (value == null || value.isEmpty)
                        ? 'Mohon isi Nama Server!'
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
                    hintText: 'Tulis nama grup',
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
                  context.read<GroupCubit>().createGroup(_groupName.text.trim());
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
      builder: (context) => EmCreateGroupDialog(
        title: title,
        content: content,
      ),
    );
  }
}