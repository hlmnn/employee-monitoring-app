import 'package:employee_monitoring_app/component/em_button/em_button.dart';
import 'package:flutter/material.dart';

import 'type_card.dart';

class EmCard extends StatelessWidget {
  const EmCard.member({
    Key? key,
    required this.onTap,
    this.onPressedButton,
    this.image,
    this.name,
    this.role,
    this.level,
    this.rank,
    this.taskTotal,
    this.title,
    this.date,
    this.cash,
    this.experience,
    this.price,
    this.isMonitor = false,
  }) : _type = TypeCard.member,
        super(key: key);
  const EmCard.leaderboard({
    Key? key,
    required this.onTap,
    this.onPressedButton,
    this.image,
    this.name,
    this.role,
    this.level,
    this.rank,
    this.taskTotal,
    this.title,
    this.date,
    this.cash,
    this.experience,
    this.price,
    this.isMonitor = false,
  }) : _type = TypeCard.leaderboard,
        super(key: key);
  const EmCard.task({
    Key? key,
    required this.onTap,
    this.onPressedButton,
    this.image,
    this.name,
    this.role,
    this.level,
    this.rank,
    this.taskTotal,
    this.title,
    this.date,
    this.cash,
    this.experience,
    this.price,
    this.isMonitor = false,
  }) : _type = TypeCard.task,
        super(key: key);
  const EmCard.item({
    Key? key,
    required this.onTap,
    this.onPressedButton,
    this.image,
    this.name,
    this.role,
    this.level,
    this.rank,
    this.taskTotal,
    this.title,
    this.date,
    this.cash,
    this.experience,
    this.price,
    this.isMonitor = false,
  }) : _type = TypeCard.item,
        super(key: key);

  final TypeCard? _type;
  final GestureTapCallback onTap;
  final GestureTapCallback? onPressedButton;
  final String? image;
  final String? name;
  final String? role;
  final String? level;
  final String? rank;
  final String? taskTotal;
  final String? title;
  final String? date;
  final String? cash;
  final String? experience;
  final int? price;
  final bool isMonitor;


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: const Color(0xffFEF7FF),
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
                          onPressed: onPressedButton!,
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
              return InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(image!),
                                  radius: 9,
                                ),
                                const SizedBox(width: 5),
                                RichText(
                                  text: TextSpan(
                                    text: 'Lv.',
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: level!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                        ),
                                      )
                                    ]
                                  ),
                                ),
                                const SizedBox(width: 5),
                                SizedBox(
                                  width: 140,
                                  child: Text(name!, overflow: TextOverflow.ellipsis,)
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Image.asset('assets/images/cash.png', width: 16),
                                const SizedBox(width: 3),
                                Text(cash!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(' ・ $date'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black),
                    ],
                  ),
                ),
              );
            default:
              return InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Image.asset(
                              image!,
                              width: double.infinity,
                              height: 110,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(name!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/images/cash.png', width: 16),
                              const SizedBox(width: 3),
                              Text('$price',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            height: 35,
                            child: isMonitor == true
                              ? EmButton.elevated(
                                onPressed: onPressedButton!,
                                style: ElevatedButton.styleFrom(
                                  elevation: 4,
                                  backgroundColor: const Color(0xffFFBD20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                ),
                                text: 'Edit',
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                                ),
                                icon: const Icon(Icons.edit, color: Colors.black, size: 14),
                              )
                              : EmButton.elevated(
                                onPressed: onPressedButton!,
                                style: ElevatedButton.styleFrom(
                                  elevation: 4,
                                  backgroundColor: const Color(0xffFFBD20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                ),
                                text: 'Beli',
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                                ),
                              ),
                          ),
                        ],
                      ),
                    ],
                  )
                ),
              );
          }
        },
      ),
    );
  }
}