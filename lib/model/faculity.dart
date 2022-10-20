import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:lectures/model/course.dart';
import 'package:lectures/model/department.dart';
import 'package:lectures/provider/departments.dart';

// class Faculty with ChangeNotifier {
//   final String? facultyId;
//   final String? name;
//   final String? universityId;
//   final bool? isDeleted;

//   Faculty({this.facultyId, this.name, this.universityId, this.isDeleted});
//    @override
//   bool operator ==(other) {
//     return (other is Faculty) &&
//         other.universityId == universityId && other.facultyId==facultyId&&
//         other.name == name ;

//   }
//    @override
//   int get hashCode => universityId.hashCode ^facultyId.hashCode ^ name.hashCode;
//   Faculty.fromJson(Map<String, dynamic> json)
//       : facultyId = json['facultyId'],
//         name = json['name'],
//         universityId = json['uniersityId'],
//         isDeleted = json['isDeleted'];
// }

class Faculty with ChangeNotifier {
  int? uniersityId;
  String? name;
  int? facultyId;
  bool? isDeleted;
  Null? uniersity;
  List? courses;
  List? departments;
  List? news;
  List? students;

  Faculty(
      {this.uniersityId,
      this.name,
      this.facultyId,
      this.isDeleted,
      this.uniersity,
      this.courses,
      this.departments,
      this.news,
      this.students});

  Faculty.fromJson(Map<String, dynamic> json) {
    uniersityId = json['uniersityId'];
    name = json['name'];
    facultyId = json['facultyId'];
    isDeleted = json['isDeleted'];
    uniersity = json['uniersity'];
    if (json['courses'] != null) {
      courses = [];
      json['courses'].forEach((v) {
        courses!.add(Course.fromJson(v));
      });
    }
    if (json['departments'] != null) {
      departments = <Null>[];
      json['departments'].forEach((v) {
        departments!.add(Department.fromJson(v));
      });
    }
    // if (json['news'] != null) {
    //   news = [];
    //   json['news'].forEach((v) {
    //     news!.add(fromJson(v));
    //   });
    // }
    //   if (json['students'] != null) {
    //     students = <Null>[];
    //     json['students'].forEach((v) {
    //       students!.add(new Null.fromJson(v));
    //     });
    //   }
    // }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['uniersityId'] = this.uniersityId;
      data['name'] = this.name;
      data['facultyId'] = this.facultyId;
      data['isDeleted'] = this.isDeleted;
      data['uniersity'] = this.uniersity;
      if (this.courses != null) {
        data['courses'] = this.courses!.map((v) => v.toJson()).toList();
      }
      if (this.departments != null) {
        data['departments'] = this.departments!.map((v) => v.toJson()).toList();
      }
      if (this.news != null) {
        data['news'] = this.news!.map((v) => v.toJson()).toList();
      }
      if (this.students != null) {
        data['students'] = this.students!.map((v) => v.toJson()).toList();
      }
      return data;
    }
  }
}
