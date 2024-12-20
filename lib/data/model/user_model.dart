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