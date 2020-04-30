import 'package:checxray/pages/widgets/theme_changer.dart';
import 'package:checxray/theme/color/light_color.dart';
import 'package:checxray/theme/theme.dart';
import 'package:checxray/utils/auth.dart';
import 'package:checxray/utils/margin.dart';
import 'package:checxray/utils/user_image_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

bool darkMode = false;

class _SettingsPageState extends State<SettingsPage>
    with AutomaticKeepAliveClientMixin {
  dynamic _profile;
  @override
  void initState() {
    super.initState();
    authService.profile.then((value) => setState(() {
          _profile = value;
        }));
  }

  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: "gs://checxray.appspot.com/");

  final _database = FirebaseDatabase.instance.reference();
  void _clearHistory() {
    _database
        .child('users/' + _profile['uid'] + '/classifications')
        .set({}).then(
      (value) {
        user_images.forEach(
          (filePath) {
            _storage.ref().child(filePath).delete();
          },
        );
        user_images.clear();
      },
    ).then((_) => Navigator.of(context, rootNavigator: true).pop());
  }

  void clearHistory(context, _currentTheme) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        if (Theme.of(context).platform == TargetPlatform.iOS) {
          return CupertinoAlertDialog(
            title: Text('Clear History'),
            content: Text('Are you sure you want to clear your history?'),
            actions: [
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                color: _currentTheme.colorScheme.secondary,
                textColor: _currentTheme == AppTheme.darkTheme
                    ? _currentTheme.backgroundColor
                    : _currentTheme.primaryColorDark,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'YES',
                    style: GoogleFonts.cabin(
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                onPressed: _clearHistory,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                color: _currentTheme.colorScheme.secondary,
                textColor: _currentTheme == AppTheme.darkTheme
                    ? _currentTheme.backgroundColor
                    : _currentTheme.primaryColorDark,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'NO',
                    style: GoogleFonts.cabin(
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(),
              ),
            ],
          );
        } else {
          return AlertDialog(
            backgroundColor: _currentTheme.colorScheme.background,
            title: Text(
              'Clear History',
              style: TextStyle(
                color: _currentTheme.colorScheme.secondary,
              ),
            ),
            content: Text(
              'Are you sure you want to clear your history?',
              style: TextStyle(
                color: _currentTheme.colorScheme.secondary,
              ),
            ),
            actions: [
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                color: _currentTheme.colorScheme.secondary,
                textColor: _currentTheme == AppTheme.darkTheme
                    ? _currentTheme.backgroundColor
                    : _currentTheme.primaryColorDark,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'YES',
                    style: GoogleFonts.cabin(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                onPressed: _clearHistory,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                color: _currentTheme.colorScheme.secondary,
                textColor: _currentTheme == AppTheme.darkTheme
                    ? _currentTheme.backgroundColor
                    : _currentTheme.primaryColorDark,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'NO',
                    style: GoogleFonts.cabin(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(),
              ),
            ],
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    ThemeData _currentTheme = _themeChanger.getTheme();
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_profile != null) ...[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  width: 2,
                  color: _currentTheme.colorScheme.secondary,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  _profile["photoUrl"],
                ),
              ),
            ),
            YMargin(20),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              color: _currentTheme.colorScheme.secondary,
              textColor: _currentTheme == AppTheme.darkTheme
                  ? _currentTheme.backgroundColor
                  : _currentTheme.primaryColorDark,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Sign out',
                  style: GoogleFonts.cabin(
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              onPressed: authService.signOut,
            ),
            YMargin(10),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              color: Colors.orange,
              textColor: _currentTheme == AppTheme.darkTheme
                  ? _currentTheme.backgroundColor
                  : _currentTheme.primaryColorDark,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Clear History',
                  style: GoogleFonts.cabin(
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              onPressed: () => clearHistory(context, _currentTheme),
            ),
            YMargin(50)
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                LineIcons.sun_o,
                color: Colors.orange,
                size: 50,
              ),
              if (Theme.of(context).platform == TargetPlatform.iOS) ...[
                CupertinoSwitch(
                  activeColor: Colors.lightBlue,
                  value: darkMode,
                  onChanged: (value) {
                    setState(() {
                      darkMode = value;
                      if (darkMode) {
                        _themeChanger.setTheme(AppTheme.darkTheme);
                      } else {
                        _themeChanger.setTheme(AppTheme.lightTheme);
                      }
                    });
                  },
                ),
              ] else ...[
                Switch(
                  activeColor: LightColor.background,
                  activeTrackColor: LightColor.lightseeBlue,
                  value: darkMode,
                  onChanged: (value) {
                    setState(() {
                      darkMode = value;
                      if (darkMode) {
                        _themeChanger.setTheme(AppTheme.darkTheme);
                      } else {
                        _themeChanger.setTheme(AppTheme.lightTheme);
                      }
                    });
                  },
                ),
              ],
              Icon(
                LineIcons.moon_o,
                color: Colors.blue,
                size: 50,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
