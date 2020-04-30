import 'package:checxray/pages/widgets/information_title_card.dart';
import 'package:checxray/pages/widgets/theme_changer.dart';
import 'package:checxray/theme/color/light_color.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:responsive_screen/responsive_screen.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    ThemeData _currentTheme = _themeChanger.getTheme();
    super.build(context);
    // final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;
    return Scaffold(
      backgroundColor: _currentTheme.backgroundColor,
      body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: <Widget>[
              InformationTitleCard(
                index: 0,
                icon: LineIcons.share_alt,
                iconColor: CardColors.blue,
                subTitle: 'Learn how COVID-19 spreads',
                title: 'How it Spreads?',
              ),
              SizedBox(height: hp(3)),
              InformationTitleCard(
                index: 1,
                icon: LineIcons.warning,
                iconColor: CardColors.cyan,
                subTitle: 'Learn COVID-19 symptoms',
                title: 'Symptoms',
              ),
              SizedBox(height: hp(3)),
              InformationTitleCard(
                index: 2,
                icon: LineIcons.heartbeat,
                iconColor: CardColors.red,
                subTitle: 'Learn COVID-19 treatments',
                title: 'Prevention & treatment',
              ),
              SizedBox(height: hp(3)),
              InformationTitleCard(
                index: 3,
                icon: LineIcons.question_circle,
                iconColor: CardColors.green,
                subTitle: 'What to do if you get the virus',
                title: 'What to do',
              ),
            ],
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
