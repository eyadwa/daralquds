import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lectures/constant/app_config.dart';
import 'package:lectures/provider/auth.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override


  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final user = Provider.of<Auth>(context,listen: false);


    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child:  Consumer<Auth>(
          builder: (context, authProvider, _) =>
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.1,),
             UserInfo(height: height, width: width),
              SizedBox(height: height * 0.02,),
              Container(
                height: height* 0.5,
                margin: EdgeInsets.only(top: 8.0),
                child: FutureBuilder(
                  future: Future.wait([user.getUserInfo(authProvider.userNumber!,authProvider.password!)]),
                  builder:
                      (BuildContext ctx,
                      AsyncSnapshot snapshotData) {
                    if (snapshotData.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: const CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: user.userInformation
                              .length,
                          itemBuilder: (context, i) {
                            return Provider.value(
                                value: user.userInformation[i],
                                child: UserProfileSection(height: height, width: width)
                            );
                          });
                    }
                  },
                ),
              ),
            //   UserProfileSection(height: height, width: width),
            //   SizedBox(height: height * 0.02,),
            //   UserProfileSection(height: height, width: width),
            //   SizedBox(height: height * 0.02,),
            //   UserProfileSection(height: height, width: width),
            // ],
          ]),
        ),
      ),
    );
  }
}

class UserProfileSection extends StatelessWidget {
  const UserProfileSection({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.1,
      width: width * 0.8,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                offset: Offset(3,5),
                color: Colors.black.withOpacity(0.1)
            )
          ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(" : المحاضرات ",style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 22),),
          )
        ],
      ),
    );
  }
}





class UserInfo extends StatelessWidget {
  const UserInfo({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, authProvider, _) =>
       Container(
        height: height * 0.28,
        width: width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: Offset(3,5),
              color: Colors.black.withOpacity(0.1)
            )
          ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height * 0.05,),
            const CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/images/default_profile.jpg'),
              maxRadius: 50,
              minRadius: 50,
            ),
            SizedBox(height: height * 0.01,),
            Text(authProvider.userName!,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20),),
            SizedBox(height: height * 0.02,),
            Text(authProvider.userNumber!,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),)
          ],
        ),
      ),
    );
  }
}
