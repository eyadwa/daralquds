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
  Null? courseAttachements;
  Null? courseExams;
  Null? lectures;
  Null? studentCourses;

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
    courseAttachements = json['courseAttachements'];
    courseExams = json['courseExams'];
    lectures = json['lectures'];
    studentCourses = json['studentCourses'];
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
    data['courseAttachements'] = this.courseAttachements;
    data['courseExams'] = this.courseExams;
    data['lectures'] = this.lectures;
    data['studentCourses'] = this.studentCourses;
    return data;
  }
}
