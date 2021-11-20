import 'package:bluestack_assignment/AppUtill.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../res.dart';

class AppNavigationDrawer extends StatelessWidget {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createDrawerHeader(),
          createDrawerBodyItem(icon: Icons.home, text: 'Home', onTap: () {}),
          createDrawerBodyItem(
              icon: Icons.logout,
              text: 'Log out',
              onTap: () {
                AppUtill.printAppLog("Log out ..");

                _prefs.then((SharedPreferences prefs) {
                  prefs.setBool(Keys.IS_LOGIN, false);
                  prefs.clear();
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed('/login');
                });
              }),
        ],
      ),
    );
  }

  Widget createDrawerHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(Res.logo_game_tv))),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text(
                "",
                style: TextStyle(
                    fontSize: AppDimension.size14,
                    color: AppColors.color_black_text,
                    fontWeight: AppFontWeight.MEDIUM),
              )),
        ]));
  }

  Widget createDrawerBodyItem(
      {IconData icon = Icons.home,
      String text = "",
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
