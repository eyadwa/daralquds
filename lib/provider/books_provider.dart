import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:lectures/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lectures/model/book_model.dart';
import 'package:lectures/widgets/book_widget.dart';
import 'package:path_provider/path_provider.dart';
import '../model/book_images_model.dart';
import '../model/books_category_model.dart';

class BooksProvider with ChangeNotifier {
  bool isCategoriesGet = false;
  List<BooksCategories> allCategories = [];
  List<BookModel> allBookById = [];
  List<BookModel> lastBooks = [];
  bool isGetAllBookById = false;

  List<Uint8List> _bookImages = [];
  List<Uint8List> get lectureImages {
    return [..._bookImages];
  }
  BookDetailModel? bookDetailModel;
  bool isFromBookById = false;

  Future<void> getAllCategories() async {
    var url = Uri.http(BASE_URL,'/api/mobile/getAllCateg');
    var response = await http.get(url);
    print(" this is status code from get all category  ${response.statusCode}");

    if (response.statusCode == 200) {
      allCategories.clear();

      var resposeDate = json.decode(response.body);
      print("category get successfully");

      for (var cat in resposeDate['catogaries']) {
        allCategories.add(BooksCategories(id: cat['id'], name: cat['name']));
      }

      isCategoriesGet = true;
      notifyListeners();
    }
    else{print("error while fetch categories  with status code ${response.statusCode}");}
  }

  Future<void> getBooksByCateId(int catId) async {
    isGetAllBookById = false;
    notifyListeners();

    var url = Uri.http(BASE_URL, '/api/mobile/GetBookByCat', {"id": "$catId"});
    var response = await http.get(url);
    print(
        " this is status code from get books depend on there id  : ${response.statusCode}");

    if (response.statusCode == 200) {
      allBookById.clear();
      print("book by id get successfully");

      var books = json.decode(response.body);
      print("the response is :   $books");

      for (var book in books['books']) {
        allBookById.add(BookModel(
            id: book['id'] as int,
            catId: book['catId'] as int,
            writerId: book['writreId'] as int,
            pages: book['pages'] as int,
            price: .0 + book['price'],
            title: book['title'],
            isFromRecentDownBook: false));
        isGetAllBookById = true;
        notifyListeners();
      }
    }
  }

  Future<void> getLastBooks() async {
    isGetAllBookById = false;
    notifyListeners();

    var url = Uri.http(BASE_URL, 'api/mobile/GetLastBooks');
    var response = await http.get(url);
    print(" this is status code from get lassssst books depend on there id  ");

    if (response.statusCode == 200) {
      lastBooks.clear();
      print("get last book ");

      var books = json.decode(response.body);
      print("the response is :   $books");

      for (var book in books['books']) {
        lastBooks.add(BookModel(
            id: book['id'] as int,
            catId: book['catId'] as int,
            writerId: book['writreId'] as int,
            pages: book['pages'] as int,
            price: .0 + book['price'],
            title: book['title'],
            isFromRecentDownBook: false));
        isGetAllBookById = true;
        notifyListeners();
      }
    }
  }

  Future<void> getBookDetails(BookModel bookModel) async {

  //   SharedPreferences sp = await SharedPreferences.getInstance();
  // await  sp.remove('Books');
  //  sp.setStringList('Books', ['{id:6}','{id:5}']) ;
  //
  //   if(sp.containsKey('Books')){
  //
  //     List<String> booksList =   sp.getStringList("Books")!;
  //
  //     var map1 = Map.fromIterable(booksList, key: (e) =>  e, value: (e) => e);
  //     print(map1);
  //     print(map1.length);
  //
  //
  //         return;
  //       }
  //      else{ return ;}


    _bookImages.clear();
    final para = {"lectureId": '${bookModel.id}'};
      var url = Uri.http(BASE_URL, '/api/mobile/GetAllPages', para);
      final response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode != 200) {

        print("erroe while getting book");
        throw HttpException('حصل خطأ أثناء جلب بيانات المحاضرة من الخادم');
      }

      if(response.statusCode==200){
        final responseData = json.decode(response.body);
        print(responseData);
        List<Uint8List> loadedImageData = [];
        bookDetailModel =BookDetailModel(id: bookModel.id  ,pages: []);

        for (var img in responseData["pages"]) {

          print(base64.decode(img["pageDate"]));
          bookDetailModel!.pages!.add(base64.decode(img['pageDate']));
        }
        _bookImages = loadedImageData;
        notifyListeners();
        await writeBookData(response.body.toString(), '${bookModel.id}');
        print('lecId ${bookModel.id}');
      }
      else{
        bookDetailModel = BookDetailModel(id: bookModel.id ,pages: []);
        notifyListeners();
      }

  }

  Future<File> writeBookData(responseData, String fileName) async {
    final file = await _getlocalFile(fileName);

    return file.writeAsString('$responseData');
  }

  Future<File> _getlocalFile(String fileName) async {
    final path = await _localPath;
    print("path to save book is ${path + "/" + fileName}");
    return File('$path/$fileName');
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    print("get application directory");
    print(directory);
    return directory.path;
  }



  Future<void> readLecureData(String fileName) async {
    try {
      print('OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO');
      print(fileName);
      final file = await _getlocalFile(fileName);
      print('test for ca');

      print('OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO');
      print(file);

      // Read the file.
      final contents = await file.readAsString();
      print('OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOcontantes');
      print(contents);
      final responseData = jsonDecode(contents);
      print('OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOresponse');
      print(responseData);
      List<Uint8List> loadedImageData = [];
      for (var img in responseData["pages"]) {
        print('OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOimg');

        print(img['pageDate'].split(',').last);
        loadedImageData.add(base64.decode(img['pageDate'].split(',').last));
      }
     // _lectureImages = loadedImageData;
      print("#############################################################################################################################################################################");

      notifyListeners();
      // return true;
    } catch (e) {

      print ("error while read data from path  ");

      // print(e);
      // print(fileName);
     // await getLectureData(int.parse(fileName));
      // return false;int.parse(fileName
      // If encountering an error, return 0.
      // return 0;

    }

  }


}
