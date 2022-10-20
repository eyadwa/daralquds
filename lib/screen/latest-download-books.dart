
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/books_provider.dart';
import '../widgets/book-categories-widget.dart';
import '../widgets/book_widget.dart';

class LatestDownBook extends StatelessWidget {
  const LatestDownBook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(


        title:   Container(
          padding:EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
          alignment: Alignment.topCenter,
          child: Text("الكتب",
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Theme.of(context).primaryColorLight,fontSize: 22),
          ),
        ),
        foregroundColor: Colors.amber,
        elevation: 0,
        iconTheme: Theme.of(context).copyWith().iconTheme,
        centerTitle: true,
        backgroundColor: Colors.grey.shade100,
      ),
        body: Consumer<BooksProvider>(
          builder: (context, bookProvider, _) =>
         bookProvider.isGetAllBookById?  Container(
            padding:const EdgeInsets.only(top: 8,bottom: 10,right: 8,left: 8),

            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,

            ),

            child:  Consumer<BooksProvider>(
              builder: (context, bookProvider, _) =>
               GridView.builder(gridDelegate:const  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 3.75,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20
              ), itemBuilder: (context,index){

                return   BookWidget(
                  isRecent: true,

                  bookModel: bookProvider.isFromBookById?   bookProvider.allBookById[index] :bookProvider.lastBooks[index],
                );

              },
                shrinkWrap: true,
                itemCount: bookProvider.isFromBookById? bookProvider.allBookById.length : bookProvider.lastBooks.length,

              ),
            ),
          ) : Center(child:
           CircularProgressIndicator(color: Theme.of(context).primaryColorLight,)
           ,),
        ),
    );
  }
}
