import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:lectures/model/lecture.dart';
import 'package:lectures/provider/lectures.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

class LectureDetailes extends StatefulWidget {
  final Lecture lecture;
   static const routName = '/lecture-detales';
  LectureDetailes({required this.lecture});

  @override
  _LectureDetailesState createState() => _LectureDetailesState();
}

class _LectureDetailesState extends State<LectureDetailes> {
 
  int ?currentIndex;
  var _isInit = true;
  var _isLoading = false;
  Future<void> secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  void _showErrorAwesomeDialog(String error) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: false,
        title: 'خطأ',
        desc: error,
        btnOkOnPress: () {
          Navigator.of(context).pop();
        },
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red)
      .show();
  }

  @override
  void initState() {
    secureScreen();
    currentIndex = 0;
    super.initState();
  }
  // ignore: missing_return
  // Future<void> _future(BuildContext context, int lecId) async {
  //   await Provider.of<Lecture>(context, listen: false).readLecureData('$lecId');
  // }

  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      try {
        Provider.of<Lectures>(context, listen: false)
            .readLecureData('${widget.lecture.lectureNum}')
            .then((_) {
          setState(() {
            _isLoading = false;
          });
        }).catchError((error) {
          _showErrorAwesomeDialog(error.toString().split(':')[1]);
        });
      } catch (error) {
        _showErrorAwesomeDialog(error.toString());
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () async {
       return await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
       // Navigator.of(context).pop();
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            iconTheme: Theme.of(context).copyWith().iconTheme,
            centerTitle: true,
            backgroundColor: Theme.of(context).canvasColor,
            title: Text("تفاصيل المحاضرة", style: TextStyle(color: Colors.black38),)
          
        
          ),
          body: Consumer<Lectures>(
            builder: (ctx, lectureData, _) => _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(
                    alignment: Alignment.bottomRight,
                    children: <Widget>[
                      PhotoViewGallery.builder(
                        scrollDirection: Axis.vertical,
                        backgroundDecoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                        ),
                        scrollPhysics: const BouncingScrollPhysics(),
                        builder: (ctx, index) => PhotoViewGalleryPageOptions(
                          imageProvider:
                              MemoryImage(lectureData.lectureImages[index]),
                          initialScale: PhotoViewComputedScale.contained * 0.8,
                          minScale: PhotoViewComputedScale.contained * 0.5,
                          maxScale: PhotoViewComputedScale.covered * 1.1,
                        ),
                        itemCount: lectureData.lectureImages.length,
                        pageController:
                            PageController(initialPage: currentIndex!),
                        onPageChanged: onPageChanged,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 25, right: 25),
                        child: Text(
                            '${lectureData.lectureImages.length}/${currentIndex! + 1}'),
                      ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(bottom: 25, right: 25),
                  //       child: Image.asset('assets/images/aa.jpg',
                  // width: 150,
                  // height: 150,)
                      //)
                    ],
                  ),
            // NoonLooping(lectureData.lectureImages)
            //     ListView.builder(
            //   // scrollDirection: Axis.horizontal,
            //   itemCount: lectureData.lectureImages.length,
            //   itemBuilder: (ctx, index) => InkWell(
            //       child: SizedBox(
            //     height: MediaQuery.of(context).size.height * 0.5,
            //     width: double.infinity,
            //     child: _isLoading
            //         ? Center(
            //             child: CircularProgressIndicator(),
            //           )
            //         : PhotoView(
            //             backgroundDecoration: BoxDecoration(
            //               color: Theme.of(context).canvasColor,
            //             ),
            //             imageProvider:
            //                 MemoryImage(lectureData.lectureImages[index]),
            //           ),
            //   )),
            // ),
          )),
    );
  }
}
