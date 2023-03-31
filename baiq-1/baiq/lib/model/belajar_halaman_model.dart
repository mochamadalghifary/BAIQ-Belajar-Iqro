import 'package:audioplayers/audioplayers.dart';

class BelajarHalamanModel {
  int halaman = 0;
  int jilid = 1;
  bool leftFab = false;
  bool rightFab = true;
  bool iqraFab = true;
  bool streamAudioFab = false;
  AudioPlayer audioPlayer;
  List<AudioSample> listAudio = List<AudioSample>();

  BelajarHalamanModel(){
  }

}

class AudioSample {
  String audio, penguji_nama, penguji_uid;
  String doc_id;
  int halaman;
  int jilid;

  AudioSample({
    this.doc_id,
    this.audio,
    this.penguji_nama,
    this.penguji_uid,
    this.halaman,
    this.jilid
  });

  factory AudioSample.fromFirestore(Map<String, dynamic> data){
    return AudioSample(
        halaman: data['halaman'],
        jilid: data['jilid'],
        penguji_nama: data['penguji_nama'],
        penguji_uid: data['penguji_uid'],
        audio: data['audio'],
        doc_id: data['doc_id']
    );
  }
}