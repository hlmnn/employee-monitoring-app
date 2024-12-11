import 'package:flutter/material.dart';

class EmButton extends StatelessWidget {
  const EmButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.isExpand = true,
  }) : super(key: key);

  final GestureTapCallback onPressed;
  final String text;
  final bool isExpand;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isExpand ? double.infinity : null,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 4,
          backgroundColor: const Color(0xffFFBD20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(text,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Colors.black
          ),
        ),
      ),
    );
  }
}
