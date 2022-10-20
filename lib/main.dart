import 'package:flutter/material.dart';
import 'package:lectures/constant/colors.dart';
import 'package:lectures/model/class_year.dart';
import 'package:lectures/model/course.dart';
import 'package:lectures/model/lecture.dart';
import 'package:lectures/model/lecture_informatiom.dart';
import 'package:lectures/provider/auth.dart';
import 'package:lectures/model/department.dart';
import 'package:lectures/model/faculity.dart';
import 'package:lectures/provider/books_provider.dart';
import 'package:lectures/provider/class_years.dart';
import 'package:lectures/provider/courses.dart';
import 'package:lectures/provider/lectures.dart';
import 'package:lectures/provider/universitys.dart';
import 'package:lectures/provider/departments.dart';
import 'package:lectures/provider/faculitys.dart';
import 'package:lectures/screen/ImageLecture/image_lecture_screen.dart';
import 'package:lectures/screen/LectureInformation/lecture_information_screen.dart';
import 'package:lectures/screen/course/course_screen.dart';
import 'package:lectures/screen/home.dart';
import 'package:lectures/screen/informtion.dart';
import 'package:lectures/screen/lectures/lecture_screen.dart';
import 'package:lectures/screen/profile.dart';
import 'model/university.dart';
import 'package:lectures/screen/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider.value(value: Auth()..tryAutoLogin()),
        ChangeNotifierProvider.value(value: BooksProvider()),
        ChangeNotifierProvider.value(value: University()),
        ChangeNotifierProvider.value(value: Department()),
        ChangeNotifierProvider.value(value: Faculty()),
        ChangeNotifierProvider.value(value: Facultys()),
        ChangeNotifierProvider.value(value: Universitys()),
        ChangeNotifierProvider.value(value: Departments()),
        ChangeNotifierProvider.value(value: ClassYear()),
        ChangeNotifierProvider.value(value: ClassYears()),
        ChangeNotifierProvider.value(value: Lecture()),
        ChangeNotifierProvider.value(value: Lectures()),
        ChangeNotifierProvider.value(value: Course()),
        ChangeNotifierProvider.value(value: Courses()),
        ChangeNotifierProvider.value(value: LectureInformation())
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: cprimaryColor,
            primaryColorLight: csupportColor,
            errorColor: cwarningColor,
            backgroundColor: clightColor,
            bottomAppBarColor: Colors.white,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white54,
              toolbarTextStyle: TextStyle(
                fontFamily: 'Helvetica-Neue-LT-Arabic-55-Roman',
                fontSize: 12 * MediaQuery.textScaleFactorOf(context),
              ),
            ),
            textTheme: TextTheme(
              bodyText1: TextStyle(
                fontFamily: 'Helvetica-Neue-LT-Arabic-55-Roman',
                fontSize: 16 * MediaQuery.textScaleFactorOf(context),
                color: cprimaryColor,
              ),
              bodyText2: TextStyle(
                fontFamily: 'Helvetica-Neue-LT-Arabic-55-Roman',
                fontSize: 14 * MediaQuery.textScaleFactorOf(context),
                color: cprimaryColor,
              ),
            ),
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: csecondColor),
          ),
           home:
          auth.isAuth == true
              ? const  HomePage() : FutureBuilder(

                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? const HomePage()
                          : LoginPage()),
          routes: {
            InformationStudent.routName: (ctx) => InformationStudent(),
            CoursesScreen.routName: (ctx) => CoursesScreen(),
            LecturesScreen.routName: (ctx) => LecturesScreen(),
               LecturesInformationScreen.routName: (ctx) => LecturesInformationScreen(),
              ImageLecturesScreen.routName:(ctx)=>ImageLecturesScreen(),
              // LectureDetailes.routName: (ctx) => LectureDetailes(lecture: )
               
          },
        ),
      ),
    );
  }
}
