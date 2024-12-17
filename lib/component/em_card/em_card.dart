import 'package:flutter/material.dart';

import 'type_card.dart';

class EmCard extends StatelessWidget {
  const EmCard.member({
    Key? key,
    this.onTap,
    this.onPressedDelete,
    this.image,
    this.name,
    this.role,
    this.level,
    this.rank,
    this.taskTotal,
    this.isExpand = true,
    this.isMonitor = false,
  }) : _type = TypeCard.member,
        super(key: key);
  const EmCard.leaderboard({
    Key? key,
    this.onTap,
    this.onPressedDelete,
    this.image,
    this.name,
    this.role,
    this.level,
    this.rank,
    this.taskTotal,
    this.isExpand = true,
    this.isMonitor = false,
  }) : _type = TypeCard.member,
        super(key: key);

  final TypeCard? _type;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onPressedDelete;
  final String? image;
  final String? name;
  final String? role;
  final String? level;
  final String? rank;
  final String? taskTotal;
  final bool isExpand;
  final bool isMonitor;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isExpand ? double.infinity : null,
      height: 50,
      child: Builder(
        builder: (context) {
          switch (_type) {
            case TypeCard.member:
              return Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const InkWell(

                ),
              );
            case TypeCard.leaderboard:
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top Row: Rank and Avatar
                        Row(
                          children: [
                            Text(
                              '#${rank!}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 15),
                            CircleAvatar(
                              backgroundImage: AssetImage(image!),
                              radius: 23,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Middle: Name and Level
                        Row(
                          children: [
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
                                    maxLines: 2,
                                  ),
                                  Text('Lv.$level'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            taskTotal!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            case TypeCard.task:
              return Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const InkWell(

                ),
              );
            default:
              return Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const InkWell(

                ),
              );

          }
        },
      ),
    );
  }

}