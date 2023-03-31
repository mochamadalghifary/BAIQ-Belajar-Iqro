

import 'package:baiq/model/ujian_halaman_model.dart';
import 'package:baiq/presenter/ujian_halaman_presenter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvp/mvp.dart';


class UjianHalamanPage extends StatefulWidget{
  final int halaman, jilid;
  var presenter = UjianHalamanPresenter();

  UjianHalamanPage({Key key, this.halaman, this.jilid}) : super(key: key);

  @override
  UjianHalamanPageState createState() => UjianHalamanPageState();

}

class UjianHalamanPageState extends MvpScreen<UjianHalamanPage, UjianHalamanModel> {
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
    widget.presenter.bind(applyState, this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      viewModel.halaman = widget.halaman;
      viewModel.jilid = widget.jilid;

//      Fluttertoast.showToast(
//          msg: "Jilid ${widget.jilid} halaman ${widget.halaman}",
//          toastLength: Toast.LENGTH_SHORT,
//          gravity: ToastGravity.CENTER,
//          timeInSecForIos: 1,
//          backgroundColor: Colors.greenAccent,
//          textColor: Colors.white,
//          fontSize: 16.0
//      );

    });
    widget.presenter.bind(applyState, this);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Iqra' Halaman "+widget.halaman.toString()),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                child:
                CachedNetworkImage(
                  imageUrl: url,
                  placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                  errorWidget: (context, url, error) => Center(child: Icon(Icons.error),),
                )
                )
              ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Visibility(
                  child: FloatingActionButton.extended(
                    heroTag: "nextPage",
                    icon: Icon(Icons.mic),
                    label: Text("Record"),
                    onPressed: (){
                      Fluttertoast.showToast(
                          msg: "Rekam bacaan dimulai",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIos: 1,
                          backgroundColor: Colors.greenAccent,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                      widget.presenter.recordPage(widget.halaman);
                    },
                  ),
                  visible: viewModel.recordFab,
                )
              )
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Visibility(
                  child: FloatingActionButton.extended(
                    heroTag: "previousPage",
                    icon: Icon(Icons.fiber_smart_record),
                    label: Text(viewModel.timeRecord.toString()),
                    onPressed: (){
                    widget.presenter.doSubmit();
                    },
                  ),
                  visible: viewModel.submitRecord,
                )
              )
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Visibility(
                      child: FloatingActionButton.extended(
                        heroTag: "soundPlay",
                        icon: Icon(Icons.play_circle_outline),
                        label: Text(viewModel.timeRecord),
                        onPressed: (){
                          Fluttertoast.showToast(
                              msg: "Menjalankan rekaman",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIos: 1,
                              backgroundColor: Colors.greenAccent,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                          widget.presenter.playRecordedAudio();
                        },
                      ),
                      visible: viewModel.playRecordedFab,
                    )
                )
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Visibility(
                      child: FloatingActionButton.extended(
                        heroTag: "submitFab",
                        icon: Icon(Icons.done),
                        label: Text("Kumpulkan"),
                        onPressed: (){
                          Fluttertoast.showToast(
                              msg: "Audio berhasil dikirim",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIos: 1,
                              backgroundColor: Colors.greenAccent,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                          widget.presenter.submitAudio();
                        },
                      ),
                      visible: viewModel.playRecordedFab,
                    )
                )
            ),
          ],
        ) 
      ),
    );
  }

//  void goNextPage(int i) {
//    print(">> Next Page: "+ i.toString());
//    Navigator.push(context, MaterialPageRoute(builder: (context) => UjianHalamanPage(halaman: widget.halaman+1,)));
//  }
//
//  void goPreviousPage(int i) {
//    if (!(i<0)){
//      print(">> Previous Page: "+ i.toString());
//      Navigator.pop(context);
//    }
//    print("Failed go Previous Page, below 0");
//  }
//
//  void playIqra(int i) {
//    print(">> play Iqra'"+i.toString());
//    _downloadAudio();
//  }

