import 'package:flutter/material.dart';
import 'package:lectures/model/course.dart';
import 'package:lectures/model/lecture.dart';
import 'package:lectures/provider/courses.dart';
import 'package:lectures/provider/lectures.dart';
import 'package:lectures/screen/ImageLecture/image_lecture_screen.dart';
import 'package:lectures/screen/ImageLecture/lecture_detales.dart';
import 'package:lectures/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

class LecturesInformationScreen extends StatelessWidget {
  static const routName = '/lecture-Information-screen';
  @override
  Widget build(BuildContext context) {
    var deviseSize = MediaQuery.of(context).size;
    var deviseWidth = deviseSize.width;
    var deviseheight = deviseSize.height;
    final appBar = AppBar(
        elevation: 0,
        iconTheme: Theme.of(context).copyWith().iconTheme,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "معلومات المحاضرة",
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
            future:
                Provider.of<Lectures>(context, listen: false).getgetLecture(5
                    // Provider.of<Auth>(context, listen: false)
                    //     .userId
                    //     .toString()
                    ),
            builder: (ctx, snapshotData) {
              if (snapshotData.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshotData.error != null) {
                return Center(child: Text('Cannt fetch Data from Srever'));
              } else {
                return Consumer<Lectures>(
                    builder: (ctx, lectureData, _) => Center(
                          child: Container(
                            margin: EdgeInsets.all(50),
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
                            child: Column(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      print("navigator to screenLectures");
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                  child: Text(
                                                lectureData
                                                    .lecturesInformations!
                                                    .lectureNum
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                              Text("  :رقم المحاضرة"),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                  child: Text(
                                                lectureData
                                                    .lecturesInformations!
                                                    .title!,
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                              Text("  :عنوان المحاضرة"),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                  child: Text(
                                                lectureData
                                                    .lecturesInformations!.pages
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                              Text("  :عدد صفحات المحاضرة"),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                  child: Text(
                                                lectureData
                                                    .lecturesInformations!
                                                    .publishDate!
                                                    .substring(0, 10),
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                              Text("  :تاريح نشر المحاضرة"),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: deviseWidth / 2,
                                          child: TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                Theme.of(context).primaryColor,
                                              ),
                                            ),
                                            child: Text(
                                              'تأكيد',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                            ),
                                            onPressed: () async {
                                              // Navigator.of(context).pushNamed(
                                              //     ImageLecturesScreen.routName);
                                              Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => LectureDetailes(
                                    lecture: lectureData.lecturesInformations!
                                                   ),
                              ),
                            );
                                            },
                                          ),
                                        )
                                      ],
                                    )
                                    //: ListTile(
                                    //   title: Text("data"),
                                    //   subtitle: Text("llllllllll"),
                                    //   trailing: Text(
                                    //
                                    //     // style: Theme.of(context)
                                    //     //     .textTheme
                                    //     //     .headline1!
                                    //     //     .copyWith(
                                    //     //         fontWeight: FontWeight.normal,
                                    //     //         fontSize: 15),
                                    //   ),

                                    // ),
                                    ),
                              ],
                            ),
                          ),
                        ));
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
