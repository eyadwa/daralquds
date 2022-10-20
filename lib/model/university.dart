import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lectures/model/department.dart';
import 'package:lectures/model/faculity.dart';
// class University {
//   String? universityName;
//   String? city;
//   int? universityId;
//   Null? isDeleted;
//   List<Null>? departments;
//   List<Null>? faculties;

// class University with ChangeNotifier {
//   String? universityName;
//   String? universityId;
//   bool? isDeleted;
//   String? city;
//   University({
//     this.universityName,
//     this.universityId,
//     this.isDeleted,
//     this.city,
//   });
//    @override
//   bool operator ==(other) {
//     return (other is University) &&
//         other.universityId == universityId && other.city==city&&
//         other.universityName == universityName;
//   }

//   @override
//   int get hashCode => universityId.hashCode ^ universityName.hashCode ^city.hashCode;

//   University.fromJson(Map<String, dynamic> json)
//       : universityId = json['universityId'].toString(),
//         universityName = json['universityName'],
//         isDeleted = json['isDeleted'],
//         city = json['city'];

//   // factory University.fromMap(Map<String, dynamic> json) {
//   //   return University(json['UniversityName'], json['UniversityId'],
//   //       json['IsDeleted'], json['city']);
//   // }

//   // Future<void> fetchUniversity() async {
//   //   final url = 'http://www.studyhub-sy.com/Mobile/getUniversities';
//   //   final response = await http.get(url);
//   //   if (response.statusCode != 200) {
//   //     throw Exception('Something get wrong please try it later');
//   //   }
//   //   final responseData = json.decode(response.body);
//   //   print('University ${json.decode(response.body)}');
//   //   List<University> loadedUniversity = [];
//   //   for (var uni in responseData) {
//   //     loadedUniversity.add(
//   //       University.fromJson(uni),
//   //     );
//   //   }
//   //   _university = loadedUniversity;
//   //   notifyListeners();
//   // }

// }
class University with ChangeNotifier {
  String? universityName;
  String? city;
  int? universityId;
  bool? isDeleted;
  List? departments;
  List? faculties;

  University(
      {this.universityName,
      this.city,
      this.universityId,
      this.isDeleted,
      this.departments,
      this.faculties});

  University.fromJson(Map<String, dynamic> json) {
    universityName = json['universityName'];
    city = json['city'];
    universityId = json['universityId'];
    isDeleted = json['isDeleted'];
    if (json['departments'] != null) {
      departments = [];
      json['departments'].forEach((v) {
        departments!.add(Department.fromJson(v));
      });
    }
    if (json['faculties'] != null) {
      faculties = <Null>[];
      json['faculties'].forEach((v) {
        faculties!.add(Faculty.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['universityName'] = this.universityName;
  //   data['city'] = this.city;
  //   data['universityId'] = this.universityId;
  //   data['isDeleted'] = this.isDeleted;
  //   if (this.departments != null) {
  //     data['departments'] = this.departments!.map((v) => v.toJson()).toList();
  //   }
  //   if (this.faculties != null) {
  //     data['faculties'] = this.faculties!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}
