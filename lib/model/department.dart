import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Department with ChangeNotifier {
  final int? facultyId;
  final String? departmentName;
  final int? departmentId;
  final int? universityId;
  final bool? isDeleted;

  Department({
    this.facultyId,
    this.departmentName,
    this.departmentId,
    this.universityId,
    this.isDeleted,
  });
  Department.fromJson(Map<String, dynamic> json)
      : facultyId = json['facultyId'],
        departmentName = json['departmentName'],
        departmentId = json['departmentId'],
        universityId = json['universityId'],
        isDeleted = json['isDeleted'];
}
