import 'package:flutter/cupertino.dart';

class Department with ChangeNotifier {
  int? facultyId;
  String? departmentName;
  int? departmentId;
  int? universityId;
  bool? isDeleted;
  String? faculty;
  String? university;
  List? courses;
  List? students;
  List? studyyears;

  Department(
      {this.facultyId,
      this.departmentName,
      this.departmentId,
      this.universityId,
      this.isDeleted,
      this.faculty,
      this.university,
      this.courses,
      this.students,
      this.studyyears});

  Department.fromJson(Map<String, dynamic> json) {
    facultyId = json['facultyId'];
    departmentName = json['departmentName'];
    departmentId = json['departmentId'];
    universityId = json['universityId'];
    isDeleted = json['isDeleted'];
    faculty = json['faculty'];
    university = json['university'];
    // if (json['courses'] != null) {
    //   courses = <Null>[];
    //   json['courses'].forEach((v) {
    //     courses!.add(new Null.fromJson(v));
    //   }
    //   );
    // }
    // if (json['students'] != null) {
    //   students = <Null>[];
    //   json['students'].forEach((v) {
    //     students!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['studyyears'] != null) {
    //   studyyears = <Null>[];
    //   json['studyyears'].forEach((v) {
    //     studyyears!.add(new Null.fromJson(v));
    //   });
  }
}
