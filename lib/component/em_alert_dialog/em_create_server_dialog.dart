import 'package:employee_monitoring_app/component/em_button/em_button.dart';
import 'package:flutter/material.dart';

class EmCreateServerDialog extends StatelessWidget {
  EmCreateServerDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.onConfirm,
  }) : super(key: key);

  final String title;
  final String content;
  final GestureTapCallback onConfirm;

  final TextEditingController _serverCodeOrName = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
              controller: _serverCodeOrName,
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
                hintText: 'Tulis nama server',
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

  /// Static method to display the dialog easily
  static Future<void> show(BuildContext context, {
    required String title,
    required String content,
    required GestureTapCallback onConfirm,
  }) {
    return showDialog(
      context: context,
      builder: (context) => EmCreateServerDialog(
        title: title,
        content: content,
        onConfirm: onConfirm,
      ),
    );
  }
}