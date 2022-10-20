import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lectures/model/course.dart';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:lectures/constant/HttpException.dart';
import 'package:lectures/model/faculity.dart';

class Courses with ChangeNotifier {
  List<Course> _courses = [];
  List<Course> get courses {
    return [..._courses];
  }

  List<Course> _studentCourses = [];
  List<Course> get studentCourses {
    return [..._studentCourses];
  }

  Future<void> fetchCourses(int stydentId) async {
    print("****************************** get course");
    final Uri url = Uri.parse(
        'http://tadcenter2022-001-site1.itempurl.com/StudentMobile/getStudentCourse?studentId=$stydentId');
    //http: //tadcenter2022-001-site1.itempurl.com/StudentMobile/getStudentCourse?studentId=5

    final response = await http.get(url);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode != 200) {
      throw Exception('Something get wrong please try it later');
    }
    final List<Course> loadedCourse = [];
    final responseData = json.decode(response.body);
    print('responseData : $responseData');
    for (var course in responseData['courses']) {
      loadedCourse.add(Course.fromJson(course));
    }

    _courses = loadedCourse;
    print("ggggggggggg");
    print(loadedCourse.first);
    notifyListeners();
  }
}
