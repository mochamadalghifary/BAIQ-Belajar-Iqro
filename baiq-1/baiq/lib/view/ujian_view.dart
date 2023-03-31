import 'package:baiq/view/ujian_halaman_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UjianPage extends StatefulWidget {
  final int jilid;
  UjianPage({Key key, this.jilid}) : super(key: key);

  @override
  UjianPageState createState() => UjianPageState();
}

class UjianPageState extends State<UjianPage> {
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => UjianHalamanPage(jilid: widget.jilid,halaman: index)));
  }
}