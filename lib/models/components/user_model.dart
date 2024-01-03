import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

late Box userProfile;

@HiveType(typeId: 0)
class UserHive extends HiveObject {
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
  bool online;

  UserHive({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.image,
    required this.online,
  });
}

class User {
  String id;
  String firstname;
  String lastname;
  String phone;
  String image;
  bool online;

  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.image,
    this.online = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      firstname: json['firstname'].toString(),
      lastname: json['lastname'].toString(),
      phone: json['phone'].toString(),
      image: json['image'].toString(),
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
      'online': online,
    };
  }

  ///This methode alloww to save data to the hive box as a json data
  static UserHive fromJonToDatabase(User user) {
    return UserHive(
      id: user.id.toString(),
      firstname: user.firstname,
      lastname: user.lastname,
      phone: user.phone.toString(),
      image: user.image,
      online: user.online,
    );
  }

  ///This methode allow to get data from the hive box
  static User getDatafromDatabase(UserHive userHive) => User(
        id: userHive.id.toString(),
        firstname: userHive.firstname,
        lastname: userHive.lastname,
        phone: userHive.phone,
        image: userHive.image,
        online: userHive.online,
      );
}
