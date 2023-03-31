import 'package:baiq_ustadz/model/nilai_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NilaiHalamanPage extends StatefulWidget{
  final int halaman;
  final Nilai nilai;

  const NilaiHalamanPage({Key key, this.halaman, this.nilai}) : super(key: key);

  NilaiHalamanPageState createState() => NilaiHalamanPageState();
}

class NilaiHalamanPageState extends State<NilaiHalamanPage> {
  String _tanggalUji="";

  String _statusKelulusan = "";
  @override
  void initState() {
    if(widget.nilai.status == true){
      _statusKelulusan = "LULUS";
    } else {
      _statusKelulusan = "GAGAL";
    }
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                          child: Text(widget.nilai.penguji_nama, textAlign: TextAlign.center,),
                          flex: 2,
                        ),
                        Expanded(
                          child: Text(_statusKelulusan, textAlign: TextAlign.center,),
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
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Text("santri"),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(":"),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(widget.nilai.santri_nama),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Text("halaman"),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(":"),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(widget.nilai.halaman.toString()),
                          ),
                        ],
                      ),
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
        ),
      )
    );
  }
}
