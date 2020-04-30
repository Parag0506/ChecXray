import 'package:checxray/pages/screens/info_detail.dart';
import 'package:checxray/pages/widgets/theme_changer.dart';
import 'package:checxray/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_screen/responsive_screen.dart';

class InformationTitleCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final Color iconColor;
  final Image image;
  final int index;

  const InformationTitleCard({
    Key key,
    @required this.title,
    @required this.subTitle,
    this.icon,
    @required this.iconColor,
    this.image,
    @required this.index,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;
    ThemeChanger _themeChanger = Provider.of(context);
    final _currentTheme = _themeChanger.getTheme();
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => InfoDetails(
              index: index,
              icon: icon,
              title: title,
              subTitle: subTitle,
              iconColor: iconColor,
            ),
            maintainState: true,
          ),
        );
      },
      child: Container(
        height: hp(20),
        width: wp(100),
        padding: EdgeInsets.all(20),
        //margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: _currentTheme.cardColor,
          borderRadius: BorderRadius.circular(20),
          // boxShadow: [
          //   new BoxShadow(
          //       color: _currentTheme.cardColor,
          //       blurRadius: 4.0,
          //       spreadRadius: 3.5,
          //       offset: Offset(0.0, 2)),
          // ],
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Hero(
                        tag: index,
                        child: Icon(
                          icon,
                          size: 50,
                          color: iconColor,
                        ),
                      ),
                      SizedBox(width: wp(5)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(title,
                              style: AppTheme.h2Style.copyWith(
                                  color: _currentTheme.colorScheme.secondary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                          SizedBox(height: hp(1)),
                          Text(subTitle,
                              style: AppTheme.h2Style.copyWith(
                                  color: _currentTheme.colorScheme.secondary,
                                  fontSize: 16))
                        ],
                      )
                    ]),
              )
            ]),
      ),
    );
  }
}
