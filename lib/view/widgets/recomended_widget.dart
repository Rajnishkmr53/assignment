import 'package:bluestack_assignment/model/tournament_data.dart';
import 'package:flutter/material.dart';

import '../../res.dart';

class RecommendedWidget extends StatelessWidget {
  Tournament _tournament;
  RecommendedWidget(this._tournament);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        image: DecorationImage(
            fit: BoxFit.cover,
            image:  NetworkImage(_tournament.cover_url)),
        boxShadow: [
          BoxShadow(
            color: AppColors.color_grey_text,
            offset: const Offset(
              5.0,
              5.0,
            ),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ), //BoxShadow
          BoxShadow(
            color: Colors.white,
            offset: const Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ), //BoxShadow
        ],
      ),
child: Column(
  children: [
    Expanded(child: SizedBox(),flex: 2,),
    Expanded(child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
       color: AppColors.color_white,

      ),
padding: EdgeInsets.only(left: 20),
      child: Row(
        children: [
          Expanded(child: Column(
            children: [
              Text(
                "${_tournament.name}",
                maxLines: 1,
                style: TextStyle(
                    fontSize: AppDimension.size14,
                    color: AppColors.color_black_text,
                    fontWeight: AppFontWeight.BOLD),
              ),
              Text(
                "${_tournament.game_name}",
                maxLines: 1,
                style: TextStyle(
                    fontSize: AppDimension.size14,
                    color: AppColors.color_black_text,
                    fontWeight: AppFontWeight.LIGHT),
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
          )),
          IconButton(onPressed: (){

          }, icon: Icon(Icons.navigate_next))
        ],
      ),
    )),
  ],
),
    );
  }
}
