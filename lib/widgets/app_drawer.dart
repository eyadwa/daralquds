import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:lectures/provider/auth.dart';
import 'package:lectures/provider/books_provider.dart';
import 'package:lectures/screen/books-categories-screen.dart';
import 'package:lectures/screen/course/course_screen.dart';
import 'package:lectures/screen/latest-download-books.dart';
import 'package:lectures/screen/profile.dart';
import 'package:lectures/screen/user_profile.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatelessWidget {
  Widget listTileBuilder(
      BuildContext context, IconData leading, String title, var onTap) {
    return ListTile(
      leading: Icon(
        leading,
        color: Theme.of(context).primaryColorLight,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final bool _isProtrait = mediaQueryData.orientation == Orientation.portrait;
    // print((mediaQueryData.size.width));
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: mediaQueryData.size.width / 1.5,
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Theme.of(context)
                .primaryColor, //This will change the drawer background to blue.
            //other styles
          ),
          child: Drawer(
            elevation: 4,
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        DrawerHeader(
                            padding: EdgeInsets.all(0),
                            margin: EdgeInsets.all(0),
                            child: Container(
                                alignment: Alignment.center,
                                color: Theme.of(context).primaryColorLight,
                                height: _isProtrait
                                    ? (mediaQueryData.size.height -
                                            mediaQueryData.padding.top) *
                                        0.20
                                    : (mediaQueryData.size.height -
                                            mediaQueryData.padding.top) *
                                        0.4,
                                child: Consumer<Auth>(
                                  builder: (context, authProvider, _) => Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                      ),
                                      CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'assets/images/default_profile.jpg'),
                                        radius: 30,
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),
                                      Text(
                                        authProvider.userName ?? "ssss",
                                        // Provider.of<Auth>(context, listen: false)
                                        //     .userName,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),
                                      Text(
                                        authProvider.userNumber!,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ))
                            // padding:
                            //     EdgeInsets.only(top: mediaQueryData.size.height * 0.1),
                            ),
                        Consumer<BooksProvider>(
                          builder: (context, bookProvider, _) =>
                              listTileBuilder(
                                  context, Icons.list, 'لائحة بتصنيفات الكتب',
                                  () {
                            bookProvider.isGetAllBookById = true;
                            Navigator.push(
                                context,
                                (MaterialPageRoute(
                                    builder: (context) =>
                                        const BooksCategoriesScreen())));
                          }),
                        ),

                        Consumer<BooksProvider>(
                          builder: (context, bookProvider, _) =>
                              listTileBuilder(context, FontAwesomeIcons.book,
                                  'الكتب المحملة مؤخرا', () async {
                            bookProvider.isFromBookById = false;

                            Navigator.push(
                                context,
                                (MaterialPageRoute(
                                    builder: (context) =>
                                        const LatestDownBook())));

                            await bookProvider.getLastBooks();
                          }),
                        ),
                        Consumer<Auth>(
                          builder: (context, authProvider, _) =>
                              listTileBuilder(
                                  context, Icons.person, 'الملف الشخصي',
                                  () async {
                                    Navigator.pop(context);
                            authProvider.getUserProfile();
                            await Navigator.push(
                                context,
                                (MaterialPageRoute(
                                    builder: (context) => const Profile())));
                          }),
                        ),
                        Consumer<Auth>(
                          builder: (context, authProvider, _) =>
                              listTileBuilder(
                                  context, Icons.discount, 'كود الخصم', () {
                            AwesomeDialog(
                              context: context,
                              body: Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  children: [
                                    Text("أدخل كود الخصم"),
                                    SizedBox(
                                      height: mediaQueryData.size.height * .02,
                                    ),
                                    TextFormField(
                                      controller:
                                          authProvider.cobonTextController,
                                      validator: (val) {
                                        val = authProvider
                                            .cobonTextController.text;
                                        if (val.isEmpty) {
                                          return "لايمكن ان يكون الحقل فارغ";
                                        } else
                                          return null;
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder()),
                                    ),
                                    SizedBox(
                                      height: mediaQueryData.size.height * .02,
                                    ),
                                  ],
                                ),
                              ),
                              btnOkText: "تأكيد",
                              btnOkColor: Theme.of(context).primaryColorLight,
                              btnOkOnPress: () async {
                                await authProvider.addUserCobon().then((value) {
                                  if (value == true) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text("تم اضافة الكوبون تفقد رصيدك "),
                                        action:SnackBarAction(
                                          label: "تفقد",
                                          onPressed: ()async{
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
                                            await authProvider.getUserProfile();
                                          },
                                        ) ,
                                        ),

                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          (""
                                              "خطأ في اذافة الكوبون تأكد من صحة الكوبون"),
                                        ),
                                      ),
                                    );
                                  }
                                 // Navigator.pop(context);
                                });
                              },
                              btnCancelOnPress: () {},
                              btnCancelText: "الغاء",
                              btnCancelColor: Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(.5),
                              dialogType: DialogType.NO_HEADER,
                            ).show();
                          }),
                        ),
                        listTileBuilder(
                            context, Icons.support_agent, 'الدعم الفني ', () {
                          launch('https://t.me/samer1251');
                        }),
                        // listTileBuilder(
                        //     context, Icons.star_rate, 'قيّم التطبيق', () {
                        //   // launch('http://t.me/RahimAbbas');
                        // }),
                        listTileBuilder(context, Icons.call, 'اتصل بنا ', () {
                          launch('https://t.me/samer1251');
                        }),

                        // listTileBuilder(context, Icons.menu_book, 'قسم الكورسات', () {
                        //   Navigator.of(context).pushReplacement(
                        //     MaterialPageRoute(
                        //       builder: (ctx) => HomeOnlineCourseScreen(),
                        //     ),
                        //   );
                        // }),
                      ],
                    ),
                  ),
                  listTileBuilder(context, Icons.logout, 'تسجيل خروج', () {
                    // Navigator.of(context).pop();
                    // Navigator.of(context).pushReplacementNamed('/');
                    Provider.of<Auth>(context, listen: false).logout();
                  }),
                  Padding(
                    padding: EdgeInsets.only(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(
                            FontAwesomeIcons.telegram,
                            color: Color(0xfff6a91b),
                          ),
                          onPressed: () {
                            launch('https://t.me/samer1251');
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.email,
                            size: 25,
                            color: Color(0xfff6a91b),
                          ),
                          onPressed: () {
                            launch(
                              'mailto::samersolltan@gmail.com',
                            );
                          },
                        ),
                        // IconButton(
                        //   icon: Icon(
                        //     FontAwesomeIcons.facebookF,
                        //     color: Colors.white,
                        //   ),
                        //   onPressed: () {
                        //     launch(""
                        //         // 'https://fb.me/StudyHub.Sy',
                        //         );
                        //   },
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
