import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:async';

import 'package:checxray/pages/widgets/theme_changer.dart';
import 'package:checxray/theme/theme.dart';
import 'package:checxray/utils/auth.dart';
import 'package:checxray/utils/user_image_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  File _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (_imageFile != null) ...[
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              height: MediaQuery.of(context).size.width * 0.75,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  _imageFile,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 150,
                height: 50,
                child: FlatButton.icon(
                  label: Text(
                    _imageFile == null ? "Upload" : "Change",
                    style: AppTheme.lightTheme.textTheme.button.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  color: AppTheme.lightTheme.colorScheme.primary,
                  textColor: AppTheme.lightTheme.colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    // side: BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: Icon(
                    LineIcons.upload,
                    color: AppTheme.lightTheme.colorScheme.onPrimary,
                  ),
                ),
              ),
              if (_imageFile != null) ...[
                Uploader(file: _imageFile),
              ],
            ],
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

bool completed = false;
bool predicting = false;
bool newImage = true;

class Uploader extends StatefulWidget {
  final File file;
  const Uploader({
    Key key,
    this.file,
  }) : super(key: key);

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: "gs://checxray.appspot.com/");

  final _database = FirebaseDatabase.instance.reference();
  dynamic _profile;

  final String endpoint = "http://checxray.pythonanywhere.com/predict";

  StorageUploadTask _uploadTask;

  String imagePath = "";

  @override
  void initState() {
    super.initState();
    authService.profile.then((value) => setState(() {
          _profile = value;
        }));
  }

  List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  Future<StreamedResponse> uploadFile(File file) async {
    var stream = new http.ByteStream(StreamView(file.openRead()));
    var multipartFile = new http.MultipartFile('img', stream, file.lengthSync(),
        filename: file.path.split('/').last);
    var request = new http.MultipartRequest(
        "POST", Uri.parse('http://checxray.pythonanywhere.com/predict'));
    request.files.add(multipartFile);
    return request.send();
  }

  void _setData() async {
    predicting = true;
    var now = DateTime.now();
    uploadFile(widget.file).then((s) {
      http.Response.fromStream(s).then((r) {
        var body = json.decode(r.body);
        if (body["success"]) {
          _database
              .child('users/' +
                  _profile['uid'] +
                  '/classifications/${Random().nextInt(10000)}')
              .update({
            'uploadTime': now.toString(),
            'imagePath': imagePath,
            'dateTime':
                "${days[now.weekday - 1]}, ${now.day}/${now.month}/${now.year}, ${now.hour}:${now.minute}",
            'prediction': body["prediction"],
            'confidence':
                (double.parse(body["confidence"]) * 100.0).round().toString() +
                    "%"
          });
          completed = true;
          setState(() {
            newImage = false;
          });
        }
      });
    });
  }

  void _startUpload() {
    String filePath = "images/${_profile["uid"]}/${DateTime.now()}";
    user_images.add(filePath);
    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
      newImage = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of(context);
    ThemeData _currentTheme = _themeChanger.getTheme();
    if (_uploadTask != null && newImage) {
      if (!predicting) {
        newImage = false;
        var storageTaskSnapshot = _uploadTask.onComplete;
        storageTaskSnapshot.then((value) {
          var ref = value.ref;
          ref.getDownloadURL().then((value) {
            imagePath = value.toString();
            _setData();
          });
        });
      }
      return Container(
        child: SpinKitThreeBounce(
          color: _currentTheme.colorScheme.secondary,
          size: 50.0,
        ),
      );
    } else {
      if (completed) {
        completed = false;
        predicting = false;
        return Container(
          child: Icon(
            LineIcons.check_circle_o,
            size: 50,
            color: _currentTheme.colorScheme.secondary,
          ),
        );
      } else if (predicting) {
        return Container(
          child: SpinKitThreeBounce(
            color: _currentTheme.colorScheme.secondary,
            size: 50.0,
          ),
        );
      }
      return Container(
        width: 150,
        height: 50,
        child: FlatButton.icon(
          label: Text(
            "Diagnose",
            style: AppTheme.lightTheme.textTheme.button.copyWith(
              color: _currentTheme.colorScheme.onSecondary,
              fontSize: 18,
            ),
          ),
          color: _currentTheme.colorScheme.secondary,
          textColor: _currentTheme.colorScheme.onSecondary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          onPressed: _startUpload,
          icon: Icon(
            LineIcons.hospital_o,
            color: _currentTheme.colorScheme.onSecondary,
          ),
        ),
      );
    }
  }
}
