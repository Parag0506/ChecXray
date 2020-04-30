import 'package:checxray/pages/widgets/theme_changer.dart';
import 'package:checxray/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryDetails extends StatefulWidget {
  final Image image;
  final String index;
  final String title;
  const HistoryDetails({Key key, @required this.image, this.index, this.title})
      : super(key: key);
  @override
  _HistoryDetailsState createState() => _HistoryDetailsState();
}

class _HistoryDetailsState extends State<HistoryDetails> {
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of(context);
    ThemeData _currentTheme = _themeChanger.getTheme();
    return Scaffold(
      backgroundColor: _currentTheme.backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: _currentTheme.colorScheme.secondary),
        centerTitle: true,
        title: Text(
          widget.title,
          style: AppTheme.h1Style.copyWith(
              color: _currentTheme.colorScheme.secondary, fontSize: 20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: widget.index,
              child: ClipRRect(
                child: widget.image,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
