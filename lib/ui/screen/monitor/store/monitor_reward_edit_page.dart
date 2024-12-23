import 'package:another_flushbar/flushbar.dart';
import 'package:employee_monitoring_app/component/em_button/em_button.dart';
import 'package:flutter/material.dart';

class MonitorRewardEditPage extends StatefulWidget {
  const MonitorRewardEditPage({super.key, required this.title});

  final String title;

  @override
  _MonitorRewardEditPageState createState() => _MonitorRewardEditPageState();
}

class _MonitorRewardEditPageState extends State<MonitorRewardEditPage> {
  final TextEditingController _rewardTitle = TextEditingController();
  final TextEditingController _rewardPrice = TextEditingController();
  final TextEditingController _rewardStock = TextEditingController();
  final TextEditingController _rewardDescription = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              scrollDirection: Axis.vertical,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: (){
                        print('Sudah Di Klik');
                      },
                      child: Container(
                        height: 150,
                        width: double.maxFinite,
                        color: const Color(0xffD9D9D9),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.local_grocery_store,
                              color: Color(0xff989898),
                              size: 35,
                            ),
                            Text('Masukan foto reward',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xff989898),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 3),
                      child: Text('Nama Reward',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _rewardTitle,
                      validator: (value) {
                        return (value == null || value.isEmpty)
                            ? 'Mohon isi Nama Reward!'
                            : null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff461902),
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        contentPadding: EdgeInsets.all(10),
                        hintText: "Tulis nama reward...",
                        hintStyle: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 3),
                              child: Text('Harga Reward',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 160,
                              child: TextFormField(
                                controller: _rewardPrice,
                                validator: (value) {
                                  return (value == null || value.isEmpty)
                                      ? 'Mohon isi Harga Reward!'
                                      : null;
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff461902),
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                                  hintText: "Tulis harga reward...",
                                  hintStyle: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 3),
                              child: Text('Stok Reward',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 160,
                              child: TextFormField(
                                controller: _rewardStock,
                                validator: (value) {
                                  return (value == null || value.isEmpty)
                                      ? 'Mohon isi Stok Reward!'
                                      : null;
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff461902),
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                                  hintText: "Tulis stok reward...",
                                  hintStyle: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 3),
                      child: Text('Deskripsi Reward',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _rewardDescription,
                      validator: (value) {
                        return (value == null || value.isEmpty)
                            ? 'Mohon isi Deskripsi Tugas!'
                            : null;
                      },
                      maxLines: 7,
                      maxLength: 300,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff461902),
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'Tulis deskripsi reward...',
                        hintStyle: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 100), // space
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Theme(
                data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: EmButton.elevated(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Flushbar(
                          message: 'Reward berhasil dibuat!',
                          flushbarPosition: FlushbarPosition.BOTTOM,
                          margin: const EdgeInsets.all(8),
                          borderRadius: BorderRadius.circular(10),
                          duration: const Duration(seconds: 3),
                          isDismissible: false,
                        ).show(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 4,
                      backgroundColor: const Color(0xffFFBD20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    text: 'Ubah Reward',
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.black
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }

}