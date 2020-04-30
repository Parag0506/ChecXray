import 'package:checxray/pages/widgets/theme_changer.dart';
import 'package:checxray/theme/theme.dart';
import 'package:checxray/utils/margin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List<String> content = [
  "People can catch COVID-19 from others who have the virus. The disease spreads primarily from person to person through small droplets from the nose or mouth, which are expelled when a person with COVID-19 coughs, sneezes, or speaks.\nThese droplets are relatively heavy, do not travel far and quickly sink to the ground. People can catch COVID-19 if they breathe in these droplets from a person infected with the virus. This is why it is important to stay at least 1 metre (3 feet) away from others.\nThese droplets can land on objects and surfaces around the person such as tables, doorknobs and handrails. People can become infected by touching these objects or surfaces, then touching their eyes, nose or mouth. This is why it is important to wash your hands regularly with soap and water or clean with alcohol-based hand rub.",
  "The most common symptoms of COVID-19 are fever, dry cough, and tiredness. Some patients may have aches and pains, nasal congestion, sore throat or diarrhea. These symptoms are usually mild and begin gradually. Some people become infected but only have very mild symptoms. \nMost people (about 80%) recover from the disease without needing hospital treatment. Around 1 out of every 5 people who gets COVID-19 becomes seriously ill and develops difficulty breathing. Older people, and those with underlying medical problems like high blood pressure, heart and lung problems, diabetes, or cancer , are at higher risk of developing serious illness. \nHowever anyone can catch COVID-19 and become seriously ill. Even people with very mild symptoms of COVID-19 can transmit the virus. People of all ages who experience fever, cough and difficulty breathing should seek medical attention.",
  "The most effective ways to protect yourself and others against COVID-19 are to:\n⦿ Clean your hands frequently and thoroughly\n⦿ Avoid touching your eyes, mouth and nose\n⦿ Cover your cough with the bend of elbow or tissue. If a tissue is used, discard it immediately and wash your hands.\n⦿ Maintain a distance of at least 1 metre (3 feet) from others. ",
  "If you have been in close contact with someone with COVID-19, you may be infected. \nClose contact means that you live with or have been in settings of less than 1 metre from those who have the disease. In these cases, it is best to stay at home. \nHowever, if you live in an area with malaria or dengue fever it is important that you do not ignore symptoms of fever. Seek medical help. When you attend the health facility wear a mask if possible, keep at least 1 metre distant from other people and do not touch surfaces with your hands. If it is a child who is sick help the child stick to this advice.",
];

class InfoDetails extends StatelessWidget {
  final int index;
  final IconData icon;
  final Color iconColor;
  final String title, subTitle;

  const InfoDetails({
    Key key,
    this.index,
    this.icon,
    this.iconColor,
    this.title,
    this.subTitle,
  }) : super(key: key);
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
          title,
          style: AppTheme.h1Style.copyWith(
              color: _currentTheme.colorScheme.secondary, fontSize: 20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          // width: double.infinity,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Hero(
                    tag: index,
                    child: Icon(
                      icon,
                      size: 50,
                      color: iconColor,
                    ),
                  ),
                  Text(
                    subTitle,
                    style: AppTheme.h2Style.copyWith(
                        color: _currentTheme.colorScheme.secondary,
                        fontSize: 18),
                  ),
                ],
              ),
              YMargin(20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  content[index],
                  textAlign: TextAlign.justify,
                  style: AppTheme.h2Style.copyWith(
                    height: 2,
                    color: _currentTheme.colorScheme.secondary,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "Source - WHO",
                  textAlign: TextAlign.justify,
                  style: AppTheme.h2Style.copyWith(
                    height: 1.5,
                    color: _currentTheme.colorScheme.secondary,
                    fontSize: 16,
                  ),
                ),
              ),
              YMargin(20),
            ],
          ),
        ),
      ),
    );
  }
}
