

import 'package:flutter/material.dart';
import 'package:lectures/privacy_policy/privacy_policy.dart';
import 'package:lectures/provider/auth.dart';
import 'package:provider/provider.dart';
import '../constant/colors.dart';
import '../constant/colors.dart';
import '../constant/colors.dart';
import '../constant/colors.dart';
import 'signup_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _authdata = {};
  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: message.isEmpty? const Text('فشل عملية تسجيل الدخول') : Text(message),
              content: message.isEmpty?  const Text('يرجى إعادة المحاولة') : const Text("يرجى إنشاء حساب  "),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'))
              ],
            ));
  }

  void _showSuccessDialog(String message, context ) {
    List<String> mSplit = message.split(',');
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.LEFTSLIDE,
      body: Column(children:  [
        Text(mSplit[0]),
        SizedBox(height: MediaQuery.of(context).size.height*0.02,),
        Text(mSplit[1]),
      ],),

      btnOkIcon: Icons.check_circle,
      btnOkColor: Theme.of(context).primaryColor,
      btnOkOnPress: (){
        Navigator.pop(context);
      }

    ).show();
  }

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      print("invalid invalid");
      // Invalid!
      return;
    }
    print("valid  valid");
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    print(_authdata['phone'],);
    print(_authdata['password'],);
    try {
     bool authResult =await Provider.of<Auth>(context, listen: false).login(
        _authdata['phone'],
        _authdata['password'],
      );
     authResult? print('تم تسجيل الدخول,اضفط خارح الإطار للإغلاق') : print('الحساب غير موجود ');
    } catch (error) {
      print("errorrrrrrrrrrrrrrrr accourding");
      var errorMessage = error.toString();

      print("Error is : $errorMessage");
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  Widget _passwordTextField() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
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
          // validator: (String? value) {
          //   if (value!.isEmpty || value.length < 5) {
          //     return 'كلمة السر قصيرة جدا';
          //   }
          // },
          onSaved: (value) {

            _authdata['password'] = value;

          },
        ),
      ),
    );
  }

  Widget _phoneNumberTextField() {

    return Container(

      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(

          keyboardType: TextInputType.phone,


          decoration:InputDecoration(
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
    );
  }

  Widget _forgetPassword() {
    return Container(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () => {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => ForgetPasswordScreen()))
        },
        child: Text('نسيت كلمة السر؟',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _submitButton( ) {
    return Container(
      width: double.infinity,
      margin:const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: _isLoading == false
          ? TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).primaryColor,
                ),
              ),

              child: Text(
                'تسجيل دخول',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                _submit(context);
              }
              )
          :const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _privacyPolicy(){
    return Row (
      mainAxisAlignment: MainAxisAlignment.start
      ,
      mainAxisSize :MainAxisSize.min,
      children: [
        TextButton(onPressed: (){

          Navigator.push(context, MaterialPageRoute(builder: (context)=> const PrivacyPolicy()));
        }, child: Expanded(
          flex: 2,
          child: Text("سياسة الخصوصية",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Theme.of(context).primaryColorLight,
              fontWeight: FontWeight.bold,
            fontSize: 16
          ),
          ),
        ),
        ),
        Expanded(flex: 1,child: Text("بالضغط تسجيل الدخول انت موافق على" ,style: Theme.of(context) .textTheme.bodyText1!.copyWith(fontSize: 14,color: Theme.of(context).primaryColor,fontWeight: FontWeight.w500))) ,

      ],

    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignupScreen()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('إنشاء حساب',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Theme.of(context).primaryColorLight,
                    fontWeight: FontWeight.bold)),
          const   SizedBox(
              width: 10,
            ),
            Text('ليس لديك حساب؟',
                style: Theme.of(context).textTheme.bodyText1),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPading = MediaQuery.of(context).padding.bottom;
    final containerHeight = deviceHeight - topPadding - bottomPading;
    // final auth = Provider.of<Auth>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body:
          // auth.isAuth
          //     ? MainProfileScreen()
          //     :
          SingleChildScrollView(
            child: Container(
        margin: EdgeInsets.only(top: topPadding, bottom: bottomPading),
        padding: const  EdgeInsets.symmetric(horizontal: 20),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Image.asset('assets/images/logoo.png'),

                _phoneNumberTextField(),
                _passwordTextField(),
                _forgetPassword(),
                _submitButton(),
                _privacyPolicy(),
                _createAccountLabel(),

              ],
            ),
        ),
      ),
          ),
    );
  }
}
