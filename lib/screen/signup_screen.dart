import 'package:flutter/material.dart';
import 'package:lectures/widgets/signup_form.dart';

class SignupScreen extends StatelessWidget {
  static const routName = '/signup-screen';
  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return SignUpPage();

    // Scaffold(
    //   appBar: AppBar(
    //     elevation: 0,
    //     iconTheme: IconThemeData(
    //         color: Theme.of(context).accentColor //change your color here
    //         ),
    //     backgroundColor: Colors.white,
    //     title: Text(
    //       'إنشاء حساب جديد',
    //       style: TextStyle(color: Theme.of(context).accentColor),
    //     ),
    //   ),
    //   body: SingleChildScrollView(
    //     child: Padding(
    //         padding: EdgeInsets.symmetric(
    //             horizontal: mediaQueryData.size.width * 0.08),
    //         child: SignUpPage()),
    //   ),
    // );
  }
}
