import 'dart:io';

import 'package:bluestack_assignment/AppUtill.dart';
import 'package:bluestack_assignment/block/home_block.dart';
import 'package:bluestack_assignment/data/datbase_provider.dart';
import 'package:bluestack_assignment/model/user_modal.dart';
import 'package:bluestack_assignment/res.dart';
import 'package:bluestack_assignment/view/widgets/app_navigation_drawer.dart';
import 'package:bluestack_assignment/view/widgets/recomended_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class HomeView extends StatefulWidget {
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Size _size;
  bool isLoading = false;
  HomeBlock _homeBlock = HomeBlock();

  @override
  void initState() {
    _loadMore();
    _homeBlock.loadmoreStream.listen((event) {
      setState(() {
        isLoading = event;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _homeBlock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return WillPopScope(
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.color_grey_bg,
              elevation: 0,
              title: Align(
                alignment: Alignment.center,
                child: Text(
                  "Flyingwolf",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: AppDimension.size14,
                      color: AppColors.color_black_text,
                      fontWeight: AppFontWeight.BOLD),
                ),
              ),
            ),
            drawer: AppNavigationDrawer(),
            backgroundColor: AppColors.color_grey_bg,
            body: LazyLoadScrollView(
              isLoading: isLoading,
              onEndOfPage: () => _loadMore(),
              child: ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      StreamBuilder(
                          stream: _homeBlock.userStream,
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            return snapshot.data!=null?getUserWidget(snapshot.data):Container(
                              width: 40,
                              height: 40,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }),

                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Recommended for you",
                            style: TextStyle(
                                fontSize: AppDimension.size16,
                                color: AppColors.color_black_text,
                                fontWeight: AppFontWeight.BOLD),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      StreamBuilder(
                          stream: _homeBlock.recommendedStream,
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            return snapshot.data != null
                                ? ListView.builder(
                                itemCount: snapshot.data.length,
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 10,
                                        bottom: 10),
                                    child:
                                    RecommendedWidget(snapshot.data[index]),
                                  );
                                })
                                : SizedBox();
                          }),
                      Container(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        onWillPop: () {
          Navigator.pop(context);
          exit(0);
        });
  }

  getUserWidget(User user) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              ClipOval(
                child: Image.asset(
                  user.profile_pic,
                  fit: BoxFit.cover,
                  width: 80,
                  height: 80,
                ),
                clipper: MyClip(),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${user.name}",
                    style: TextStyle(
                        fontSize: AppDimension.size16,
                        color: AppColors.color_black_text,
                        fontWeight: AppFontWeight.BOLD),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      alignment: Alignment.center,
                      padding:
                      EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: AppColors.color_white,
                        border: Border.all(
                          color: AppColors.color_light_blue_border,
                          width: 1,
                        ),
                      ),
                      child: RichText(
                        text: TextSpan(
                          text: "${user.rating}",
                          style: TextStyle(
                              fontSize: AppDimension.size16,
                              color: AppColors.color_light_blue_border,
                              fontWeight: AppFontWeight.MEDIUM),
                          children: <TextSpan>[
                            TextSpan(
                              text: "  Elo Rating",
                              style: TextStyle(
                                  fontSize: AppDimension.size14,
                                  color: AppColors.blue_dark,
                                  fontWeight: AppFontWeight.REGULAR),
                            ),
                          ],
                        ),
                      ))
                ],
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          getTurnamentSummary(user),
        ],
      )


    );
  }

  getTurnamentSummary(User user) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: AppColors.color_white,
        border: Border.all(
          color: AppColors.color_white,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                gradient: new LinearGradient(
                    colors: [
                      AppColors.primary_color,
                      AppColors.primary_color_light,
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                border: Border.all(
                  color: AppColors.color_white,
                  width: 1,
                ),
              ),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "${user.tournament_played}",
                  style: TextStyle(
                      fontSize: AppDimension.size16,
                      color: AppColors.color_white,
                      fontWeight: AppFontWeight.MEDIUM),
                  children: <TextSpan>[
                    TextSpan(
                      text: "\nTournaments\nplayed",
                      style: TextStyle(
                          fontSize: AppDimension.size14,
                          color: AppColors.color_white,
                          fontWeight: AppFontWeight.REGULAR),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                      AppColors.purple_dark,
                      AppColors.purple_light,
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                border: Border.all(
                  color: AppColors.color_white,
                  width: 1,
                ),
              ),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "${user.tournament_won}",
                  style: TextStyle(
                      fontSize: AppDimension.size16,
                      color: AppColors.color_white,
                      fontWeight: AppFontWeight.MEDIUM),
                  children: <TextSpan>[
                    TextSpan(
                      text: "\nTournaments\nwon",
                      style: TextStyle(
                          fontSize: AppDimension.size14,
                          color: AppColors.color_white,
                          fontWeight: AppFontWeight.REGULAR),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    topRight: Radius.circular(30)),
                gradient: new LinearGradient(
                    colors: [
                      AppColors.color_red,
                      AppColors.color_red_light,
                    ],
                    begin: const FractionalOffset(1.0, 0.0),
                    end: const FractionalOffset(0.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                border: Border.all(
                  color: AppColors.color_white,
                  width: 1,
                ),
              ),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "${AppUtill.toInteger((user.tournament_won*100)/user.tournament_played)}%",
                  style: TextStyle(
                      fontSize: AppDimension.size16,
                      color: AppColors.color_white,
                      fontWeight: AppFontWeight.MEDIUM),
                  children: <TextSpan>[
                    TextSpan(
                      text: "\nWinning\npercentage",
                      style: TextStyle(
                          fontSize: AppDimension.size14,
                          color: AppColors.color_white,
                          fontWeight: AppFontWeight.REGULAR),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  _loadMore() {
    AppUtill.printAppLog("Load more....${isLoading}");
    _homeBlock.loadRecommendedSink.add(Event.LOAD);

  }
}

class MyClip extends CustomClipper<Rect> {
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, 80, 80);
  }

  bool shouldReclip(oldClipper) {
    return false;
  }
}
