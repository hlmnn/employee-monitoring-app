import 'package:employee_monitoring_app/component/em_button/em_button.dart';
import 'package:flutter/material.dart';

class EmAlertDialog extends StatelessWidget {
  const EmAlertDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.onConfirm,
  }) : super(key: key);

  final String title;
  final String content;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
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
          onPressed: onConfirm,
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
    required VoidCallback onConfirm,
  }) {
    return showDialog(
      context: context,
      builder: (context) => EmAlertDialog(
        title: title,
        content: content,
        onConfirm: onConfirm,
      ),
    );
  }
}