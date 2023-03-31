import 'package:baiq/model/belajar_halaman_model.dart';
import 'package:baiq/presenter/belajar_halaman_presenter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvp/mvp.dart';

class BelajarHalamanPage extends StatefulWidget{
  final int halaman,jilid;
  var presenter = BelajarHalamanPresenter();

  BelajarHalamanPage({Key key, this.halaman, this.jilid}) : super(key: key);

  @override
  BelajarHalamanPageState createState() => BelajarHalamanPageState();

}

class BelajarHalamanPageState extends MvpScreen<BelajarHalamanPage, BelajarHalamanModel> {
  String url = "";

  @override
  void initState() {
    getUrl();
//    switch(widget.jilid){
//      case 1:
//        url =  "https://firebasestorage.googleapis.com/v0/b/baiq-905e3.appspot.com/o/jilid${widget.jilid}%2F${widget.halaman}.png?alt=media&token=34b50d8d-db97-4314-a323-ae382b0e37e5";
//        break;
//      case 2:
//        url =  "https://firebasestorage.googleapis.com/v0/b/baiq-905e3.appspot.com/o/jilid${widget.jilid}%2F${widget.halaman}.PNG?alt=media&token=e9e5742e-56bd-4a18-930c-2de0b569ddb9";
//        break;
//      case 3:
//        url =  "https://firebasestorage.googleapis.com/v0/b/baiq-905e3.appspot.com/o/jilid${widget.jilid}%2F${widget.halaman}.png?alt=media&token=4841b867-2285-4bdc-984b-0bfee28f1cea";
//        break;
//      case 4:
//        url =  "https://firebasestorage.googleapis.com/v0/b/baiq-905e3.appspot.com/o/jilid${widget.jilid}%2F${widget.halaman}.png?alt=media&token=e56f2ec4-0429-4936-98c4-50481f33165c";
//        break;
//      case 5:
//        url =  "https://firebasestorage.googleapis.com/v0/b/baiq-905e3.appspot.com/o/jilid${widget.jilid}%2F${widget.halaman}.png?alt=media&token=41dbe60d-f8dd-4ab7-a3f0-29142295a0b1";
//        break;
//      case 6:
//        url =  "https://firebasestorage.googleapis.com/v0/b/baiq-905e3.appspot.com/o/jilid${widget.jilid}%2F${widget.halaman}.png?alt=media&token=aa44d290-4614-4b9b-a43f-7d0025e421b0";
//        break;
//    }
    viewModel.halaman = widget.halaman;
    viewModel.jilid = widget.jilid;

    // TODO: implement initState
    super.initState();

    Fluttertoast.showToast(
        msg: "Jilid ${widget.jilid} halaman ${widget.halaman+1}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );

    widget.presenter.bind(applyState, this);
    widget.presenter.setHalaman(widget.halaman);
    widget.presenter.initAudio();
    if (widget.halaman > 0){
      widget.presenter.setLeftOn();
    }
  }



  @override
  Widget build(BuildContext context) {
    widget.presenter.bind(applyState, this);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Iqra' Halaman "+(widget.halaman+1).toString()),
      ),
      body: Center(
          child: Stack(
            children: <Widget>[
              Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
//                child: Image.network("https://firebasestorage.googleapis.com/v0/b/baiq-905e3.appspot.com/o/jilid1%2F"+(widget.halaman+1).toString()+".jpg?alt=media&token=e17ecd56-7a06-42c2-beb0-6ce258e32a15"),
                    child:
                    CachedNetworkImage(
                      imageUrl: url,
                      placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                      errorWidget: (context, url, error) => Center(child: Icon(Icons.error),),
                    )
//                    Image.network(url),
                  )
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Visibility(
                        child: FloatingActionButton(
                          heroTag: "nextPage",
                          child: Icon(Icons.chevron_right),
                          onPressed: (){
                            goNextPage(widget.halaman+1);
                          },
                        ),
                        visible: viewModel.rightFab,
                      )
                  )
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Visibility(
                        child: FloatingActionButton(
                          heroTag: "previousPage",
                          child: Icon(Icons.chevron_left),
                          onPressed: (){
                            goPreviousPage((widget.halaman-1));
                          },
                        ),
                        visible: viewModel.leftFab,
                      )
                  )
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Visibility(
                        child: FloatingActionButton(
                          heroTag: "soundPlay",
                          child: Icon(Icons.play_circle_outline),
                          onPressed: (){
                            playIqra(widget.halaman-1);
                          },
                        ),
                        visible: viewModel.iqraFab,
                      )
                  )
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Visibility(
                        child: FloatingActionButton.extended(
                          heroTag: "playStream",
                          icon: Icon(Icons.stop),
                          label: Text("stop play"),
                          onPressed: (){
                            print("stop");
                            widget.presenter.setStreamAudioOff();
                            widget.presenter.setIqraOn();
                            widget.presenter.setLeftOn();
                            widget.presenter.setRightOn();
                          },
                        ),
                        visible: viewModel.streamAudioFab,
                      )
                  )
              ),
            ],
          )
      ),
    );
  }

  void goNextPage(int i) {
    print(">> Next Page: "+ i.toString());
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BelajarHalamanPage(halaman: i,jilid: widget.jilid,)));
  }

  void goPreviousPage(int i) {
    print(">> Previous Page: "+ i.toString());
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BelajarHalamanPage(halaman: i, jilid: widget.jilid)));
  }

  void playIqra(int i) {
    print(">> play Iqra'"+i.toString());
    _downloadAudio();
  }

  Future _downloadAudio() async {
    switch(
    await showDialog(
        context: context,
        builder: (context) {
          if(viewModel.listAudio.length<1){
            return AlertDialog(
                title: Text("Maaf Audio belum tersedia.."),
                content: FlatButton(
                  child: Text("Kembali"),
                  onPressed: (){Navigator.pop(context);},
                )
            );
          } else {
            return AlertDialog(
              title: Text("Pilih Audio, dari Ustadz"),
              content: Container(
                width: double.maxFinite,
                child: ListView.separated(
                    itemCount: viewModel.listAudio.length,
                    separatorBuilder: (BuildContext context, int index) => Divider(),
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(viewModel.listAudio[index].penguji_nama),
                        onTap: (){
                          onAudioChoosen(index);
                        },
                      );
                    }),
              ),
            );
          }
        }
    )
    ) {}
  }

  void onAudioChoosen(int index) {
    Fluttertoast.showToast(
        msg: "Menjalankan audio ${viewModel.listAudio[index].penguji_nama}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Navigator.pop(context);
    print(viewModel.listAudio[index].penguji_nama);
    widget.presenter.setLeftOff();
    widget.presenter.setRightoff();
    widget.presenter.setIqraoff();
    widget.presenter.setStreamAudioOn();
    widget.presenter.streamAudio(viewModel.listAudio[index].audio);
  }

  @override
  void initializeViewModel() {
    viewModel = BelajarHalamanModel();
    // TODO: implement initializeViewModel
  }

  @override
  void dispose() {
    widget.presenter.disposeAudio();
    // TODO: implement dispose
    super.dispose();
    widget.presenter.unbind();
  }

  void getUrl() async {
    StorageReference storageReference;
    if (widget.jilid == 2){
      storageReference = FirebaseStorage().ref().child("jilid${widget.jilid}/${widget.halaman+1}.PNG");
    } else {
      storageReference = FirebaseStorage().ref().child("jilid${widget.jilid}/${widget.halaman+1}.png");
    }
    String temp = await storageReference.getDownloadURL();
    print(">> link : "+temp);
    setState(() {
      url = temp;
    });

  }}

