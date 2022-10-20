import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:lectures/constant/HttpException.dart';
import 'package:lectures/provider/auth.dart';
import 'package:lectures/screen/informtion.dart';
import 'package:lectures/screen/login_screen.dart';
import 'package:lectures/screen/otp.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _authdata = {};
  String? _firstName;
  String? _lastname;
  String? _phone;
  String? _email;
  String? _password;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('فشل عملية إنشاء الحساب '),
        content: Text(message),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'))
        ],
      ),
    );
  }

  void _showSuccessDialog(String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.LEFTSLIDE,
      desc: message,
      btnOkIcon: Icons.check_circle,
      btnOkOnPress: () {
        // return Navigator.of(context).pushReplacementNamed(HomePage.routName);
      },
      btnOkColor: Theme.of(context).primaryColor,
      onDissmissCallback: (_) {
        //   return Navigator.of(context).pushReplacementNamed(HomePage.routName);
      },
    ).show();
  }

  Future<bool> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return false;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    // if (_formKey.currentState!.validate()) {
    //   try {
    //     await Provider.of<Auth>(context, listen: false).signup(
    //       _authdata['firstname'],
    //       _authdata['lastname'],
    //       _authdata['phone'],
    //       _authdata['email'],
    //       _authdata['password'],
    //     );
    //     _showSuccessDialog('تم إنشاء الحساب');
    //   } on HttpException catch (error) {
    //     var errorMessage = error.toString();

    //     _showErrorDialog(errorMessage);
    //   } catch (error) {
    //     var errorMessage = error.toString();
    //     _showErrorDialog(errorMessage);
    //   }

    //}
    setState(() {
      _isLoading = false;
    });
    return true;
  }

  Widget _buildTextFields() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                cursorColor:Theme.of(context).primaryColor  ,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color:Theme.of(context).primaryColor ),


                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:Theme.of(context).primaryColorLight),
                  ),
                  icon: Icon(Icons.person_outlined,color:Theme.of(context).primaryColor),
                  labelText: 'الاسم الأول',
                ),
                // ignore: missing_return
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'هذا الحقل فارغ';
                  }
                },
                onSaved: (value) {
                  _authdata['firstname'] = value;
                },
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                cursorColor:Theme.of(context).primaryColor,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color:Theme.of(context).primaryColor ),

                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:Theme.of(context).primaryColorLight),
                  ),
                  icon: Icon(Icons.person_outlined,color: Theme.of(context).primaryColor,),
                  labelText: 'الاسم الأخير',
                ),
                // ignore: missing_return
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'هذا الحقل فارغ';
                  }
                },
                onSaved: (value) {
                  _authdata['lastname'] = value;
                },
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                cursorColor: Theme.of(context).primaryColor,
                keyboardType: TextInputType.phone,
                decoration:  InputDecoration(
                  labelStyle: TextStyle(color:Theme.of(context).primaryColor ),

                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:Theme.of(context).primaryColorLight),
                  ),
                  icon: Icon(Icons.phone_android,color: Theme.of(context).primaryColor,),
                  labelText: 'رقم الهاتف',
                ),
                // ignore: missing_return
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'هذا الحقل فارغ';
                  }
                },
                onSaved: (value) {
                  _authdata['phone'] = value;
                },
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                cursorColor: Theme.of(context).primaryColor,
                keyboardType: TextInputType.emailAddress,
                decoration:   InputDecoration(
                  labelStyle: TextStyle(color:Theme.of(context).primaryColor ),

                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:Theme.of(context).primaryColorLight),
                  ),
                  icon: Icon(Icons.email_outlined,color: Theme.of(context).primaryColor,),
                  labelText: 'البريد االكتروني',
                ),
                // ignore: missing_return
                validator: (String? value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'الايميل غير صالح';
                  }
                },
                onSaved: (value) {
                  _authdata['email'] = value;
                },
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                cursorColor: Theme.of(context).primaryColor,
                textDirection: TextDirection.ltr,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration:  InputDecoration(
                  labelStyle: TextStyle(color:Theme.of(context).primaryColor ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:Theme.of(context).primaryColorLight),
                  ),
                  icon: Icon(Icons.lock_outline,color: Theme.of(context).primaryColor,),
                  labelText: 'كلمة السر',
                ),
                // ignore: missing_return
                validator: (String? value) {
                  if (value!.isEmpty || value.length < 5) {
                    return 'كلمة السر قصيرة جدا';
                  }
                },
                onSaved: (value) {
                  _authdata['password'] = value;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: _isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).primaryColor,
                ),
              ),
              child: Text(
                'إنشاء حساب',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.white, fontSize: 20),
              ),
              onPressed: ()async {
                print("i'm sign up button ");
                // try  {
               if ( await _submit()){
                 _isLoading =true;
                 setState(() {

                 });
                 await Provider.of<Auth>(context, listen: false).signup(
                   _authdata['firstname'],
                   _authdata['lastname'],
                   _authdata['phone'],
                   _authdata['email'],
                   _authdata['password'],

                 );
                 _isLoading =false;
                 Provider.of<Auth>(context, listen: false).notifyListeners();

                    Navigator.pop(context);

               }


                print(
                    "information student submited to data base \n thank u very much \n done ");

                // _showSuccessDialog('تم إنشاء الحساب');
                // } on HttpException catch (error) {
                //   var errorMessage = error.toString();
                //
                //   //   _showErrorDialog(errorMessage);
                // } catch (error) {
                //   var errorMessage = error.toString();
                //   //   _showErrorDialog(errorMessage);
                // }
                // }
                //  _submit,
              }),
                );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.pop(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'تسجيل دخول',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'لديك حساب ؟',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final containerHeight = deviceHeight - topPadding - bottomPadding;
    return WillPopScope(
      onWillPop: ()async{

       Navigator.of(context).pop();
       return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(
              color: Theme.of(context).primaryColor //change your color here
              ),
          backgroundColor: Colors.white,
          title: Text(
            'إنشاء حساب جديد',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            height: containerHeight,
            margin: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(child: _buildTextFields()),
                  _submitButton(),
                  _loginAccountLabel(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
