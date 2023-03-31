import 'package:baiq_ustadz/model/rekam_audio_halaman_model.dart';
import 'package:baiq_ustadz/presenter/rekam_audio_halaman_presenter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp/mvp.dart';


class RekamAudioHalaman extends StatefulWidget{
  final int halaman, jilid;
  var presenter = RekamAudioHalamanPresenter();

  RekamAudioHalaman({Key key, this.halaman, this.jilid}) : super(key: key);


  @override
  RekamAudioHalamanState createState() => RekamAudioHalamanState();

}

class RekamAudioHalamanState extends MvpScreen<RekamAudioHalaman, RekamAudioHalamanModel> {
  String url = "";


  @override
  void initState() {
    getUrl();
    viewModel.halaman = widget.halaman;
    viewModel.jilid = widget.jilid;
    // TODO: implement initState
    viewModel.halaman = widget.halaman;
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
    });
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
                    child: Image.network(url),
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
                            widget.presenter.recordPage(widget.halaman+1);
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

  void backDashboard(){
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  void initializeViewModel() {
    viewModel = RekamAudioHalamanModel();
    // TODO: implement initializeViewModel
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
  }

}