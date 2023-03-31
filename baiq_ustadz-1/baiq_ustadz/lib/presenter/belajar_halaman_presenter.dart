import 'package:audioplayers/audioplayers.dart';
import 'package:baiq_ustadz/model/belajar_halaman_model.dart';
import 'package:baiq_ustadz/view/belajar_halaman_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvp/mvp.dart';

class BelajarHalamanPresenter extends MvpPresenter<BelajarHalamanModel, BelajarHalamanPageState> {
  @override
  void initializeViewModel() {
    viewModel = BelajarHalamanModel();
    // TODO: implement initializeViewModel
  }

  void setLeftOn(){
    viewModel.leftFab = true;
    callback(viewModel);
  }

  void setLeftOff(){
    viewModel.leftFab = false;
    callback(viewModel);
  }

  void setRightOn(){
    viewModel.rightFab = true;
    callback(viewModel);
  }

  void setRightoff(){
    viewModel.rightFab = false;
    callback(viewModel);
  }

  void setIqraoff(){
    viewModel.iqraFab = false;
    callback(viewModel);
  }

  void setIqraOn(){
    viewModel.iqraFab = true;
    callback(viewModel);
  }

  void setStreamAudioOn(){
    viewModel.streamAudioFab = true;
    callback(viewModel);
  }

  void setStreamAudioOff(){
    viewModel.streamAudioFab = false;
    callback(viewModel);
  }

  void initAudio() {
    print(">> halaman: "+viewModel.halaman.toString());
    Firestore.instance
        .collection('audio')
        .where("halaman", isEqualTo: viewModel.halaman)
        .snapshots()
        .listen((data) =>
        data.documents.forEach((doc) {
          print(doc.data['penguji_uid']);
          viewModel.listAudio.add(AudioSample.fromFirestore(doc.data));
          callback(viewModel);
        }));
    print(">> Length Nilai: "+viewModel.listAudio.length.toString());
  }

  void setHalaman(int halaman) {
    viewModel.halaman = halaman;
    callback(viewModel);
  }

  void streamAudio(String url) async {
    print(url);
    viewModel.audioPlayer = AudioPlayer();
    viewModel.audioPlayer.setVolume(100);
    viewModel.audioPlayer.setUrl(url);
    int result = await viewModel.audioPlayer.play(url);
    if (result == 1) {
      // success
      print(">> stream audio success");
    }
    setStreamAudioOff();
    callback(viewModel);
  }

  void disposeAudio() {
    viewModel.audioPlayer.stop();
    viewModel.audioPlayer.dispose();
    callback(viewModel);
  }
}