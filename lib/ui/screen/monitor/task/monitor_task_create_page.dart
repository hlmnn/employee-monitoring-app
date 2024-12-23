import 'package:another_flushbar/flushbar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:employee_monitoring_app/component/em_button/em_button.dart';
import 'package:employee_monitoring_app/data/model/user_model.dart';
import 'package:employee_monitoring_app/utils/date_formatter.dart';
import 'package:flutter/material.dart';

class MonitorTaskCreatePage extends StatefulWidget {
  const MonitorTaskCreatePage({super.key, required this.title});

  final String title;

  @override
  _MonitorTaskCreatePageState createState() => _MonitorTaskCreatePageState();
}

class _MonitorTaskCreatePageState extends State<MonitorTaskCreatePage> {
  final TextEditingController _taskTitle = TextEditingController();
  final TextEditingController _taskReward = TextEditingController();
  final TextEditingController _taskDescription = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? selectedDropdownValue;

  DateTimeRange? _selectedDateRange;

  @override
  void dispose() {
    _taskTitle.dispose();
    _taskReward.dispose();
    _taskDescription.dispose();
    super.dispose();
  }

  Future<void> _pickDateRange() async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: _selectedDateRange,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
      builder: (context, child) {
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width-50,
              maxHeight: MediaQuery.sizeOf(context).height-100
            ),
            child: child,
          ),
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDateRange = picked;
      });
    }
  }

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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Text('Judul Tugas',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _taskTitle,
                    validator: (value) {
                      return (value == null || value.isEmpty)
                          ? 'Mohon isi Judul Tugas anda!'
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
                      hintText: "Ex: 'Buat laporan hasil kegiatan rapat!'",
                      hintStyle: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 3),
                            child: Text('Tanggal Selesai',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 90,
                            child: ElevatedButton(
                              onPressed: _pickDateRange,
                              style: IconButton.styleFrom(
                                backgroundColor: const Color(0xffFFBD20),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              child: const Icon(
                                Icons.calendar_today,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      _selectedDateRange != null  // Only show when a date range is selected
                          ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Dimulai : ',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: DateFormatter.convertToString(_selectedDateRange?.start),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Berakhir : ',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: DateFormatter.convertToString(_selectedDateRange?.end),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ) : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: const TextSpan(
                                  text: 'Dimulai : ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '-',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: const TextSpan(
                                  text: 'Berakhir : ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '-',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Text('Pilih Member',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButtonFormField2(
                      hint: const Text('Pilih member...',
                        style: TextStyle(fontSize: 15)
                      ),
                      value: selectedDropdownValue,
                      onChanged: (value) {
                        setState(() {
                          selectedDropdownValue = value;
                        });
                      },
                      validator: (value) {
                        return (value == null || value.isEmpty)
                            ? 'Mohon pilih member untuk di assign tugas!'
                            : null;
                      },
                      items: members.where((member) => member.role == 'Member').map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem (
                          value: value.id.toString(),
                          child: Text(value.name),
                        );
                      }).toList(),
                      isExpanded: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Colors.black54,
                            width: 1,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1,
                          ),
                        ),
                      ),
                      dropdownStyleData: const DropdownStyleData(
                        maxHeight: 200,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Text('Hadiah Tugas',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _taskReward,
                    validator: (value) {
                      return (value == null || value.isEmpty)
                          ? 'Mohon isi Hadiah Tugas anda!'
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
                      hintText: "Ex: '50'",
                      hintStyle: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Text('Deskripsi Tugas',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _taskDescription,
                    validator: (value) {
                      return (value == null || value.isEmpty)
                          ? 'Mohon isi Deskripsi Tugas anda!'
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
                      hintText: 'Tulis deskripsi tugas...',
                      hintStyle: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 100), // spacer
                ],
              ),
            )
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
                        message: 'Tugas berhasil dibuat!',
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
                  text: 'Buat Tugas',
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
      ),
    );
  }

}