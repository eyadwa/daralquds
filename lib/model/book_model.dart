import 'dart:typed_data';

class BookModel {

  int id ;
  int catId;
  int writerId;
  int pages ;
  double price ;
 String? publishDate ;
  String title;
  String? writerName;
  bool? isFromRecentDownBook;
  Uint8List? image;


  BookModel({

    required this.id,
    required this.catId,
    required this.writerId,
    required this.pages,
    required this.price,
     this.publishDate,
    this.writerName,
    required this.title,
    this.isFromRecentDownBook,
    this.image

  });


}