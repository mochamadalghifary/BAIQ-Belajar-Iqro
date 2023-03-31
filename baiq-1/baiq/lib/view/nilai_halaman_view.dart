import 'package:baiq/model/nilai_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NilaiHalamanPage extends StatefulWidget{
  final int halaman;
  final Nilai nilai;

  const NilaiHalamanPage({Key key, this.halaman, this.nilai}) : super(key: key);

  NilaiHalamanPageState createState() => NilaiHalamanPageState();
}

class NilaiHalamanPageState extends State<NilaiHalamanPage> {

  String _status ="";
  String _penguji="";
  String _tanggalUji="";


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(widget.nilai.status){
      setState(() {
        _status = "LULUS";
      });
    } else {
      setState(() {
        _status = "GAGAL";
      });
    }

    if(widget.nilai.catatan == ""){
      return Scaffold(
        appBar: AppBar(
          title: Text("Nilai Halaman"),
        ),
        body: Center(
          child: Text("Bacaan Masih Proses Penilaian :) ", style: Theme.of(context).textTheme.title,),
        ),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            title: Text("Nilai Halaman "+widget.halaman.toString()),
          ),
          body: SingleChildScrollView(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Card(
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(
                                  child: Text("Tanggal Uji", textAlign: TextAlign.center,),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Text("penguji", textAlign: TextAlign.center,),
                                  flex: 2,
                                ),
                                Expanded(
                                  child: Text("Status", textAlign: TextAlign.center,),
                                  flex: 1,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(
                                  child: Text(_tanggalUji, textAlign: TextAlign.center,),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Text(widget.nilai.penguji_nama, textAlign: TextAlign.center,),
                                  flex: 2,
                                ),
                                Expanded(
                                  child: Text(_status, textAlign: TextAlign.center,),
                                  flex: 1,
                                ),
                              ],
                            ),
                          ],
                        )
                    ),
                  ),
                  Card(
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              width: double.infinity,
                              child: Text("catatan"),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Text(widget.nilai.catatan),
                            ),
                          ],
                        )
                    ),
                  ),
                ],
              )
          )
      );
    }
  }
}
