import 'package:flutter/material.dart';
import 'package:lectures/widgets/body_information_student.dart';

class InformationStudent extends StatelessWidget {
  static const routName = '/information-student';
  @override
  Widget build(BuildContext context) {
    var _authdata =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print("auth data from signup page is \n" + _authdata['firstname']);
    final mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
            color: Theme.of(context).accentColor //change your color here
            ),
        backgroundColor: Colors.white,
        title: Text(
          'إنشاء حساب جديد',
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: mediaQueryData.size.width * 0.08),
          child: BodyInformation(authdata: _authdata),
        ),
      ),
    );
  }
}
