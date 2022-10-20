import 'package:flutter/material.dart';
class LatestDownBook extends StatelessWidget {
  const LatestDownBook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child:Row(),
        ),
      ),
    );
  }
}
