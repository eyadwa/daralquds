import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lectures/widgets/app_drawer.dart';
import 'package:lectures/widgets/profile_listTile.dart';
import 'package:provider/provider.dart';

import '../provider/auth.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Consumer<Auth>(
      builder: (context, authProvider, _) => Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: Container(
                alignment: Alignment.topCenter,
                child: Text(
                  "الملف الشخصي",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Theme.of(context).primaryColorLight, fontSize: 22),
                ),
              ),
              elevation: 10,
              shadowColor: Theme.of(context).primaryColor,
              iconTheme: Theme.of(context).copyWith().iconTheme,
              centerTitle: true,
              backgroundColor: Colors.grey.shade100,
            ),
            body: authProvider.isGetProfile == true
                ? Container(
                    color: Theme.of(context).primaryColor.withOpacity(0.88),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: height * .02,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                    "assets/images/logo.png",
                                    width: height * .4,
                                    height: width * 0.3,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(
                                  height: height * .01,
                                ),
                                Text(
                                  "${authProvider.person!.phone}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        ProfileListTile(
                          title: "الاسم",
                          subTitle:
                              "${authProvider.person!.firstName} ${authProvider.person!.lastName}",
                        ),
                        ProfileListTile(
                          title: "البريد الالكتروني",
                          subTitle: "${authProvider.person!.email}",
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Material(
                            elevation: 5,
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(width * .02),
                                child: Column(children: [
                                  Text("الرصيد",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          fontWeight: FontWeight.bold)),
                                  Text("${authProvider.person!.balance}",
                                      style:  const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ]),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              AwesomeDialog(
                                context: context,
                                body: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Form(
                                      key: authProvider.changePasswordFormKey,
                                      child: Column(
                                        children: [
                                          const Text("نتغير كلمة السر"),
                                          SizedBox(
                                            height: height * .02,
                                          ),
                                          TextFormField(
                                            validator: (val) {
                                              val = authProvider
                                                  .passwordChange.text;
                                              if (val.isEmpty) {
                                                return " لايمكن ان يكون الحقل فارغ";
                                              } else {
                                                return null;
                                              }
                                            },
                                            controller:
                                                authProvider.passwordChange,
                                            decoration: const InputDecoration(
                                                helperText:
                                                    "كلمة المرور الجديدة",
                                                border: OutlineInputBorder()),
                                          ),
                                          SizedBox(
                                            height: height * .02,
                                          ),
                                          TextFormField(
                                            validator: (val) {
                                              val = authProvider
                                                  .passwordChangeConfirm.text;
                                              if (val !=
                                                  authProvider
                                                      .passwordChange.text) {
                                                return " الحقلان غير متطابقان";
                                              } else {
                                                return null;
                                              }
                                            },
                                            controller: authProvider
                                                .passwordChangeConfirm,
                                            decoration: const InputDecoration(
                                                helperText: "تأكيد كلمة المرور",
                                                border: OutlineInputBorder()),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                btnOkText: "تأكيد",
                                btnOkColor: Theme.of(context).primaryColorLight,
                                btnOkOnPress: () async {
                                  if (authProvider
                                      .changePasswordFormKey.currentState!
                                      .validate()) {
                                    await authProvider
                                        .changeUserPassword(
                                            authProvider.person!.id.toString(),
                                            authProvider.passwordChange.text)
                                        .then((value) {
                                      if (value) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Row(
                                              children:  [
                                               const   Text(
                                                    'تم تغير كلمة المرور بنجاح'),
                                                SizedBox(width: width*0.2,),
                                                const Icon(Icons.done_all,color: Colors.green,size: 25,),
                                              ],
                                            ),
                                            backgroundColor: Theme.of(context)
                                                .primaryColor,
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                                'حدث خطأ ما الرجال المحاولة لاحقا'),
                                            backgroundColor: Theme.of(context)
                                                .primaryColor,
                                          ),
                                        );
                                      }
                                    });
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text(
                                          'لايوجد تطابق بكلمة المرور',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),


                                      duration:const  Duration(minutes: 1),
                                        action:SnackBarAction(onPressed: (){
                                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                        }, label: 'اغلاق',)


                                      ),
                                    );
                                  }
                                },
                                btnCancelOnPress: () {},
                                btnCancelText: "الغاء",
                                btnCancelColor: Theme.of(context)
                                    .primaryColorDark
                                    .withOpacity(.5),
                                dialogType: DialogType.NO_HEADER,
                              ).show();
                            },
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(10),
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).primaryColorLight)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "تغير كلمة السر",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ))
                      ],
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
          )),
    );
  }
}
