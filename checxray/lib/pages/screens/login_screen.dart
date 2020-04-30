import 'package:checxray/theme/color/light_color.dart';
import 'package:checxray/theme/theme.dart';
import 'package:checxray/utils/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    Key key,
    @required ThemeData currentTheme,
  })  : _currentTheme = currentTheme,
        super(key: key);

  final ThemeData _currentTheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: _currentTheme.colorScheme.background,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Welcome to Checxray',
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
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              textColor: _currentTheme.colorScheme.background,
              color: _currentTheme.colorScheme.secondary,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    FontAwesomeIcons.google,
                    size: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Sign in with Google',
                      style: GoogleFonts.cabin(
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              onPressed: authService.googleSignIn,
            ),
          ],
        ),
      ),
    );
  }
}
