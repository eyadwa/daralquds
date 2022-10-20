
// import 'package:connectivity/connectivity.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:study_hub/provider/news.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:intl/intl.dart';

// class NewsWidget extends StatelessWidget {
//   _launchURL(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: Connectivity().onConnectivityChanged,
//         builder: (ctx, _) => FutureBuilder(
//               future: Provider.of<News>(context, listen: false).getNews(),
//               builder: (cts, snapshotData) {
//                 if (snapshotData.connectionState == ConnectionState.waiting) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else if (snapshotData.error != null) {
//                   return Center(
//                     child: Text('يرجى التحقق من الاتصال بالانترنت'),
//                   );
//                 } else {
//                   return Consumer<News>(
//                     builder: (ctx, newsData, _) => ListView.builder(
//                       shrinkWrap: true,
//                       // physics: ClampingScrollPhysics(),
//                       padding: EdgeInsets.all(10),
//                       // scrollDirection: Axis.horizontal,
//                       itemCount: newsData.news.length,
//                       itemBuilder: (ctx, index) => Card(
//                         margin: EdgeInsets.only(bottom: 12),
//                         elevation: 4,
//                         shape: RoundedRectangleBorder(
//                           side: BorderSide(color: Colors.white70, width: 1),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(right: 8),
//                               child: RichText(
//                                 text: TextSpan(
//                                   children: <TextSpan>[
//                                     TextSpan(
//                                       text: newsData.news[index].newsText,
//                                       style:
//                                           Theme.of(context).textTheme.headline2,
//                                       recognizer: TapGestureRecognizer()
//                                         ..onTap = () {
//                                           _launchURL(
//                                               newsData.news[index].newsUrl);
//                                         },
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 8.0),
//                               child: Align(
//                                 alignment: Alignment.bottomLeft,
//                                 child: Text(
//                                   DateFormat('yyyy-MM-dd').format(
//                                     DateTime.parse(
//                                         newsData.news[index].publishDate),
//                                   ),
//                                   style: TextStyle(
//                                       color: Theme.of(context).primaryColor),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 }
//               },
//             ));
//   }
// }
