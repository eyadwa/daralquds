

import 'package:flutter/material.dart';
import 'package:lectures/model/course.dart';
import 'package:lectures/provider/courses.dart';
import 'package:lectures/provider/lectures.dart';
import 'package:lectures/screen/LectureInformation/lecture_information_screen.dart';
import 'package:lectures/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

class ImageLecturesScreen extends StatelessWidget {
  static const routName = '/image-lecture-screen';
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
        elevation: 0,
        iconTheme: Theme.of(context).copyWith().iconTheme,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "قائمة المحاضرات",
          style: TextStyle(color: Colors.black38),
        )
        // Image.asset(
        //   'assets/images/comment-icon.png',
        //   width: 100,
        //   height: 100,
        // ),

        );
    final mediaQueryData = MediaQuery.of(context);
    final realHight = mediaQueryData.size.height -
        appBar.preferredSize.height -
        mediaQueryData.padding.top;
    return Scaffold(
        // backgroundColor: Color(0xFFEEEEEE),
        appBar: appBar,
        // drawer: AppDrawer(),
        body: FutureBuilder(
            future: Provider.of<Lectures>(context, listen: false)
                .getLectureData(5),
                    // Provider.of<Auth>(context, listen: false)
                    //     .userId
                    //     .toString()
                    
            builder: (ctx, snapshotData) {
              if (snapshotData.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshotData.error != null) {
                return Center(child: Text('Cannt fetch Data from Srever'));
              } else {
                return Consumer<Lectures>(
                    builder: (ctx, lectureData, _) => ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: lectureData.lectures.length,
                        itemBuilder: (ctx, index) => Container(
                          
                            child:
                             Container(
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    10), //border corner radius
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.5), //color of shadow
                                    spreadRadius: 5, //spread radius
                                    blurRadius: 7, // blur radius
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                    //first paramerter of offset is left-right
                                    //second parameter is top to down
                                  )
                                ],
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      LecturesInformationScreen.routName);
                                },
                                child: ListTile(
                                 
                                  trailing: Text(
                                    lectureData.lectures[index].title!,
                                    // style: Theme.of(context)
                                    //     .textTheme
                                    //     .headline1!
                                    //     .copyWith(
                                    //         fontWeight: FontWeight.normal,
                                    //         fontSize: 15),
                                  ),
                                ),
                              ),
                            )

                            //  ListView.builder(
                            //     shrinkWrap: true,
                            //     physics: const ClampingScrollPhysics(),
                            //     itemCount: 12,
                            //     itemBuilder: (ctx, i) =>

                            //         )
                            )));
              }
            }));

    //  Consumer<Course>(
    //   builder: (ctx, courseData, _) => ListView.builder(
    //     shrinkWrap: true,
    //     physics: ClampingScrollPhysics(),
    //     itemCount: courseData.studentCourses.length,
    //     itemBuilder: (ctx, index) => Column(
    //       children: [
    //         Row(
    //           mainAxisAlignment:
    //               MainAxisAlignment.spaceBetween,
    //           children: [
    //             FittedBox(
    //               child: Text(
    //                 courseData
    //                     .studentCourses[index].courseName,
    //                 style: Theme.of(context)
    //                     .textTheme
    //                     .headline1
    //                     .copyWith(
    //                         fontWeight: FontWeight.normal,
    //                         fontSize: 15),
    //               ),
    //             ),
  }
}
// FutureBuilder(
                  // future: Provider.of<Course>(context, listen: false)
                  //     .getStudentCourse(
                  //         Provider.of<Auth>(context, listen: false)
                  //             .userId
                  //             .toString()),
                  // builder: (ctx, snapshotData) {
                  //   if (snapshotData.connectionState ==
                  //       ConnectionState.waiting) {
                  //     return Center(
                  //       child: CircularProgressIndicator(),
                  //     );
                  //   } else if (snapshotData.error != null) {
                  //     return Center(
                  //         child: Text('Cannt fetch Data from Srever'));
                  //   } else {
                  //     return Consumer<Course>(
                  //       builder: (ctx, courseData, _) => ListView.builder(
                  //         shrinkWrap: true,
                  //         physics: ClampingScrollPhysics(),
                  //         itemCount: courseData.studentCourses.length,
                  //         itemBuilder: (ctx, index) => Column(
                  //           children: [
                  //             Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 FittedBox(
                  //                   child: Text(
                  //                     courseData
                  //                         .studentCourses[index].courseName,
                  //                     style: Theme.of(context)
                  //                         .textTheme
                  //                         .headline1
                  //                         .copyWith(
                  //                             fontWeight: FontWeight.normal,
                  //                             fontSize: 15),
                  //                   ),
                  //                 ),