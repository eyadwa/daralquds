import 'package:flutter/cupertino.dart';

class ClassYear with ChangeNotifier {
  int? id;
  String? yearname;
  int? deptid;
  String? dept;
  List? lectures;
  List? students;

  ClassYear(
      {this.id,
      this.yearname,
      this.deptid,
      this.dept,
      this.lectures,
      this.students});

  ClassYear.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    yearname = json['yearname'];
    deptid = json['deptid'];
    dept = json['dept'];
    // if (json['lectures'] != null) {
    //   lectures = <Null>[];
    //   json['lectures'].forEach((v) {
    //     lectures!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['students'] != null) {
    //   students = <Null>[];
    //   json['students'].forEach((v) {
    //     students!.add(new Null.fromJson(v));
    //   });
    // }
  }
}
