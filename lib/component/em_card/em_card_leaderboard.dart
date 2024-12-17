import 'package:flutter/material.dart';

class EmCardLeaderboard extends StatelessWidget {
  const EmCardLeaderboard({
    Key? key,
    required this.onTap,
    this.image,
    this.name,
    this.level,
    this.rank,
    this.taskTotal,
    this.isMonitor = false,
  }) : super(key: key);

  final GestureTapCallback onTap;
  final String? image;
  final String? name;
  final String? level;
  final String? rank;
  final String? taskTotal;
  final bool isMonitor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              RichText(
                text: TextSpan(
                  text: '#',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: rank!,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    )
                  ]
                ),
              ),
              const SizedBox(width: 10),
              CircleAvatar(
                backgroundImage: AssetImage(image!),
                radius: 23,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text('Lv.$level'),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(
                taskTotal!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}