import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:lectures/constant/HttpException.dart';
import 'package:lectures/model/faculity.dart';

class Facultys with ChangeNotifier {
  List<Faculty> _faculties = [
    //   Faculty(
    //       facultyId: "1", universityId: "1", name: "midical", isDeleted: false),
    //   Faculty(
    //       facultyId: "2", universityId: "1", name: "Pharmacy", isDeleted: false),
    //   Faculty(
    //       facultyId: "3", universityId: "2", name: "midical", isDeleted: false),
    //   Faculty(
    //       facultyId: "4", universityId: "2", name: "Pharmacy", isDeleted: false),
    //   Faculty(
    //       facultyId: "5",
    //       universityId: "3",
    //       name: "Pharmacyyyyyyy",
    //       isDeleted: false),
    //   Faculty(
    //       facultyId: "6", universityId: "3", name: "Pharmacy", isDeleted: false),
    //
  ];
  List<Faculty> get faculty {
    return [..._faculties];
  }

  List<Faculty> _ffaculties = [];
  List<Faculty> get ffacultys {
    return [..._ffaculties];
  }

  // Future<void> fetchFaculty(String universityId) async {
  //   List<Faculty> loadedFaculty = [];
  //   final response = faculty.where((element) {
  //     return element.universityId == universityId;
  //   });

  //   // Map<String, String> queryParam = {
  //   //   'universityId': universityId,
  //   // };
  //   // var uri = Uri.http(
  //   //     'studyhub-sy.com', '/Mobile/getUniversityFaculity', queryParam);

  //   // final response = await http.get(uri);
  //   // if (response.statusCode != 200) {
  //   //   throw Exception('Something get wrong please try it later');
  //   // }
  //   // final responseData = json.decode(response.body);

  //   // print("faculty : $responseData");
  //   // List<Faculty> loadedFaculty = [];
  //   for (var fac in response) {
  //     print("OOOOOOOOOOOOOOOOOOOoo");
  //     print(fac.name);
  //     loadedFaculty.add(fac);
  //   }
  //   // // print(json.decode(response.body));
  //   _ffaculties = loadedFaculty;
  //   print(_ffaculties.length);
  //   notifyListeners();
  // }

  Future<void> fetchFaculty(String universityId) async {
    int universityid = int.parse(universityId);
    final Uri url = Uri.parse(
        'http://tadcenter2022-001-site1.itempurl.com/StudentMobile/getFaculties?universityId=$universityid');

    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw HttpException('حدثت مشكلة مع السيرفر');
    }
    final responseData = json.decode(response.body);
    print("888888888888888888888888888");
    print(responseData);
    List<Faculty> loadeditems = [];
    for (var faculty in responseData['faculties']) {
      loadeditems.add(
        Faculty.fromJson(faculty),
      );
    }
    _faculties = loadeditems;
    notifyListeners();
    // print(_universitys.length);
    // _universitys = _universitys;
    print("llllllllllllllllllllllllllll");
    print(_faculties.length);
  }
}
