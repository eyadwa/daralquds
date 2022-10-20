import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:lectures/constant/HttpException.dart';
import 'package:lectures/model/class_year.dart';
import 'package:lectures/model/department.dart';
import 'package:lectures/model/faculity.dart';
import 'package:lectures/model/university.dart';
import 'package:lectures/provider/class_years.dart';
import 'package:lectures/provider/departments.dart';
import 'package:lectures/provider/faculitys.dart';
import 'package:lectures/provider/universitys.dart';

import 'package:provider/provider.dart';
// import 'package:study_hub/provider/Library.dart';
// import 'package:study_hub/provider/course.dart';
// import 'package:study_hub/provider/department.dart';
// import 'package:study_hub/provider/faculity.dart';
// import 'package:study_hub/provider/register_type.dart';
// import 'package:study_hub/provider/university.dart';

import '../provider/auth.dart';
import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:provider/provider.dart';

class BodyInformation extends StatefulWidget {
  Map<String, dynamic> authdata;

  BodyInformation({required this.authdata});
  @override
  _BodyInformationState createState() => _BodyInformationState();
}

class _BodyInformationState extends State<BodyInformation> {
  static final _formKey = GlobalKey<FormState>();
  University? selectedUniveersity;
  Faculty? selectedFaculty;
  Department? selectedDepartment;
  ClassYear? selectClassYear;

  var isloding = false;
  var _isSubmited = false;
  var init = true;
  void didChangeDependencies() {
    if (init) {
      setState(() {
        isloding = true;
      });
      Provider.of<Universitys>(context, listen: false)
          .featchAndSetUni()
          .then((value) {
        setState(() {
          isloding = false;
        });
      });
    }
    init = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    print("the data from body information is \n" +
        widget.authdata['facId'].toString() +
        "\n" +
        widget.authdata['departmentId'].toString() +
        widget.authdata['StudyyearId'].toString());
    // setState(() {
    //   _isSubmited = true;
    // });
    //if (_formKey.currentState!.validate()) {
    try {
      await Provider.of<Auth>(context, listen: false).signup(
        widget.authdata['firstname'],
        widget.authdata['lastname'],
        widget.authdata['phone'],
        widget.authdata['email'],
        widget.authdata['password'],
     //   widget.authdata['facId'],
       // widget.authdata['departmentId'],
       // widget.authdata['StudyyearId'],
      );
      print(
          "information student submited to data base \n thank u very much \n done ");

        // _showSuccessDialog('تم إنشاء الحساب');
    } on HttpException catch (error) {
      var errorMessage = error.toString();

      //   _showErrorDialog(errorMessage);
    } catch (error) {
      var errorMessage = error.toString();
      //   _showErrorDialog(errorMessage);
    }
    // }
    // setState(() {
    //   _isSubmited = false;
    // });
  }

