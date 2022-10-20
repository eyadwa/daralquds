import 'package:flutter/material.dart';

class ProfileListTile extends StatelessWidget {
   ProfileListTile({Key? key,required this.title,required this.subTitle}) : super(key: key);
  String title;
  String subTitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 5,
        child: ListTile(
          title: Text("$title" , style: TextStyle(color: Theme.of(context).primaryColorLight,fontWeight: FontWeight.bold),),
          subtitle: Text("$subTitle",style: TextStyle(color: Colors.black),),

        ),
      ),
    );
  }
}
