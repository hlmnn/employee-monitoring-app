import 'package:employee_monitoring_app/ui/screen/monitor/monitor_member_list_page.dart';

class TaskModel {
  final String title;
  final Member member;
  final String cash;
  final String exp;
  final String startDate;
  final String lastDate;
  final String status;

  TaskModel(this.title, this.member, this.cash, this.exp, this.startDate, this.lastDate, this.status);
}