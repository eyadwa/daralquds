import 'package:flutter/material.dart';

class Course with ChangeNotifier {
  String? courseName;
  int? facultyId;
  String? teacher;
  int? year;
  int? semester;
  int? departmentId;
  int? courseId;
  bool? isDeleted;
  int? price;
  Null? department;
  Null? faculty;
  List<Null>? courseAttachements;
  List<Null>? courseExams;
  List<Null>? lectures;
  List<Null>? studentCourses;

  Course(
      {this.courseName,
      this.facultyId,
      this.teacher,
      this.year,
      this.semester,
      this.departmentId,
      this.courseId,
      this.isDeleted,
      this.price,
      this.department,
      this.faculty,
      this.courseAttachements,
      this.courseExams,
      this.lectures,
      this.studentCourses});

  Course.fromJson(Map<String, dynamic> json) {
    courseName = json['courseName'];
    facultyId = json['facultyId'];
    teacher = json['teacher'];
    year = json['year'];
    semester = json['semester'];
    departmentId = json['departmentId'];
    courseId = json['courseId'];
    isDeleted = json['isDeleted'];
    price = json['price'];
    department = json['department'];
    faculty = json['faculty'];
    // if (json['courseAttachements'] != null) {
    //   courseAttachements = <Null>[];
    //   json['courseAttachements'].forEach((v) {
    //     courseAttachements!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['courseExams'] != null) {
    //   courseExams = <Null>[];
    //   json['courseExams'].forEach((v) {
    //     courseExams!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['lectures'] != null) {
    //   lectures = <Null>[];
    //   json['lectures'].forEach((v) {
    //     lectures!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['studentCourses'] != null) {
    //   studentCourses = <Null>[];
    //   json['studentCourses'].forEach((v) {
    //     studentCourses!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseName'] = this.courseName;
    data['facultyId'] = this.facultyId;
    data['teacher'] = this.teacher;
    data['year'] = this.year;
    data['semester'] = this.semester;
    data['departmentId'] = this.departmentId;
    data['courseId'] = this.courseId;
    data['isDeleted'] = this.isDeleted;
    data['price'] = this.price;
    data['department'] = this.department;
    data['faculty'] = this.faculty;
    // if (this.courseAttachements != null) {
    //   data['courseAttachements'] =
    //       this.courseAttachements!.map((v) => v.toJson()).toList();
    // }
    // if (this.courseExams != null) {
    //   data['courseExams'] = this.courseExams!.map((v) => v.toJson()).toList();
    // }
    // if (this.lectures != null) {
    //   data['lectures'] = this.lectures!.map((v) => v.toJson()).toList();
    // }
    // if (this.studentCourses != null) {
    //   data['studentCourses'] =
    //       this.studentCourses!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
