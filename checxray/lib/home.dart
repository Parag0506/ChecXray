import 'package:checxray/pages/screens/login_screen.dart';
import 'package:checxray/pages/widgets/theme_changer.dart';
import 'package:checxray/theme/theme.dart';
import 'package:checxray/utils/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import 'pages/screens/history_screen.dart';
import 'pages/screens/home_screen.dart';
import 'pages/screens/info_screen.dart';
import 'pages/screens/settings_screen.dart';
import 'theme/color/light_color.dart';
import 'utils/margin.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: false,
  );

  Widget buildPageView() {
    return PageView(
      pageSnapping: true,
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        HomePage(),
        HistoryPage(),
        InfoPage(),
        SettingsPage(),
      ],
    );
  }

  void pageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      selectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 400), curve: Curves.decelerate);
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    ThemeData _currentTheme = _themeChanger.getTheme();
    return StreamBuilder(
        stream: authService.user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: _themeChanger.getTheme().backgroundColor,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: <Widget>[
                        const YMargin(64),
                        Text(
                          'Checxray',
                          style: GoogleFonts.cabin(
                            textStyle: TextStyle(
                              fontSize: 27,
                              color: _currentTheme == AppTheme.darkTheme
                                  ? _currentTheme.primaryColorDark
                                  : LightColor.darkBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const YMargin(6),
                        Text(
                          'Automatic labelling of COVID-19 using chest radiographs',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cabin(
                            textStyle: TextStyle(
                              fontSize: 18,
                              color: _currentTheme == AppTheme.darkTheme
                                  ? _currentTheme.primaryColorDark
                                  : LightColor.darkBlue,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const YMargin(10),
                  Expanded(child: buildPageView()),
                ],
              ),
              bottomNavigationBar: Container(
                decoration:
                    BoxDecoration(color: _currentTheme.cardColor, boxShadow: [
                  BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
                ]),
                child: SafeArea(
                  child: Padding(
                    padding:
                        const EdgeInsets.all(10).add(EdgeInsets.only(top: 5)),
                    child: GNav(
                      gap: 10,
                      activeColor: Colors.white,
                      color: Colors.grey[400],
                      iconSize: 24,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      duration: Duration(milliseconds: 800),
                      tabBackgroundColor: Colors.grey[800],
                      tabs: [
                        GButton(
                          icon: LineIcons.home,
                          text: 'Home',
                          backgroundColor: _currentTheme.colorScheme.primary,
                        ),
                        GButton(
                          icon: LineIcons.history,
                          text: 'History',
                          iconActiveColor:
                              _currentTheme.colorScheme.onSecondary,
                          textColor: _currentTheme.colorScheme.onSecondary,
                          backgroundColor: _currentTheme.colorScheme.secondary,
                        ),
                        GButton(
                          icon: LineIcons.info_circle,
                          text: 'Info',
                          backgroundColor: CardColors.blue,
                        ),
                        GButton(
                          icon: LineIcons.cog,
                          text: 'Settings',
                          backgroundColor: Colors.deepPurpleAccent,
                        ),
                      ],
                      selectedIndex: selectedIndex,
                      onTabChange: (index) {
                        bottomTapped(index);
                      },
                    ),
                  ),
                ),
              ),
            );
          } else {
            return LoginScreen(currentTheme: _currentTheme);
          }
        });
  }
}
