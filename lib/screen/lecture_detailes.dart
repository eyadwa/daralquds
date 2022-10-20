import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:lectures/provider/books_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

class BookDetails extends StatelessWidget {
  const BookDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Consumer<BooksProvider>(
          builder: (context, bookProvider, _) => bookProvider.bookDetailModel ==
                  null
              ? Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColorLight,
                  ),
                )
              : bookProvider.bookDetailModel!.pages!.isEmpty
                  ? Center(
                      child:
                          Container(child: Text("اليوجد معلومات لهذا الكتاب")),
                    )
                  : PhotoViewGallery.builder(
                      scrollDirection: Axis.vertical,
                      backgroundDecoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                      ),
                      scrollPhysics: const BouncingScrollPhysics(),
                      builder: (ctx, index) => PhotoViewGalleryPageOptions(
                        imageProvider: MemoryImage(
                            bookProvider.bookDetailModel!.pages![index]),
                        initialScale: PhotoViewComputedScale.contained * 0.8,
                        minScale: PhotoViewComputedScale.contained * 0.5,
                        maxScale: PhotoViewComputedScale.covered * 1.1,
                      ),
                      itemCount: bookProvider.bookDetailModel!.pages!.length,
                    ),
        ),
      ),
    );
  }
}
