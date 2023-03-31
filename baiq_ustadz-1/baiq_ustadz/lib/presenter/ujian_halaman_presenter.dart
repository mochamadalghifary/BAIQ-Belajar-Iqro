import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:baiq_ustadz/model/ujian_halaman_model.dart';
import 'package:baiq_ustadz/model/ujian_model.dart';
import 'package:baiq_ustadz/view/ujian_halaman_view.dart';
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

  void submitAudio(Ujian ujian, bool kelulusan) async {
    screen.backDashboard();
    print("audio submitted");
//    viewModel.storageRef =
//    FirebaseStorage.instance.ref().child("audio/"+viewModel.uid+"/hal"+(viewModel.halaman+1).toString()+".aac");
//    viewModel.uploadTask = viewModel.storageRef.putFile(File(viewModel.path));
//    final StorageTaskSnapshot downloadUrl =
//    (await viewModel.uploadTask.onComplete);
//    String url = (await downloadUrl.ref.getDownloadURL());
//    print('URL Is $url');

    Firestore.instance.collection("ujian").document(ujian.doc_id).updateData({
      'penguji_nama' : viewModel.pref.getString("nama"),
      'status' : kelulusan,
      'catatan' : viewModel.feedback.text,
    });

    viewModel.flutterSound.stopRecorder();
//    callback(viewModel);
    unbind();
  }

//  Future<void> recordPage(int halaman) async {
//    viewModel.submitRecord = true;
//    viewModel.path = await viewModel.flutterSound.startRecorder("android.aac");
//    viewModel.recorderSubscription = viewModel.flutterSound.onRecorderStateChanged.listen((e) {
//      if (e != null){
//        DateTime date = DateTime.fromMillisecondsSinceEpoch(e.currentPosition.toInt() ?? 0);
//        String txt = DateFormat('mm:ss:SS', 'en_US').format(date);
//        viewModel.timeRecord = txt;
//        callback(viewModel);
//      }
//    });
//    print(viewModel.path);
//    callback(viewModel);
//  }

  Future<void> playStreamAudio(ss) async {
    print("init Stream");
    Ujian temp = screen.widget.ujian;
    print(">>temp: "+temp.santri_uid);
    print(">>jiid: "+temp.jilid.toString());
    print(">>hal: "+temp.halaman.toString());
    String url = "audio/"+temp.santri_uid.toString()+"/jilid"+(temp.jilid).toString()+"/hal"+(temp.halaman).toString()+".aac";
    StorageReference sr = FirebaseStorage.instance.ref().child(url);
    String audioUrl = await sr.getDownloadURL();
    print(">> stream url : "+audioUrl);
    print(audioUrl);
    AudioPlayer audioPlayer = AudioPlayer();
    int result = await audioPlayer.play(audioUrl.toString());
    audioPlayer.onAudioPositionChanged.listen((Duration  p){
      print("success play audio");
      DateTime date = DateTime.fromMillisecondsSinceEpoch(p.inMilliseconds ?? 0);
      String txt = DateFormat('mm:ss:SS', 'en_US').format(date);
      viewModel.timeRecord = txt;
      callback(viewModel);
    });
    if (result == 1) {
      print("success");
    }
  }

  void setFeedback(String data) {
    viewModel.setFeedback(data);
    callback(viewModel);
  }
}