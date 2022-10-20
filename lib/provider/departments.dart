import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:lectures/constant/HttpException.dart';
import 'package:lectures/model/department.dart';

class Departments with ChangeNotifier {
  final List<Department> _departments = [
    // Department(
    //     universityId: "1",
    //     facultyId: "1",
    //     departmentId: "1",
    //     departmentName: "D1",
    //     isDeleted: false),
    // Department(
    //     universityId: "1",
    //     facultyId: "1",
    //     departmentId: "2",
    //     departmentName: "D2",
    //     isDeleted: false),
    // Department(
    //     universityId: "1",
    //     facultyId: "1",
    //     departmentId: "3",
    //     departmentName: "D3",
    //     isDeleted: false),
    // Department(
    //     universityId: "1",
    //     facultyId: "2",
    //     departmentId: "4",
    //     departmentName: "D4",
    //     isDeleted: false),
    // Department(
    //     universityId: "1",
    //     facultyId: "2",
    //     departmentId: "5",
    //     departmentName: "D5",
    //     isDeleted: false),
    // Department(
    //     universityId: "1",
    //     facultyId: "2",
    //     departmentId: "6",
    //     departmentName: "D6",
    //     isDeleted: false),

    // //*********** */

    // Department(
    //     universityId: "2",
    //     facultyId: "3",
    //     departmentId: "7",
    //     departmentName: "D7",
    //     isDeleted: false),
    // Department(
    //     universityId: "2",
    //     facultyId: "3",
    //     departmentId: "8",
    //     departmentName: "D8",
    //     isDeleted: false),
    // Department(
    //     universityId: "2",
    //     facultyId: "3",
    //     departmentId: "9",
    //     departmentName: "D9",
    //     isDeleted: false),
    // Department(
    //     universityId: "2",
    //     facultyId: "4",
    //     departmentId: "10",
    //     departmentName: "D10",
    //     isDeleted: false),
    // Department(
    //     universityId: "2",
    //     facultyId: "4",
    //     departmentId: "11",
    //     departmentName: "D11",
    //     isDeleted: false),
    // Department(
    //     universityId: "2",
    //     facultyId: "4",
    //     departmentId: "12",
    //     departmentName: "D12",
    //     isDeleted: false),
    // Department(
    //     universityId: "3",
    //     facultyId: "5",
    //     departmentId: "13",
    //     departmentName: "D13",
    //     isDeleted: false),
    // Department(
    //     universityId: "3",
    //     facultyId: "5",
    //     departmentId: "14",
    //     departmentName: "D14",
    //     isDeleted: false),
    // Department(
    //     universityId: "3",
    //     facultyId: "5",
    //     departmentId: "15",
    //     departmentName: "D15",
    //     isDeleted: false),
    // Department(
    //     universityId: "3",
    //     facultyId: "6",
    //     departmentId: "116",
    //     departmentName: "D16",
    //     isDeleted: false),
    // Department(
    //     universityId: "3",
    //     facultyId: "6",
    //     departmentId: "17",
    //     departmentName: "D17",
    //     isDeleted: false),
    // Department(
    //     universityId: "3",
    //     facultyId: "6",
    //     departmentId: "18",
    //     departmentName: "D18",
    //     isDeleted: false),
  ];
  List<Department> get departments {
    return [..._departments];
  }

  List<Department> _ddepartments = [];

  List<Department> get ddepartments {
    return [..._ddepartments];
  }

  Future<void> fetchDepartment(String faculityId) async {
    int faculityid = int.parse(faculityId);
    print("PPPPPPPPPPPPPPP${faculityid}");
    List<Department> loadedDepartment = [];
    final Uri url = Uri.parse(
        'http://tadcenter2022-001-site1.itempurl.com/StudentMobile/getDepartments?facultyId=$faculityid');

    final response = await http.get(url);
    print(response.body);
    if (response.statusCode != 200) {
      throw HttpException('حدثت مشكلة مع السيرفر');
    }
    final responseData = json.decode(response.body);
    for (var dep in responseData['faculties']) {
      //  print("OOOOOOOOOOOOOOOOOOOoo\n" + dep);
      // print(dep.departmentName);
      loadedDepartment.add(Department.fromJson(dep));
    }
    _ddepartments = loadedDepartment;
    notifyListeners();
  }
}
