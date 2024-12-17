import 'package:employee_monitoring_app/component/em_button/em_button.dart';
import 'package:flutter/material.dart';

import 'type_card.dart';

class EmCard extends StatelessWidget {
  const EmCard.member({
    Key? key,
    required this.onTap,
    this.onPressedDelete,
    this.image,
    this.name,
    this.role,
    this.level,
    this.rank,
    this.taskTotal,
    this.isMonitor = false,
  }) : _type = TypeCard.member,
        super(key: key);
  const EmCard.leaderboard({
    Key? key,
    required this.onTap,
    this.onPressedDelete,
    this.image,
    this.name,
    this.role,
    this.level,
    this.rank,
    this.taskTotal,
    this.isMonitor = false,
  }) : _type = TypeCard.leaderboard,
        super(key: key);

  final TypeCard? _type;
  final GestureTapCallback onTap;
  final GestureTapCallback? onPressedDelete;
  final String? image;
  final String? name;
  final String? role;
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
      child: Builder(
        builder: (context) {
          switch (_type) {
            case TypeCard.member:
              if (isMonitor) {
                if (role == 'Monitor') {
                  return InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: onTap,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
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
                                Row(
                                  children: [
                                    Text('$role'),
                                    RichText(
                                      text: TextSpan(
                                        text: ' ・ Lv.',
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: level,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          )
                                        ]
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: onTap,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
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
                              Row(
                                children: [
                                  Text('$role'),
                                  RichText(
                                    text: TextSpan(
                                      text: ' ・ Lv.',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: level,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        )
                                      ]
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 5),
                        ElevatedButton(
                          onPressed: onPressedDelete!,
                          style: ElevatedButton.styleFrom(
                            elevation: 4,
                            backgroundColor: const Color(0xffDD0000),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Icon(Icons.delete, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
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
                            Row(
                              children: [
                                Text('$role'),
                                RichText(
                                  text: TextSpan(
                                    text: ' ・ Lv.',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: level,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      )
                                    ]
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            case TypeCard.leaderboard:
              return InkWell(
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
              );
            case TypeCard.task:
              //
            default:
              return Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child:  const InkWell(
                  child: Text('Ini card'),
                ),
              );

          }
        },
      ),
    );
  }

}