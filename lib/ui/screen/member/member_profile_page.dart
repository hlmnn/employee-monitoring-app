import 'package:employee_monitoring_app/choose_login_as_page.dart';
import 'package:employee_monitoring_app/component/em_button/em_button.dart';
import 'package:employee_monitoring_app/component/em_circular_loading.dart';
import 'package:employee_monitoring_app/data/data_state.dart';
import 'package:employee_monitoring_app/ui/cubit/profile_cubit.dart';
import 'package:employee_monitoring_app/ui/screen/setting/achievement_page.dart';
import 'package:employee_monitoring_app/ui/screen/setting/change_password_page.dart';
import 'package:employee_monitoring_app/ui/screen/setting/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberProfilePage extends StatefulWidget {
  const MemberProfilePage({super.key, required this.title});

  final String title;

  @override
  _MemberProfilePageState createState() => _MemberProfilePageState();
}

class _MemberProfilePageState extends State<MemberProfilePage> {
  @override
  Widget build(BuildContext context) {
    context.read<ProfileCubit>().getCurrentUserProfile();

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
      body: BlocBuilder<ProfileCubit, DataState>(
        builder: (context, state) {
          String name = '';
          String role = '';
          int cash = 0;
          int level = 0;
          int currentExp = 0;
          int maxExp = 1;

          if (state is LoadingState) {
            return const Center(
                child: EmCircularLoading(size: 30, color: Color(0xffFFBD20))
            );
          } else if (state is SuccessState) {
            if (state.data is bool) {
              context.read<ProfileCubit>().resetState();
              Future.delayed(Duration.zero, () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) =>
                      const ChooseLoginAsPage(title: 'Choose Login Page'),
                    ), (Route<dynamic> route) => false);
              });
            } else {
              name = state.data.name;
              cash = state.data.cash;
              level = state.data.level;
              currentExp = state.data.currentExp;
              maxExp = state.data.maxExp;
              state.data.isMonitor == true ? role = 'Monitor' : role = 'Member';
            }
          }

          return SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                            Expanded(
                              child: Text(name,
                                style: const TextStyle(
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
                                      value: currentExp / maxExp,
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
                                Text('$currentExp/$maxExp',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(role,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/cash.png', height: 12),
                                const SizedBox(width: 5),
                                Text('$cash',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
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
                            const EditProfilePage(title: 'Ubah Profile',),
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
                    onPressed: (){
                      context.read<ProfileCubit>().logout();
                    },
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
            ],
          ),
        );
      }),
    );
  }
}