import 'package:baiq_ustadz/model/ujian_model.dart';
import 'package:baiq_ustadz/presenter/ujian_presenter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp/mvp.dart';
import 'ujian_halaman_view.dart';

class UjianPage extends StatefulWidget {
  var presenter = UjianPresenter();
  @override
  UjianPageState createState() => UjianPageState();
}

class UjianPageState extends MvpScreen<UjianPage, UjianModel> {

  @override
  void initializeViewModel() {
    viewModel = UjianModel();
    // TODO: implement initializeViewModel
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.presenter.bind(applyState, this);
    widget.presenter.initListUjian();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.presenter.unbind();
  }

  @override
  Widget build(BuildContext context) {
    widget.presenter.bind(applyState, this);
    print("> ujianLength : "+viewModel.listUjian.length.toString());
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Pilih Halaman"),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(viewModel.listUjian[index].santri_nama),
                  leading: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("Hal"),
                      Text(viewModel.listUjian[index].halaman.toString())
                    ],
                  ),
                  onTap: () {
                    onPressHalaman(index);
                  },
                );
              },
              itemCount: viewModel.listUjian.length,)
        )
    );
  }

  void onPressHalaman(int index) {
    print(">> halaman : "+index.toString());
    Navigator.push(context, MaterialPageRoute(builder: (context) => UjianHalamanPage(halaman: viewModel.listUjian[index].halaman, ujian: viewModel.listUjian[index],)));
  }
}