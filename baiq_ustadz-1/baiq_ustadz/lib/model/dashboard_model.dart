import 'package:baiq_ustadz/view/belajar_view.dart';
import 'package:baiq_ustadz/view/nilai_view.dart';
import 'package:baiq_ustadz/view/rekam_audio_view.dart';
import 'package:baiq_ustadz/view/ujian_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardModel {
  SharedPreferences prefs;
  FirebaseAuth auth = FirebaseAuth.instance;
  List<Icon> iconGrid = List<Icon>();
  List<Text> textGrid = List<Text>();
  List<dynamic> page = List<dynamic>();

  void initPrefs() async {
    this.prefs = await SharedPreferences.getInstance();
  }

  DashboardModel(){
    initPrefs();

    this.iconGrid.add(Icon(Icons.chrome_reader_mode));
    this.iconGrid.add(Icon(Icons.edit));
    this.iconGrid.add(Icon(Icons.add_location));
    this.iconGrid.add(Icon(Icons.add_location));

    this.textGrid.add(Text("Belajar Mandiri"));
    this.textGrid.add(Text("Uji Bacaaan"));
    this.textGrid.add(Text("Nilai"));
    this.textGrid.add(Text("Rekam Contoh Bacaan"));

    this.page.add(BelajarPage());
    this.page.add(UjianPage());
    this.page.add(NilaiPage());
    this.page.add(RekamAudioPage());
  }

}