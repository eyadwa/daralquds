import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:lectures/constant/HttpException.dart';
import 'package:lectures/model/class_year.dart';
import 'package:lectures/model/department.dart';

class ClassYears with ChangeNotifier {
  final List<ClassYear> _classyears = [
    // ClassYear(
    //     universityId: "1",
    //     facultyId: "1",
    //     departmentId: "1",
    //     classyearName: "2015",
    //     isDeleted: false,
    //     classYearId: "1"),
    // ClassYear(
    //     universityId: "1",
    //     facultyId: "1",
    //     departmentId: "1",
    //     classyearName: "2016",
    //     isDeleted: false,
    //     classYearId: "2"),
    // ClassYear(
    //     universityId: "1",
    //     facultyId: "1",
    //     departmentId: "1",
    //     classyearName: "2017",
    //     isDeleted: false,
    //     classYearId: "3"),
    // ClassYear(
    //     universityId: "1",
    //     facultyId: "1",
    //     departmentId: "1",
    //     classyearName: "2018",
    //     isDeleted: false,
    //     classYearId: "4"),
    // ClassYear(
    //     universityId: "1",
    //     facultyId: "1",
    //     departmentId: "1",
    //     classyearName: "2019",
    //     isDeleted: false,
    //     classYearId: "5"),
    // ClassYear(
    //     universityId: "1",
    //     facultyId: "1",
    //     departmentId: "1",
    //     classyearName: "2020",
    //     isDeleted: false,
    //     classYearId: "6"),
    // ClassYear(
    //     universityId: "1",
    //     facultyId: "1",
    //     departmentId: "1",
    //     classyearName: "2021",
    //     isDeleted: false,
    //     classYearId: "7"),
    // ClassYear(
    //     universityId: "1",
    //     facultyId: "1",
    //     departmentId: "1",
    //     classyearName: "2022",
    //     isDeleted: false,
    //     classYearId: "8"),
  ];
  List<ClassYear> get classyears {
    return [..._classyears];
  }

  List<ClassYear> _cclassyears = [];

  List<ClassYear> get cclassyears {
    return [..._cclassyears];
  }

  Future<void> fetchclass(String departmentId) async {
    print("i'm fetch class");
    int departmentid = int.parse(departmentId);
    List<ClassYear> loadedClassYears = [];
    final Uri url = Uri.parse(
        'http://tadcenter2022-001-site1.itempurl.com/StudentMobile/getStudyYear?DepartmentId=$departmentid');

    final response = await http.get(url);
    print(response.body);
    if (response.statusCode != 200) {
      throw HttpException('حدثت مشكلة مع السيرفر');
    }
    final responseData = json.decode(response.body);

    for (var clas in responseData['departments']) {
      print("OOOOOOOOOOOOOOOOOOOoo");

      loadedClassYears.add(ClassYear.fromJson(clas));
    }
    _cclassyears = loadedClassYears;
    notifyListeners();
  }
}
