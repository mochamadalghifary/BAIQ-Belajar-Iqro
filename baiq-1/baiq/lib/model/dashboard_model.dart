import 'package:baiq/view/belajar_view.dart';
import 'package:baiq/view/jilid_page.dart';
import 'package:baiq/view/nilai_view.dart';
import 'package:baiq/view/ujian_view.dart';
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
    if(page.length<1){
      initPrefs();
      this.iconGrid.add(Icon(Icons.chrome_reader_mode));
      this.iconGrid.add(Icon(Icons.edit));
      this.iconGrid.add(Icon(Icons.assignment));

      this.textGrid.add(Text("Belajar Mandiri"));
      this.textGrid.add(Text("Ujian"));
      this.textGrid.add(Text("Nilai"));

      this.page.add(BelajarPage());
      this.page.add(UjianPage());
      this.page.add(NilaiPage());
    }
  }

}