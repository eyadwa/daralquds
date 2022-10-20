import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lectures/provider/books_provider.dart';
import 'package:lectures/widgets/app_drawer.dart';
import 'package:lectures/widgets/book_widget.dart';
import 'package:lectures/widgets/student%20_lecture.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  initState() {
    super.initState();
    print('hello from init state');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      print("after build");
      var bookProvider = Provider.of<BooksProvider>(context, listen: false);
      await bookProvider.getAllCategories();
      await bookProvider.getLastBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    print("from build");
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(top: size.height * 0.01),
          child: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ),
        title: Container(
          padding: EdgeInsets.only(top: size.height * 0.01),
          alignment: Alignment.topCenter,
          child: Text(
            "الكتب",
            style: Theme
                .of(context)
                .textTheme
                .bodyText1!
                .copyWith(
                color: Theme
                    .of(context)
                    .primaryColorLight, fontSize: 22),
          ),
        ),
        foregroundColor: Colors.amber,
        elevation: 0,
        iconTheme: Theme
            .of(context)
            .copyWith()
            .iconTheme,
        centerTitle: true,
        backgroundColor: Colors.grey.shade100,
      ),
      endDrawer: AppDrawer(),
      body: Container(
        child: Consumer<BooksProvider>(
          builder: (context, bookProvider, _) =>
          bookProvider.isCategoriesGet
              ? ListView(
            children: [
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                color: Colors.white,
                height: size.height * 0.14,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return BooksCategories(
                      id: bookProvider.allCategories[index].id,
                      name: bookProvider.allCategories[index].name,
                    );
                  },
                  itemCount: bookProvider.allCategories.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "أخر الكتب المحملة ",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(
                          color: Theme
                              .of(context)
                              .primaryColor,
                          fontSize: 22),
                    )),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              // Container(
              //   padding: const EdgeInsets.only(top: 10),
              //  //zcolor: Theme.of(context).primaryColorLight,
              //
              //   height:size.height*0.25 ,
              //   child: ListView.builder(itemBuilder: (context , index){
              //     return  BookWidget(
              //       isRecent:true ,
              //       bookModel: bookProvider.allBookById[index],
              //
              //     );
              //   },
              //
              //     itemCount: bookProvider.allBookById.length,
              //     scrollDirection: Axis.horizontal,
              //     padding: const EdgeInsets.all(0),
              //   ),
              //
              // ),
              Container(
                child: const Center(child: Text("لايوجد عناصر بعد")),
              ),
              // ElevatedButton(onPressed: ()async{
              //   bookProvider.readLecureData("6");
              //
              // }, child: Text("قراءة ملف ")),
              SizedBox(
                height: size.height * 0.01,
              ),
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "صدر حديثا  ",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(
                          color: Theme
                              .of(context)
                              .primaryColor,
                          fontSize: 22),
                    )),
              ),
              Consumer<BooksProvider>(
                builder: (context, bookProvider, _) =>
                    Container(
                      color: Theme
                          .of(context)
                          .primaryColorLight,
                      height: size.height * 0.60,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return BookWidget(
                            bookModel: bookProvider.lastBooks[index],
                            isRecent: false,
                          );
                        },
                        shrinkWrap: true,
                        itemCount: bookProvider.lastBooks.length,
                      ),
                    ),
              ),
            ],
          )
              : Center(
            child: CircularProgressIndicator(
              color: Theme
                  .of(context)
                  .primaryColorLight,
            ),
          ),
        ),
      ),
    );
  }
}
