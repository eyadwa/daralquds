import 'package:flutter/cupertino.dart';


import 'package:flutter/material.dart';
class LectureInformation  with ChangeNotifier{
  int? lectureNum;
  String? title;
  String? publishDate;
  int? courseId;
  int? pages;
  int? lectureId;
  bool? isDeleted;
  int? price;
  int? yearid;
  Null? year;
  String? linkurl;
  Null? course;
  Null? studentLectures;
  Null? studentNotes;

  LectureInformation(
      {this.lectureNum,
      this.title,
      this.publishDate,
      this.courseId,
      this.pages,
      this.lectureId,
      this.isDeleted,
      this.price,
      this.yearid,
      this.year,
      this.linkurl,
      this.course,
      this.studentLectures,
      this.studentNotes});

  LectureInformation.fromJson(Map<String, dynamic> json) {
    lectureNum = json['lectureNum'];
    title = json['title'];
    publishDate = json['publishDate'];
    courseId = json['courseId'];
    pages = json['pages'];
    lectureId = json['lectureId'];
    isDeleted = json['isDeleted'];
    price = json['price'];
    yearid = json['yearid'];
    year = json['year'];
    linkurl = json['linkurl'];
    course = json['course'];
    studentLectures = json['studentLectures'];
    studentNotes = json['studentNotes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lectureNum'] = this.lectureNum;
    data['title'] = this.title;
    data['publishDate'] = this.publishDate;
    data['courseId'] = this.courseId;
    data['pages'] = this.pages;
    data['lectureId'] = this.lectureId;
    data['isDeleted'] = this.isDeleted;
    data['price'] = this.price;
    data['yearid'] = this.yearid;
    data['year'] = this.year;
    data['linkurl'] = this.linkurl;
    data['course'] = this.course;
    data['studentLectures'] = this.studentLectures;
    data['studentNotes'] = this.studentNotes;
    return data;
  }
}