import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
import 'package:lectures/model/lecture.dart';
import 'package:path_provider/path_provider.dart';

class Lectures with ChangeNotifier {
  List<Lecture> _lectures = [];
  List<Lecture> get lectures {
    return [..._lectures];
  }

  Lecture? _lecturesInformations;
  Lecture? get lecturesInformations {
    return _lecturesInformations;
  }

  List<Lecture> _newestLectures = [];
  List<Lecture> get newestLectures {
    return [..._newestLectures];
  }

  List<Uint8List> _lectureImages = [];
  List<Uint8List> get lectureImages {
    return [..._lectureImages];
  }

  Future<List<Lecture>> getCourseLectures(int studentId, int courseId) async {
    final Uri url = Uri.parse(
        'http://tadcenter2022-001-site1.itempurl.com/StudentMobile/getCourseLecture?studentId=5&courseId=$courseId');

    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw Exception('Something get wrong please try later');
    }
    final responseData = json.decode(response.body);
    print("nnnnnnnnnnnnnnnnnnnn");
    print(responseData);
    final List<Lecture> loadedLecture = [];
    for (var lec in responseData['lectures']) {
      loadedLecture.add(Lecture.fromJson(lec));
    }
    print(loadedLecture.length);
    _lectures = loadedLecture;
    notifyListeners();
    return loadedLecture.reversed.toList();
  }

  Future<List<Lecture>> getLastLecture(int studentId) async {
    final Uri url = Uri.parse(
        'http://tadcenter2022-001-site1.itempurl.com/StudentMobile/getCourseLecture?studentId=$studentId');

    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw Exception('Something get wrong please try later');
    }
    final responseData = json.decode(response.body);
    print("nnnnnnnnnnnnnnnnnnnn");
    print(responseData);
    final List<Lecture> loadedLecture = [];
    for (var lec in responseData['lectures']) {
      loadedLecture.add(Lecture.fromJson(lec));
    }
    print(loadedLecture.length);
    _lectures = loadedLecture;
    notifyListeners();
    return loadedLecture.reversed.toList();
  }

  Future<Lecture> getgetLecture(int lectureId) async {
    final Uri url = Uri.parse(
        'http://tadcenter2022-001-site1.itempurl.com/StudentMobile/getLecture?lectureId=$lectureId');

    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw Exception('Something get wrong please try later');
    }
    final responseData = json.decode(response.body);
    print("nnnnnnnnnnnnnnnnnnnnfffffffffffffffffffffffffffffffff");
    print(responseData);
    //List<Lecture> loadedLecture = [];
    print(responseData['lecture']);
    Lecture x = Lecture.fromJson(responseData['lecture']);
    // for (var lec in responseData['lecture']) {
    print("888888888888888");
    //   print(lec.toString());
    //   loadedLecture.add(Lecture.fromJson(lec));
    //   print("**************");
    //   print(loadedLecture.length);
    // }
    // loadedLecture.add(x);
    print(x);
    _lecturesInformations = x;
    notifyListeners();
    return x;
  }

//

  // Future<void> getNewestLecture(String studentId) async {
  //   List<String> coursesId = await getAllStudentCourse(studentId);
  //   // print(studentId);
  //   print('courseId $coursesId');
  //   final List<Lecture> loadedLecture = [];

  //   for (int i = 0; i < coursesId.length; i++) {
  //     final url =
  //         'http://www.studyhub-sy.com/Mobile/getCourseLectures?courseId=${coursesId[i]}';
  //     final response = await http.get(url);
  //     print('getNewestLecture ${response.statusCode}');
  //     if (response.statusCode != 200) {
  //       throw Exception('Something get wrong please try later');
  //     }
  //     final responseData = json.decode(response.body) as List<dynamic>;
  //     if (responseData.length > 0) {
  //       loadedLecture.add(
  //         Lecture.fromJson(responseData.last),
  //       );
  //     }
  //     // for (var lec in responseData) {
  //     //   loadedLecture.add(Lecture.frpmJson(lec));
  //     // }

  //   }
  //   print('loadedLecture $loadedLecture');
  //   _newestLectures = loadedLecture;
  //   notifyListeners();
  // }

  Future<void> getLectureData(int lecId) async {
    final Uri url = Uri.parse(
        'http://tadcenter2022-001-site1.itempurl.com/StudentMobile/getLecturePages?lectureId=$lecId');

    final response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode != 200) {
      throw HttpException('حصل خطأ أثناء جلب بيانات المحاضرة من الخادم');
    }
    final responseData = json.decode(response.body);
    print(responseData);
    List<Uint8List> loadedImageData = [];
    for (var img in responseData["pages"]) {
      print(
          "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII");
      print(base64.decode(img["pageDate"].split(',').last));
      print(
          "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII");
      loadedImageData.add(base64.decode(img['pageDate'].split(',').last));
    }
    _lectureImages = loadedImageData;
    notifyListeners();
    // String localPath = await _localPath;
    // File localFile = await _getlocalFile('$lecId');
    await writeLectureData(response.body.toString(), '$lecId');
    print('lecId $lecId');
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    print("UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU");
    print(directory);

    return directory.path;
  }

  Future<File> _getlocalFile(String fileName) async {
    final path = await _localPath;
    print("UUUUUUUUddddddddddddUUUUUUUUUUUUUUUUUUUUUUUU");
    print('$path/$fileName');
    return File('$path/$fileName');
  }

  Future<File> writeLectureData(dynamic responseData, String fileName) async {
    final file = await _getlocalFile(fileName);

    // Write the file.
    return file.writeAsString('$responseData');
  }

  Future<void> readLecureData(String fileName) async {
    try {
      print('OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO');
      print(fileName);
      final file = await _getlocalFile(fileName);
      print('test for ca');

      print('OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO');
      print(file);

      // Read the file.
      final contents = await file.readAsString();
      print('OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOcontantes');
      print(contents);
      final responseData = jsonDecode(contents);
      print('OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOresponse');
      print(responseData);
      List<Uint8List> loadedImageData = [];
      for (var img in responseData["pages"]) {
        print('OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOimg');

        print(img['pageDate'].split(',').last);
        loadedImageData.add(base64.decode(img['pageDate'].split(',').last));
      }
      _lectureImages = loadedImageData;
      print("#############################################################################################################################################################################");

      notifyListeners();
      // return true;
    } catch (e) {
      // print(e);
      // print(fileName);
      await getLectureData(int.parse(fileName));
      // return false;int.parse(fileName
      // If encountering an error, return 0.
      // return 0;

    }
  }

  // Future<List<String>> getAllStudentCourse(String studentId) async {
  //   final url =
  //       'http://www.studyhub-sy.com/Mobile/getStudentCourse?studentId=$studentId';
  //   final response = await http.get(url);
  //   if (response.statusCode != 200) {
  //     throw Exception('Somthing get wrong please try later');
  //   }
  //   print(response.statusCode);
  //   final responseData = json.decode(response.body);
  //   final List<String> loadedStudentCourse = [];
  //   for (var course in responseData) {
  //     loadedStudentCourse.add(
  //       Course.fromJson(course).courseId,
  //     );
  //   }
  //   return loadedStudentCourse;
  // }

}
