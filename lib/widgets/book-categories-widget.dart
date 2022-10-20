import 'package:flutter/material.dart';
class BookCategoryW extends StatelessWidget {
  const BookCategoryW({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return  GestureDetector(

      child: Card(

        shape:const   RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(20))),

      child  : Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                child: ClipOval(
                  child:Image.asset(
                    'assets/images/logo.png',

                    fit: BoxFit.cover,
                  ),
                ),
              ),


            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.01,
            ),
            Text("اسم التصنيف ",style:  TextStyle(fontWeight: FontWeight.w400,color:Theme.of(context).primaryColorLight),),
          ],
        ),

      ),
    );
  }
}
