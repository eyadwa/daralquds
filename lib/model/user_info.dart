// To parse this JSON data, do
//
//     final userInfo = userInfoFromMap(jsonString);

import 'dart:convert';

class UserInfo {
  UserInfo({
    this.student,
  });

  Student? student;

  factory UserInfo.fromJson(String str) => UserInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserInfo.fromMap(Map<String, dynamic> json) => UserInfo(
    student: Student.fromMap(json["student"]),
  );

  Map<String, dynamic> toMap() => {
    "student": student!.toMap(),
  };
}

class Student {
  Student({
    this.name,
    this.email,
    this.phone,
    this.city,
    this.birthdate,
    this.password,
    this.faculityId,
    this.studentId,
    this.departmentId,
    this.isDeleted,
    this.yearid,
    this.activationcode,
    this.isactive,
    this.department,
    this.faculity,
    this.year,
    this.registerOnLines,
    this.studentCourses,
    this.studentExamOnLines,
    this.studentLectures,
    this.studentNotes,
    this.studentPresenses,
    this.studentRegisterOnlines,
    this.studentRegisters,
  });

  String? name;
  String? email;
  String? phone;
  String? city;
  DateTime? birthdate;
  String? password;
  int? faculityId;
  int? studentId;
  int? departmentId;
  bool? isDeleted;
  int? yearid;
  dynamic? activationcode;
  bool? isactive;
  dynamic? department;
  dynamic? faculity;
  dynamic? year;
  List<dynamic>? registerOnLines;
  List<dynamic>? studentCourses;
  List<dynamic>? studentExamOnLines;
  List<dynamic>? studentLectures;
  List<dynamic>? studentNotes;
  List<dynamic>? studentPresenses;
  List<dynamic>? studentRegisterOnlines;
  List<dynamic>? studentRegisters;

  factory Student.fromJson(String str) => Student.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Student.fromMap(Map<String, dynamic> json) => Student(
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    city: json["city"],
    birthdate: DateTime.parse(json["birthdate"]),
    password: json["password"],
    faculityId: json["faculityId"],
    studentId: json["studentId"],
    departmentId: json["departmentId"],
    isDeleted: json["isDeleted"],
    yearid: json["yearid"],
    activationcode: json["activationcode"],
    isactive: json["isactive"],
    department: json["department"],
    faculity: json["faculity"],
    year: json["year"],
    registerOnLines: List<dynamic>.from(json["registerOnLines"].map((x) => x)),
    studentCourses: List<dynamic>.from(json["studentCourses"].map((x) => x)),
    studentExamOnLines: List<dynamic>.from(json["studentExamOnLines"].map((x) => x)),
    studentLectures: List<dynamic>.from(json["studentLectures"].map((x) => x)),
    studentNotes: List<dynamic>.from(json["studentNotes"].map((x) => x)),
    studentPresenses: List<dynamic>.from(json["studentPresenses"].map((x) => x)),
    studentRegisterOnlines: List<dynamic>.from(json["studentRegisterOnlines"].map((x) => x)),
    studentRegisters: List<dynamic>.from(json["studentRegisters"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "email": email,
    "phone": phone,
    "city": city,
    "birthdate": birthdate!.toIso8601String(),
    "password": password,
    "faculityId": faculityId,
    "studentId": studentId,
    "departmentId": departmentId,
    "isDeleted": isDeleted,
    "yearid": yearid,
    "activationcode": activationcode,
    "isactive": isactive,
    "department": department,
    "faculity": faculity,
    "year": year,
    "registerOnLines": List<dynamic>.from(registerOnLines!.map((x) => x)),
    "studentCourses": List<dynamic>.from(studentCourses!.map((x) => x)),
    "studentExamOnLines": List<dynamic>.from(studentExamOnLines!.map((x) => x)),
    "studentLectures": List<dynamic>.from(studentLectures!.map((x) => x)),
    "studentNotes": List<dynamic>.from(studentNotes!.map((x) => x)),
    "studentPresenses": List<dynamic>.from(studentPresenses!.map((x) => x)),
    "studentRegisterOnlines": List<dynamic>.from(studentRegisterOnlines!.map((x) => x)),
    "studentRegisters": List<dynamic>.from(studentRegisters!.map((x) => x)),
  };
}
