import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UjianHalamanModel {
  int halaman = 0;
  int jilid = 1;
  FlutterSound flutterSound = new FlutterSound();
  String path = "";
  String timeRecord = "";
  String uid = "";
  bool submitRecord = false;
  bool recordFab = true;
  bool playRecordedFab = false;
  StreamSubscription recorderSubscription;
  StreamSubscription playerSubscription;

  SharedPreferences pref;
  StorageReference storageRef ;
  StorageUploadTask uploadTask;
  StorageTaskSnapshot downloadUrl;



  void init() async {
    pref = await SharedPreferences.getInstance();
    uid = pref.getString('uid');
//    uploadTask = storageRef.putFile(File(path));
//    downloadUrl = (await uploadTask.onComplete);
  }

  UjianHalamanModel() {
    init();
  }
}