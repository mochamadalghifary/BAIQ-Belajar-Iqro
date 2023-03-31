import 'package:baiq_ustadz/model/ujian_model.dart';
import 'package:baiq_ustadz/view/ujian_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvp/mvp.dart';

class UjianPresenter extends MvpPresenter<UjianModel, UjianPageState> {
  @override
  void initializeViewModel() {
    viewModel = UjianModel();
    // TODO: implement initializeViewModel
  }

  void initListUjian() {
    Firestore.instance
        .collection('ujian')
        .where("penguji_nama", isEqualTo: "")
        .snapshots()
        .listen((data) =>
        data.documents.forEach((doc) {
          print(doc.data['santri_uid']);
          viewModel.listUjian.add(Ujian.fromFirestore(doc.data));
          callback(viewModel);
        }));
    callback(viewModel);
  }
}