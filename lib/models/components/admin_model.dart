import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'admin_model.g.dart';

@HiveType(typeId: 0)
class AdminHive extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String firstname;
  @HiveField(2)
  String lastname;
  @HiveField(3)
  String phone;
  @HiveField(4)
  String image;
  @HiveField(5)
  String status;
  @HiveField(6)
  bool online;

  AdminHive({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.image,
    required this.online,
    required this.status,
  });
}

class Admin {
  String id;
  String firstname;
  String lastname;
  String phone;
  String image;
  String status;
  bool online;

  Admin({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.image,
    required this.status,
    this.online = false,
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['id'].toString(),
      firstname: json['firstname'].toString(),
      lastname: json['lastname'].toString(),
      phone: json['phone'].toString(),
      image: json['image'].toString(),
      status: json['status'].toString(),
      online: json["online"] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'firstname': firstname,
      'lastname': lastname,
      'phone': phone,
      'image': image,
      'status': status,
      'online': online,
    };
  }

  ///This methode alloww to save data to the hive box as a json data
  static AdminHive fromJonToDatabase(Admin admin) {
    return AdminHive(
      id: admin.id.toString(),
      firstname: admin.firstname,
      lastname: admin.lastname,
      phone: admin.phone.toString(),
      image: admin.image,
      status: admin.status,
      online: admin.online,
    );
  }

  ///This methode allow to get data from the hive box
  static Admin getDatafromDatabase(AdminHive adminHive) => Admin(
        id: adminHive.id.toString(),
        firstname: adminHive.firstname,
        lastname: adminHive.lastname,
        phone: adminHive.phone,
        image: adminHive.image,
        status: adminHive.status,
        online: adminHive.online,
      );
}
