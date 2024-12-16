import 'package:employee_monitoring_app/component/em_button/em_button.dart';
import 'package:employee_monitoring_app/ui/screen/setting/achievement_page.dart';
import 'package:employee_monitoring_app/ui/screen/setting/change_password_page.dart';
import 'package:employee_monitoring_app/ui/screen/setting/edit_profile_page.dart';
import 'package:flutter/material.dart';

class MonitorProfilePage extends StatefulWidget {
  const MonitorProfilePage({super.key, required this.title});

  final String title;

  @override
  _MonitorProfilePageState createState() => _MonitorProfilePageState();
}

class _MonitorProfilePageState extends State<MonitorProfilePage> {
  int level = 1;
  int currentTotalExp = 2900; // example starting experience (level 7)
  static const int baseMaxExp = 100;
  int maxExp = baseMaxExp;

  void calculateExp() {
    while (currentTotalExp >= maxExp) {
      currentTotalExp -= maxExp; // subtract maxExp from currentExp
      level++; // increase the level
      maxExp = baseMaxExp + (level - 1) * 50; // recalculate maxExp
    }
  }

  @override
  Widget build(BuildContext context) {
    calculateExp();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
              ),
            ],
          ),
          child: AppBar(
            title: Text(widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            backgroundColor: const Color(0xffFFBD20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20,top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/avatar_placeholder.png'),
                  radius: 40,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text('Ryan Ahmad Gosling',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Lv.',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                              ),
                              children: [
                                TextSpan(
                                  text: '$level',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 15,
                                  child: LinearProgressIndicator(
                                    value: currentTotalExp / maxExp,
                                    backgroundColor: const Color(0xffffecc0),
                                    color: const Color(0xffFFBD20),
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('$currentTotalExp/$maxExp',
                                style: const TextStyle(
                                  fontSize: 11,
                                ),
                              ),
                              const Text('Experience',
                                style: TextStyle(
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const Text('Monitor',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.emoji_events, color: Colors.black),
                      title: const Text('Achievements'),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black),
                      onTap: () {
                        Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const AchievementPage(title: 'Achievements'),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.edit_square, color: Colors.black),
                      title: const Text('Ubah Profile'),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black),
                      onTap: () {
                        Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const EditProfilePage(title: 'Ubah Profile'),
                          ),
                        );
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.edit_square, color: Colors.black),
                    title: const Text('Ganti Kata Sandi'),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black),
                    onTap: () {
                      Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) =>
                          const ChangePasswordPage(title: 'Ganti Kata Sandi'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  EmButton.elevated(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      elevation: 4,
                      backgroundColor: const Color(0xffDD0000),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    text: 'Logout',
                    icon: const Icon(Icons.logout, color: Colors.black),
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.black
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}