import 'package:flutter/material.dart';

class EmCircularLoading extends StatelessWidget {
  const EmCircularLoading({
    Key? key,
    required this.size,
    required this.color,
  }) : super(key: key);

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(2.0),
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: 3,
      ),
    );
  }
}
