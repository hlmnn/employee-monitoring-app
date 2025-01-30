class UserModel {
  int id;
  String name;
  String role;
  String level;

  UserModel(this.id, this.name,this.role, this.level);
}

List<UserModel> members = [
  UserModel(1,'Alice', 'Member', '20'),
  UserModel(2,'David', 'Member', '12'),
  UserModel(3,'Ryan Ahmad Gosling', 'Monitor', '5'),
  UserModel(4,'Zendaya', 'Member', '10'),
  UserModel(5,'Broski', 'Member', '22'),
  UserModel(6,'Sigma', 'Member', '8'),
  UserModel(7,'Chad', 'Member', '15'),
  UserModel(8,'Hilman Fauzi Herdiana aaaaaaaaaaaa', 'Member', '19'),
  UserModel(9,'Fauzi', 'Member', '3'),
  UserModel(10,'Ahmad', 'Member', '7'),
  UserModel(11,'John Doe Hidayat', 'Member', '17'),
];

class AuthUserModel {
  String id;
  String name;
  String phone;
  String email;
  bool isMonitor;
  int level;
  int currentExp;
  int maxExp;
  String address;
  int serverId;

  AuthUserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.isMonitor,
    required this.level,
    required this.currentExp,
    required this.maxExp,
    required this.address,
    required this.serverId,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      isMonitor: json['is_monitor'],
      level: json['level'],
      currentExp: json['current_exp'],
      maxExp: json['max_exp'],
      address: json['address'] ?? '',
      serverId: json['server_id'] ?? 0,
    );
  }
}