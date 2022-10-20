import 'package:flutter/material.dart';
import 'package:lectures/model/book_model.dart';
import 'package:lectures/provider/books_provider.dart';
import 'package:lectures/screen/lecture_detailes.dart';
import 'package:provider/provider.dart';

class BookWidget extends StatelessWidget {
  BookWidget({Key? key,required this.isRecent,required this.bookModel}) : super(key: key);

  bool? isRecent;
  BookModel bookModel ;// if true the widget will be related with (Recent books)  , false (my books)
  @override
  Widget build(BuildContext context) {
    return isRecent==false? InkWell(
      onTap: (){
        print ('book\'s from recently uploaded server books    id is ${ bookModel.id}');
      },
      child: Card(

        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding:const  EdgeInsets.symmetric(vertical: 17),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        "اسم الكتاب ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColorLight),
                      ),
                      Text(
                        "تاريخ النشر",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColorLight),
                      ),
                      Text(
                        "عدد الصفحات",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColorLight),
                      ),
                      Text(
                        "الفئة",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColorLight),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    )
    :Consumer<BooksProvider>(
      builder: (context, bookProvider, _) =>
       InkWell(
        onTap: ()async{
          print ('book\'s id is ${ bookModel.id}');
          Navigator.push(context, MaterialPageRoute(builder: (context)=>BookDetails()));
          await bookProvider.getBookDetails(bookModel);

        },
        child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            children: [
              Expanded(
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.contain,
                ),
              ),
           bookModel.isFromRecentDownBook!?  Text(
                "معلومات الكتاب ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColorLight),
              ) :
              Column(children: [
                Text("${bookModel.title}"),
                Text("${bookModel.price}"),
                Text("${bookModel.writerName??"اسم الناشر"}"),
                Text("تاريخ النشر"),


              ],)


            ],
          ),
        ),
      ),
    );
  }
}
