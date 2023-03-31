import 'dart:io';
import 'package:baiq/model/ujian_halaman_model.dart';
import 'package:baiq/view/ujian_halaman_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:mvp/mvp.dart';

class UjianHalamanPresenter extends MvpPresenter<UjianHalamanModel, UjianHalamanPageState> {
  @override
  void initializeViewModel() {
    viewModel = UjianHalamanModel();
    // TODO: implement initializeViewModel
  }

  void doSubmit() async {
    viewModel.submitRecord = false;
    viewModel.playRecordedFab = true;
    print("done recording");
    print(await viewModel.flutterSound.stopRecorder());
    callback(viewModel);
  }

  Future playRecordedAudio() async {
    String path_play = await viewModel.flutterSound.startPlayer(viewModel.path);
    print('startPlayer: $path_play');
    await viewModel.flutterSound.setVolume(100.0);
    viewModel.playerSubscription = viewModel.flutterSound.onPlayerStateChanged.listen((e) {
      if (e != null) {
        DateTime date = new DateTime.fromMillisecondsSinceEpoch(e.currentPosition.toInt());
        String txt = DateFormat('mm:ss:SS', 'en_US').format(date);
        print(">> play recorded audio : "+txt.substring(0, 8));
        viewModel.timeRecord = txt.substring(0, 8);
      }
      callback(viewModel);
    });
  }

  void submitAudio() async {
    screen.backDashboard();
    print("audio submitted");
    viewModel.storageRef =
    FirebaseStorage.instance.ref().child("audio/"+viewModel.uid+"/jilid"+(viewModel.jilid).toString()+"/hal"+(viewModel.halaman+1).toString()+".aac");
    viewModel.uploadTask = viewModel.storageRef.putFile(File(viewModel.path));
    final StorageTaskSnapshot downloadUrl =
    (await viewModel.uploadTask.onComplete);
    String url = (await downloadUrl.ref.getDownloadURL());
    print('URL Is $url');


    String docId = Firestore.instance.collection("ujian").document().documentID;
    print(">> docId : "+docId);
    Firestore.instance.collection("ujian").document(docId).setData({
      'doc_id' : docId,
      'santri_uid' : viewModel.uid,
      'santri_nama' : viewModel.pref.getString("nama"),
      'penguji_nama' : "",
      'status' : false,
      'catatan' : "",
      'audio' : url,
      'halaman' : (viewModel.halaman+1),
      'jilid' : (viewModel.jilid),
    });


    viewModel.flutterSound.stopRecorder();
//    callback(viewModel);
    unbind();
  }

  Future<void> recordPage(int halaman) async {
    viewModel.recordFab = false;
    viewModel.submitRecord = true;
    viewModel.path = await viewModel.flutterSound.startRecorder("android.aac");
    viewModel.recorderSubscription = viewModel.flutterSound.onRecorderStateChanged.listen((e) {
      if (e != null){
        DateTime date = DateTime.fromMillisecondsSinceEpoch(e.currentPosition.toInt() ?? 0);
        String txt = DateFormat('mm:ss:SS', 'en_US').format(date);
        viewModel.timeRecord = txt;
        callback(viewModel);
      }
    });
    print(viewModel.path);
    callback(viewModel);
  }
}