//  Future _downloadAudio() async {
//    switch(
//      await showDialog(
//          context: context,
//          builder: (context) {
//            return AlertDialog(
//              title: Text("Pilih Audio"),
//              content: Container(
//                width: double.maxFinite,
//                  child: ListView.separated(
//                itemCount: _listAudio.length,
//                  separatorBuilder: (BuildContext context, int index) => Divider(),
//                  itemBuilder: (BuildContext context, int index) {
//                    return RaisedButton(
//                      child: Text(_listAudio[index]),
//                      onPressed: (){
////                        return index;
////                      Navigator.pop(context, index);
//                      onAudioChoosen(index);
//                      },
//                    );
//              }),
//              ),
//            );
//          }
//      )
//    ) {}
//  }
//
//  void onAudioChoosen(int index) {
//    Navigator.pop(context);
//    print(index);
//    setState(() {
//      _leftFab = false;
//      _rightFab = false;
//      _iqraFab = false;
//    });
//  }

//  Future<void> recordPage(int halaman) async {
//    setState(() {
//      _recordFab = false;
//      _submitRecord = true;
//    });
//
//    String result = await flutterSound.startRecorder("android.aac");
//    setState(() {
//      this._path = result;
//    });
//    _recorderSubscription = flutterSound.onRecorderStateChanged.listen((e) {
//      if (e != null){
//        DateTime date = DateTime.fromMillisecondsSinceEpoch(e.currentPosition.toInt() ?? 0);
//        String txt = DateFormat('mm:ss:SS', 'en_US').format(date);
//        setState(() {
//          _timeRecord = txt;
//        });
//      }
//    });
//    print(result);
//  }

//  Future<void> doSubmit() async {
//    setState(() {
//      _submitRecord = false;
//      _playRecordedFab = true;
//    });
//    print(">> going to submit");
//    String result = await flutterSound.stopRecorder();
//    print(">> done record: "+result);
//  }

//  Future playRecordedAudio() async {
//    String path = await flutterSound.startPlayer(_path);
//    print('startPlayer: $path');
//    await flutterSound.setVolume(100.0);
//    _playerSubscription = flutterSound.onPlayerStateChanged.listen((e) {
//      if (e != null) {
//        DateTime date = new DateTime.fromMillisecondsSinceEpoch(e.currentPosition.toInt());
//        String txt = DateFormat('mm:ss:SS', 'en_US').format(date);
//        print(">> play recorded audio : "+txt.substring(0, 8));
//        this.setState(() {
//          _timeRecord = txt.substring(0, 8);
//        });
//      }
//    });
//  }

//  void submitAudio() {
//    print("audio submitted");
//    sendAudio();
//    Navigator.pop(context);
//    Navigator.pop(context);
//  }

  void backDashboard(){
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  void initializeViewModel() {
    viewModel = UjianHalamanModel();
    // TODO: implement initializeViewModel
  }

//  void sendAudio() async {
//    SharedPreferences pref = await SharedPreferences.getInstance();
//    String uid = pref.getString("uid");
//    final StorageReference storageRef =
//    FirebaseStorage.instance.ref().child("audio/$uid/hal"+(widget.halaman+1).toString()+".aac");
//    StorageUploadTask uploadTask = storageRef.putFile(File(_path));
//    final StorageTaskSnapshot downloadUrl =
//    (await uploadTask.onComplete);
//    final String url = (await downloadUrl.ref.getDownloadURL());
//    print('URL Is $url');
//
//    Firestore.instance.collection("ujian").document().setData({
//      'santri_uid' : uid,
//      'santri_nama' : pref.getString("nama"),
//      'penguji_nama' : "",
//      'status' : false,
//      'catatan' : "",
//      'audio' : url,
//      'halaman' : (widget.halaman+1)
//    });
//  }

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