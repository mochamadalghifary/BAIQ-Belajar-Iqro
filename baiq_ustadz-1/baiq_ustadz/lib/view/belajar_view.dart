import 'package:baiq_ustadz/view/belajar_halaman_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BelajarPage extends StatefulWidget {
  final int jilid;

  BelajarPage({Key key, this.jilid}) : super(key: key);

  @override
  BelajarPageState createState() => BelajarPageState();
}

class BelajarPageState extends State<BelajarPage> {
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
                itemCount: 31,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, crossAxisSpacing: 5, mainAxisSpacing: 5), itemBuilder: (BuildContext context, int index){
              return SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: RaisedButton(
                  child: Text((index+1).toString()),
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
    Fluttertoast.showToast(
        msg: "Jilid ${widget.jilid} halaman ${index+1}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Navigator.push(context, MaterialPageRoute(builder: (context) => BelajarHalamanPage(halaman: index, jilid: widget.jilid,)));
  }
}