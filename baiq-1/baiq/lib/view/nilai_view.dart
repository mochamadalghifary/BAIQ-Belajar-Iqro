import 'package:baiq/model/nilai_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'nilai_halaman_view.dart';

class NilaiPage extends StatefulWidget {

  @override
  NilaiPageState createState() => NilaiPageState();
}

class NilaiPageState extends State<NilaiPage> {
  List<Nilai> listNilai = List<Nilai>();

  @override
  void initState() {
    initListNilai();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Pilih Halaman"),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: GridView.builder(
                itemCount: listNilai.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, crossAxisSpacing: 5, mainAxisSpacing: 5), itemBuilder: (BuildContext context, int index){
              return SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: RaisedButton(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(width: double.infinity,child: Text("Jilid: "+listNilai[index].jilid.toString(), textAlign: TextAlign.center,)),
                      SizedBox(height: 5,),
                      SizedBox(width: double.infinity,child: Text(listNilai[index].halaman.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 20),))
                    ],
                  ),
                  onPressed: (){
                    onPressHalaman(index);
                  },
                ),
              );
            })
        )
    );
  }

  void onPressHalaman(int index) {
    print(">> halaman : "+index.toString());
    Navigator.push(context, MaterialPageRoute(builder: (context) => NilaiHalamanPage(halaman: index, nilai: listNilai[index],)));
  }

  void initListNilai() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String uid = pref.getString("uid");
    Firestore.instance
        .collection('ujian')
        .where("santri_uid", isEqualTo: uid)
        .snapshots()
        .listen((data) =>
    data.documents.forEach((doc) { print(doc.data['doc_id']); setState(() {
      listNilai.add(Nilai.fromFirestore(doc.data));
    });}));
    print(">> Length Nilai: "+listNilai.length.toString());
  }
}