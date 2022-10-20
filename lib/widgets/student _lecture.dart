import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lectures/provider/books_provider.dart';
import 'package:provider/provider.dart';

import '../screen/latest-download-books.dart';

class BooksCategories extends StatelessWidget {
  BooksCategories({Key? key, required this.id, required this.name, this.image})
      : super(key: key);

  int id;
  String name;
  String? book;
  String? subCategories;
  String? image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Consumer<BooksProvider>(
        builder: (context, bookProvider, _) =>
         ElevatedButton(
          onPressed: ()async{
            bookProvider.isFromBookById=true;
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const  LatestDownBook()));
          await  bookProvider.getBooksByCateId(id);
          },
          style: ElevatedButton.styleFrom(
              primary: Colors.white,

              textStyle: TextStyle(

                 )),

          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  child: ClipOval(
                    child: Image.asset(
                     image?? 'assets/images/logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Text(
                "$name",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColorLight),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
