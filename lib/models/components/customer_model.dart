import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'customer_model.g.dart';

@HiveType(typeId: 0)
class CustomerHive extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String? witnessId;
  @HiveField(2)
  String firstname;
  @HiveField(3)
  String lastname;
  @HiveField(4)
  String phone;
  @HiveField(5)
  String image;
  @HiveField(6)
  bool online;

  CustomerHive({
    required this.id,
    this.witnessId,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.image,
    required this.online,
  });
}

class Customer {
  String id;
  String? witnessId;
  String firstname;
  String lastname;
  String phone;
  String image;
  bool online;

  Customer({
    required this.id,
    this.witnessId,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.image,
    this.online = false,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'].toString(),
      witnessId: json["witness_id"].toString(),
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
      'witness_id': witnessId.toString(),
      'firstname': firstname,
      'lastname': lastname,
      'phone': phone,
      'image': image,
      'online': online,
    };
  }

  ///This methode alloww to save data to the hive box as a json data
  static CustomerHive fromJonToDatabase(Customer customer) {
    return CustomerHive(
      id: customer.id.toString(),
      witnessId: customer.witnessId.toString(),
      firstname: customer.firstname,
      lastname: customer.lastname,
      phone: customer.phone.toString(),
      image: customer.image,
      online: customer.online,
    );
  }

  ///This methode allow to get data from the hive box
  static Customer getDatafromDatabase(CustomerHive customerHive) => Customer(
        id: customerHive.id.toString(),
        witnessId: customerHive.witnessId.toString(),
        firstname: customerHive.firstname,
        lastname: customerHive.lastname,
        phone: customerHive.phone,
        image: customerHive.image,
        online: customerHive.online,
      );
}
