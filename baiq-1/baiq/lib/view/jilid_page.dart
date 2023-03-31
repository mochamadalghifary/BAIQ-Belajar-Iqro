
import 'package:baiq/view/belajar_view.dart';
import 'package:flutter/material.dart';

class JilidPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pilih Jilid Iqra'"),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: GridView.builder(
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, crossAxisSpacing: 5, mainAxisSpacing: 5), itemBuilder: (BuildContext context, int index){
              return SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: RaisedButton(
                  child: Text(index.toString()),
                  onPressed: (){
                    onPressHalaman(context, index);
                  },
                ),
              );
            })
        )
    );
  }

  void onPressHalaman(context,index) {
    print(">> halaman : "+index.toString());
    Navigator.push(context, MaterialPageRoute(builder: (context) => BelajarPage(jilid: index,)));
  }
}
