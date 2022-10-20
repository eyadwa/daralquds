import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lectures/constant/app_config.dart';
import 'package:lectures/model/person.dart';
import 'package:lectures/model/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';

class Auth with ChangeNotifier {
  String _ownerId = " ";
  String? _name;
  String? _number;
  String? _password;
  String? _email;
  String? nameForDrawer;
  String? numberForDrawer;

  String? userName;
  String? userNumber;
  String? password;
  Person? person;
  bool? isGetProfile = false;

  final changePasswordFormKey = GlobalKey<FormState>();
  TextEditingController passwordChange = TextEditingController();
  TextEditingController passwordChangeConfirm = TextEditingController();
  TextEditingController cobonTextController = TextEditingController();

  String? get ownerId {
    return _ownerId;
  }

  set ownerId(String? x) {
    _ownerId = x!;
  }

  dynamic get isAuth {
    if (ownerId == " ") {
      return false;
    } else {
      return true;
    }
  }

  List<UserInfo> _userInformation = [];

  List<UserInfo> get userInformation {
    return [..._userInformation];
  }

  Future<void> signup(
    String firstname,
    String lastname,
    String phone,
    String email,
    String password,
  ) async {
    print("welcome in signup page");
    Map <String , String > para = {
      "firstName" : "$firstname",
      "lastName" : "$lastname",
      "password" : "$password",
      "email" : "$email",
      "phone" : "$phone",




    };
    final Uri url = Uri.http(BASE_URL ,'/api/mobile/addClient',para);
    final response = await http.post(
      url,

      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      print("sign up ok .................................... sign uo ok ");
      final responseData = json.decode(response.body);
      _ownerId = responseData['client']['id'].toString();
      _name = responseData['client']['firstName'].toString();
      _number = responseData['client']['phone'].toString().trim();
      _password = responseData['client']['password'].toString();
      userName = _name;
      userNumber = _number;
      password = _password!;
      final prefs = await SharedPreferences.getInstance();
      final userAuthData = json.encode({
        //   // 'token': _token,
        'ownerId': _ownerId,
        'name': _name,
        'phone': _number,
        'password': _password
      });

      prefs
          .setString('userAuthData', userAuthData)
          .then((value) => print("the id is added to sharedpreferanc \n"));
      notifyListeners();

    } else {
      print("error while sign up  with status code : ${response.statusCode}");

    }
  }

  setUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    Map userInfo = json.decode(prefs.getString('userAuthData')!);
    nameForDrawer = userInfo['name'];
    numberForDrawer = userInfo['phone'];
    userName = nameForDrawer;
    userNumber = numberForDrawer;
  }

  Future<bool> login(String phone, String password) async {
    print("i'm login function");
    print('  $phone password is $password');

    Map<String, String> para = {"phone": "$phone", "password": "$password"};

    var url = Uri.parse('http://tadcenter2022-001-site3.atempurl.com/api/mobile/logIn?phone=0912345678&password=11111111');
    var response = await http.get(url);

    print("sending ... the status code is  ${response.statusCode}");
    if (response.statusCode == 200) {
      print("the status code is 200");
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('isAuth', 'true');
      final responseData = json.decode(response.body);
      print("the response od login fun is : ${responseData}");
      _ownerId = responseData['client']['id'].toString();
      _name = responseData['client']['firstName'].toString();
      print(
          " the user name is ${_name = responseData['client']['firstName'].toString()}");
      _email = responseData['client']['email'].toString();
      _number = responseData['client']['phone'].toString();
      userName = _name;
      userNumber = _number;
      final userAuthData = json.encode({
        "ownerId": _ownerId.toString(),
        "name": _name.toString(),
        "email": _email.toString(),
        "phone": _number.toString()
      });
      prefs
          .setString('userAuthData', userAuthData)
          .then((value) => print("the id is added to sharedpreferanc \n"));

      notifyListeners();
      return true;
    } else {
      print(
          "an error has been appear  with status code ${response.statusCode}");
      return false;
    }
  }

  Future<bool> tryAutoLogin() async {
    print("i'm try auto login function");
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('userAuthData')) {
      print("login true ");
      final extractedUserData =
          json.decode(prefs.getString('userAuthData')!) as Map<String, dynamic>;
      _ownerId = extractedUserData['ownerId'].toString();
      print('id is  ${_ownerId = extractedUserData['ownerId']}');
      userName = extractedUserData['name'].toString();
      print("user name from sh is : ${extractedUserData['name'].toString()}");
      userNumber = extractedUserData['_phone'];
      print('phone is  ${userNumber = extractedUserData['phone']}');
      _email = extractedUserData['email'];
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<void> logout() async {
    _ownerId = " ";
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userAuthData');
    notifyListeners();
  }

  Future<void> getUserInfo(String phone, String password) async {
    final Uri url = Uri.parse(
        'http://tadcenter2022-001-site1.itempurl.com//api/mobile/logIn?mobile=$phone&password=$password');

    final response = await http.post(url);
    if (response.statusCode != 200) {
      throw Exception('Something get wrong please try later');
    }
    final responseData = json.decode(response.body);
    print("Respone is");
    print(responseData.runtimeType);
    final List<UserInfo> loadedInfo = [];
    for (var unit in responseData['student']) {
      loadedInfo.add(UserInfo.fromMap(unit));
    }

    print("length is");

    print(loadedInfo.length);

    _userInformation = loadedInfo;
    notifyListeners();
  }
  
  Future<void> getUserProfile ()async{
    isGetProfile=false;
    notifyListeners();

    Map<String,String> para = {

      "id" :_ownerId
    };

    print("  owner id   $_ownerId");
    final url = Uri.http(BASE_URL, "/api/mobile/GetClient",para);
    
     var response = await http.get(url);
    if(response.statusCode==200){
      print(jsonDecode(response.body));
      var personJson = jsonDecode(response.body);
      person= Person.fromJson(personJson["client"][0]);
      print("person id : ${person!.id}");


      isGetProfile=true;
      notifyListeners();




      print("the data has been got successfully ${json.decode(response.body)}");


    }
    else{
      print("wrong with fetch data with status code ${response.statusCode}");
      isGetProfile=false;
      notifyListeners();

    }
    
  }


  Future<bool> addUserCobon ()async{

    Map<String,String> para = {

      "clientId" : _ownerId,
      "cobonId" :cobonTextController.text,
    };
    final url = Uri.http(BASE_URL, "api/mobile/BuyCobon",para);

    final response = await http.post(url);

    if(response.statusCode==200){
      print("the status code of add cobon is ${response.statusCode}");
      return true;

    }
    else{
      print("the status code of add cobon is ${response.statusCode}");
      return false;
    }



  }




  Future<bool> changeUserPassword (String id , String password)async{

    Map<String , String> para = {
      "id" : id,
      "password" : password
    };

    final url = Uri.http(BASE_URL, "/api/mobile/ResetPassword",para);
    final response = await http.put(url);
    if(response.statusCode == 200){
      return true;
    }
    else{
      print("حدث خطأ اثناء تغير كلمة المرور مع رمز الخطأ  ${response.statusCode}");
      return false;

    }

  }
  
}
