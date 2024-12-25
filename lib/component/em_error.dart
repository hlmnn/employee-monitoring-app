import 'package:employee_monitoring_app/component/em_button/em_button.dart';
import 'package:flutter/material.dart';

class EmError extends StatelessWidget{
  const EmError({
    Key? key,
    required this.onPressed,
    required this.textAbove,
    required this.textBelow,
    this.isButton = false,
  }) : super(key: key);

  final GestureTapCallback onPressed;
  final String textAbove;
  final String textBelow;
  final bool? isButton;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Image.asset(
              'assets/images/404.png',
              width: 180,
              height: 180,
            ),
          ),
          Text(
            textAbove,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            textBelow,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          isButton == true
            ? EmButton.elevated(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                elevation: 4,
                backgroundColor: const Color(0xffFFBD20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              text: 'Buat Server',
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.black
              ),
              isExpand: false,
            )
          : const SizedBox.shrink(),
        ],
      ),
    );
  }

}