import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AcademicYear with ChangeNotifier {
  final String acadimicYaraId;
  final String facultyId;
  final String acadimicYaraName;
  final String departmentId;
  final String universityId;
  final bool isDeleted;

  AcademicYear({
    required this.acadimicYaraId,
    required this.facultyId,
    required this.acadimicYaraName,
    required this.departmentId,
    required this.universityId,
    required this.isDeleted,
  });
  AcademicYear.fromJson(Map<String, dynamic> json)
      : facultyId = json['facultyId'],
        acadimicYaraName = json['departmentName'],
        departmentId = json['departmentId'],
        universityId = json['universityId'],
        isDeleted = json['isDeleted'],
        acadimicYaraId = json['acadimicYaraId,'];

  List<AcademicYear> _departments = [
    AcademicYear(
        acadimicYaraId: "1",
        facultyId: "1",
        acadimicYaraName: "2015",
        departmentId: "1",
        universityId: "1",
        isDeleted: false),
    AcademicYear(
        acadimicYaraId: "1",
        facultyId: "1",
        acadimicYaraName: "2016",
        departmentId: "1",
        universityId: "1",
        isDeleted: false),
    AcademicYear(
        acadimicYaraId: "1",
        facultyId: "1",
        acadimicYaraName: "2017",
        departmentId: "1",
        universityId: "1",
        isDeleted: false),
    AcademicYear(
        acadimicYaraId: "1",
        facultyId: "1",
        acadimicYaraName: "2018",
        departmentId: "1",
        universityId: "1",
        isDeleted: false),
    AcademicYear(
        acadimicYaraId: "1",
        facultyId: "1",
        acadimicYaraName: "2019",
        departmentId: "1",
        universityId: "1",
        isDeleted: false),
    AcademicYear(
        acadimicYaraId: "1",
        facultyId: "1",
        acadimicYaraName: "2020",
        departmentId: "1",
        universityId: "1",
        isDeleted: false),
    AcademicYear(
        acadimicYaraId: "1",
        facultyId: "1",
        acadimicYaraName: "2021",
        departmentId: "1",
        universityId: "1",
        isDeleted: false),
    AcademicYear(
        acadimicYaraId: "1",
        facultyId: "1",
        acadimicYaraName: "2022",
        departmentId: "1",
        universityId: "1",
        isDeleted: false),
  ];

  List<AcademicYear> get departments {
    return [..._departments];
  }

  Future<void> fetchDepartment(String faculityId) async {
    Map<String, String> queryParam = {
      'faculityId': faculityId,
    };
    var uri = Uri.http(
        'studyhub-sy.com', '/Mobile/getFaculityDepartment', queryParam);
    // final url = "http://www.studyhub-sy.com/Mobile/"
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Something get wrong please try it later');
    }
    final responseData = json.decode(response.body);
    print("department : $responseData");
    List<AcademicYear> loadedDepartment = [];
    for (var uni in responseData) {
      loadedDepartment.add(
        AcademicYear.fromJson(uni),
      );
    }
    _departments = loadedDepartment;
    notifyListeners();
  }
}
