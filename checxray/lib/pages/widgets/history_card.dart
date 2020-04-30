import 'package:checxray/pages/screens/history_detail.dart';
import 'package:checxray/pages/widgets/theme_changer.dart';
import 'package:checxray/theme/theme.dart';
import 'package:checxray/utils/margin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_screen/responsive_screen.dart';

class HistoryCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final Color iconColor;
  final Image image;
  final int index;

  const HistoryCard(
      {Key key,
      @required this.title,
      @required this.subTitle,
      this.icon,
      @required this.iconColor,
      this.image,
      @required this.index})
      : super(key: key);
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
            builder: (_) => HistoryDetails(
                index: '${index}_history', image: image, title: title),
            maintainState: true,
          ),
        );
      },
      child: Container(
        height: hp(20),
        width: wp(100),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _currentTheme.cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      icon != null
                          ? Icon(
                              icon,
                              size: 50,
                              color: iconColor,
                            )
                          : Hero(
                              tag: '${index}_history',
                              child: Container(
                                child: image,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: _currentTheme.colorScheme.secondary,
                                  ),
                                  borderRadius: BorderRadius.circular(2),
                                ),
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
                          YMargin(5),
                          Text(
                            subTitle,
                            style: AppTheme.h2Style.copyWith(
                                color: _currentTheme.colorScheme.secondary,
                                fontSize: 16),
                          ),
                        ],
                      )
                    ]),
              )
            ]),
      ),
    );
  }
}
