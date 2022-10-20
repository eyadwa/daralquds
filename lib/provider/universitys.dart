import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:lectures/constant/HttpException.dart';
import 'package:lectures/constant/app_config.dart';
import 'package:lectures/model/university.dart';
import 'package:http/http.dart' as http;

class Universitys with ChangeNotifier {
  List<University> _universitys = [
    //   University(
    //       universityId: "1",
    //       city: "Damas",
    //       universityName: "Damascus",
    //       isDeleted: false),
    //   University(
    //       universityId: "2",
    //       city: "Homs",
    //       universityName: "Albath",
    //       isDeleted: false),
    //   University(
    //       universityId: "3",
    //       city: "Aleppo",
    //       universityName: "Alepoo",
    //       isDeleted: false),
  ];
  List<University> get universitys {
    return [..._universitys];
  }

  Future<void> featchAndSetUni() async {
    print("llllllllllllllllllllllllllll");

    final Uri url = Uri.parse(
        "http://tadcenter2022-001-site1.itempurl.com/StudentMobile/getUniversities");
    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw HttpException('حدثت مشكلة مع السيرفر');
    }
    final responseData = json.decode(response.body);
    print("888888888888888888888888888");
    print(responseData.runtimeType);
    List<University> loadeditems = [];
    for (var unit in responseData['universities']) {
      loadeditems.add(
        University.fromJson(unit),
      );
    }
    _universitys = loadeditems;
    notifyListeners();
    // print(_universitys.length);
    // _universitys = _universitys;
    print("llllllllllllllllllllllllllll");
    print(_universitys.length);
  }
}
