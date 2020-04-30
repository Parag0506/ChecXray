import 'package:checxray/pages/widgets/history_card.dart';
import 'package:checxray/pages/widgets/theme_changer.dart';
import 'package:checxray/theme/theme.dart';
import 'package:checxray/utils/auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with AutomaticKeepAliveClientMixin {
  final _database = FirebaseDatabase.instance.reference();
  dynamic _profile;

  List<dynamic> l = List();

  Future<void> _buildCards() async {
    if (_profile != null) {
      _database
          .child('users/' + _profile['uid'] + '/classifications')
          .once()
          .then((snapshot) {
        if (snapshot.value != null) {
          l.clear();
          var m = Map<String, dynamic>.from(snapshot.value);
          m.forEach((key, value) => l.add(value));
          l.sort((a, b) => b["uploadTime"].compareTo(a["uploadTime"]));
        } else {
          l.clear();
        }
      });
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    authService.profile.then((value) => setState(() {
          _profile = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ThemeChanger _themeChanger = Provider.of(context);
    ThemeData _currentTheme = _themeChanger.getTheme();
    _buildCards();
    if (l.length == 0) {
      return RefreshIndicator(
        onRefresh: () => _buildCards(),
        child: ListView(
          addAutomaticKeepAlives: false,
          children: [
            Center(
              child: Text(
                "Pull to refresh",
                style: _currentTheme.textTheme.headline1.copyWith(
                  fontSize: 18,
                  color: _currentTheme.colorScheme.secondary,
                ),
              ),
            )
          ],
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: () => _buildCards(),
      child: ListView.builder(
        addAutomaticKeepAlives: false,
        itemCount: l.length,
        itemBuilder: (context, index) {
          var e = l[index];
          return _buildItem(e, index);
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget _buildItem(e, int index) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15, left: 20, right: 20),
      child: HistoryCard(
        index: index,
        title: "${e['prediction']} - ${e['confidence']}",
        subTitle: e["dateTime"],
        image: Image.network(
          e['imagePath'],
        ),
        // icon: LineIcons.hospital_o,
        iconColor: AppTheme.lightTheme.colorScheme.secondary,
      ),
    );
  }
}
