import 'dart:typed_data';

class Person {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? password;
  Uint8List? image;
  int? balance;

  Person(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.password,
        this.image,
        this.balance});

   Person.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    image = json['image'];
    balance = json['balance'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> person =  <String, dynamic>{};
    person['id'] = id;
    person['firstName'] = firstName;
    person['lastName'] = lastName;
    person['email'] = email;
    person['phone'] = phone;
    person['password'] =password;
    person['image'] = image;
    person['balance'] =balance;
    return person;
  }

}