  Widget build(BuildContext context) {
    FocusNode _coponFocusNode = FocusNode();
    final universityData = Provider.of<Universitys>(context);
    print("+++++++++++++++");
    // print(universityData.universitys.length);
    final facultyData = Provider.of<Facultys>(context);
    final departmentData = Provider.of<Departments>(context);
    final classyearData = Provider.of<ClassYears>(context);

    var deviseSize = MediaQuery.of(context).size;
    var deviseWidth = deviseSize.width;
    var deviseheight = deviseSize.height;
    print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
    // print(selectedUniveersity);
    // print(universityData.universitys.first.universityName);
    return isloding
        ? CircularProgressIndicator()
        : Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Text(
                    'المعلومات الشخصية ',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(height: deviseheight * 0.05),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(
                              right: 10, top: 2, bottom: 2),

                          decoration: BoxDecoration(
                            color: const Color(0xFFCFF0ED),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                                color: const Color(0xFFBEE3E0), width: 2),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          //chose university
                          child: DropdownButtonFormField<University?>(
                            decoration:const InputDecoration(border: InputBorder.none),
                            dropdownColor: const Color(0xFFCFF0ED),
                            hint: Text("اختر جامعتك",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      decorationStyle:
                                          TextDecorationStyle.dashed,
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                    )),
                            iconEnabledColor: const Color(0xFF009688),

                            onChanged: (University? val) {
                              print("KLKLKLKLKLKLKL");

                              setState(() {
                                selectedUniveersity = val;
                                selectedFaculty = null;
                                selectedDepartment = null;
                              });
                              Provider.of<Facultys>(context, listen: false)
                                  .fetchFaculty(val!.universityId!.toString());
                            },

                            // postionData.postions.map<DropdownMenuItem<Postion>>
                            value: selectedUniveersity,
                            items: universityData.universitys
                                .map<DropdownMenuItem<University?>>(
                              (uni) {
                                return DropdownMenuItem<University>(
                                  value: uni,
                                  child: Text(
                                    uni.universityName!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.blue),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  selectedUniveersity != null
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05)
                      : Container(),
                  selectedUniveersity != null
                      ? Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(
                                    right: 10, top: 2, bottom: 2),

                                decoration: BoxDecoration(
                                  color: const Color(0xFFCFF0ED),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                      color: const Color(0xFFBEE3E0), width: 2),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                //chose university
                                child: DropdownButtonFormField<Faculty?>(
                                   decoration: InputDecoration(border: InputBorder.none),
                                  onSaved: (newValue) {
                                    widget.authdata['facId'] =
                                        newValue!.facultyId;
                                  },
                                  dropdownColor: const Color(0xFFCFF0ED),
                                  hint: Text("اختر كليتك",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            decorationStyle:
                                                TextDecorationStyle.dashed,
                                            fontSize: 16,
                                            fontStyle: FontStyle.italic,
                                          )),
                                  iconEnabledColor: const Color(0xFF009688),
                                  onChanged: (val) async {
                                    print("******************");
                                    // FocusScope.of(context)
                                    //     .requestFocus(FocusNode())
                                    setState(() {
                                      //selectedUniveersity = val!;
                                      selectedFaculty = val!;
                                      // selectedDepartment = null;
                                    });
                                    await Provider.of<Departments>(context,
                                            listen: false)
                                        .fetchDepartment(selectedFaculty!
                                            .facultyId
                                            .toString());
                                  },
                                  // postionData.postions.map<DropdownMenuItem<Postion>>
                                  value: selectedFaculty,
                                  items: facultyData.faculty
                                      .map<DropdownMenuItem<Faculty?>>(
                                    (fac) {
                                      return DropdownMenuItem<Faculty>(
                                          value: fac,
                                          child: Text(
                                            fac.name!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(color: Colors.blue),
                                          ));
                                    },
                                  ).toList(),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  selectedFaculty != null
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05)
                      : Container(),
                  selectedFaculty != null
                      ? Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(
                                    right: 10, top: 2, bottom: 2),

                                decoration: BoxDecoration(
                                  color: const Color(0xFFCFF0ED),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                      color: const Color(0xFFBEE3E0), width: 2),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                //chose university
                                child: DropdownButtonFormField<Department?>(
                                   decoration: InputDecoration(border: InputBorder.none),
                                  onSaved: (newValue) {
                                    widget.authdata['departmentId'] =
                                        newValue!.departmentId;
                                  },
                                  dropdownColor: const Color(0xFFCFF0ED),
                                  hint: Text("اختر قسمك",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            decorationStyle:
                                                TextDecorationStyle.dashed,
                                            fontSize: 16,
                                            fontStyle: FontStyle.italic,
                                          )),
                                  iconEnabledColor: const Color(0xFF009688),
                                  onChanged: (Department? val) async {
                                    setState(() {
                                      selectedDepartment = val!;
                                    });
                                    await Provider.of<ClassYears>(context,
                                            listen: false)
                                        .fetchclass(selectedDepartment!
                                            .departmentId!
                                            .toString());
                                  },
                                  value: selectedDepartment,
                                  items: departmentData.ddepartments
                                      .map<DropdownMenuItem<Department?>>(
                                    (dep) {
                                      return DropdownMenuItem<Department>(
                                        value: dep,
                                        child: Text(
                                          dep.departmentName!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(color: Colors.blue),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  selectedDepartment != null
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05)
                      : Container(),
                  selectedDepartment != null
                      ? Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(
                                    right: 10, top: 2, bottom: 2),

                                decoration: BoxDecoration(
                                  color: const Color(0xFFCFF0ED),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                      color: const Color(0xFFBEE3E0), width: 2),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                //chose university
                                child: DropdownButtonFormField<ClassYear?>(
                                   decoration: InputDecoration(border: InputBorder.none),
                                  onSaved: (newValue) {
                                    widget.authdata['StudyyearId'] =
                                        newValue!.id;
                                  },
                                  dropdownColor: const Color(0xFFCFF0ED),
                                  hint: Text("اختر دفعتك",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            decorationStyle:
                                                TextDecorationStyle.dashed,
                                            fontSize: 16,
                                            fontStyle: FontStyle.italic,
                                          )),
                                  iconEnabledColor: const Color(0xFF009688),
                                  onChanged: (ClassYear? val) {
                                    setState(() {
                                      selectClassYear = val!;
                                    });
                                  },
                                  value: selectClassYear,
                                  items: classyearData.cclassyears
                                      .map<DropdownMenuItem<ClassYear?>>(
                                    (cla) {
                                      return DropdownMenuItem<ClassYear>(
                                        value: cla,
                                        child: Text(
                                          cla.yearname!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(color: Colors.blue),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),

                  selectClassYear != null
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05)
                      : Container(),
                  //      selectClassYear != null?
                  //       Container(
                  //         alignment: Alignment.centerRight,
                  //         padding: const EdgeInsets.only(right: 10, top: 2, bottom: 2),
                  // margin:const EdgeInsets.only(right: 10, top: 2, bottom: 200),
                  //         decoration: BoxDecoration(
                  //           color: const Color(0xFFCFF0ED),
                  //           shape: BoxShape.rectangle,
                  //           border:
                  //               Border.all(color: const Color(0xFFBEE3E0), width: 2),
                  //           borderRadius: const BorderRadius.all(
                  //             Radius.circular(10.0),
                  //           ),
                  //         ),
                  //         //chose university
                  //         child: TextFormField(
                  //           style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  //             color: Colors.blue
                  //           ),
                  //           textAlign: TextAlign.right,
                  //           keyboardType: TextInputType.text,
                  //           textInputAction: TextInputAction.next,
                  //           autofocus: true,

                  //           decoration: const InputDecoration(
                  //             border: InputBorder.none,
                  //             hintText: "كوبون الخصم",
                  //             hintStyle: TextStyle(),
                  //             fillColor: Color(0xFFCFF0ED),
                  //             filled: true,
                  //           ),

                  //           validator: (val) {
                  //             if (val!.isEmpty) {
                  //               return 'الحقل مطلوب';
                  //             }
                  //             return null;
                  //           },
                  //           onChanged: (val) {},
                  //           onSaved: (val) {},
                  //           onFieldSubmitted: (val) {

                  //           },
                  //         ),
                  //       ):Container()
                  //     ,
                  selectClassYear != null
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05)
                      : Container(),
                  selectClassYear != null
                      ? 
                      Container(
                        width: deviseWidth/2,
                        child: TextButton(
                          
                            style: ButtonStyle(
                              
                              backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor,
                              ),
                            ),
                            child: Text(
                              'تأكيد',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () async {
                              await _submit();
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => HomeScreen()));
                            },
                          ),
                      )
                     
                      : Container()
                ],
              ),
            ),
          );
  }
}
