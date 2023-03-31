
import 'package:baiq_ustadz/model/ujian_halaman_model.dart';
import 'package:baiq_ustadz/model/ujian_model.dart';
import 'package:baiq_ustadz/presenter/ujian_halaman_presenter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp/mvp.dart';


class UjianHalamanPage extends StatefulWidget{
  final int halaman;
  final Ujian ujian;
  var presenter = UjianHalamanPresenter();

  UjianHalamanPage({Key key, this.halaman, this.ujian}) : super(key: key);

  @override
  UjianHalamanPageState createState() => UjianHalamanPageState();

}

class UjianHalamanPageState extends MvpScreen<UjianHalamanPage, UjianHalamanModel> {
  bool _selectedKelulusan = true;
  String url = "";

  @override
  void initState() {
    getUrl();
    // TODO: implement initState
    super.initState();
    widget.presenter.bind(applyState, this);
    viewModel.halaman = widget.halaman;
    viewModel.jilid = widget.ujian.jilid;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                child: Image.network(url),
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
                          widget.presenter.playStreamAudio(widget.ujian.url);
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
                        heroTag: "nilaiFab",
                        icon: Icon(Icons.assignment_turned_in),
                        label: Text("nilai"),
                        onPressed: (){
//                          widget.presenter.submitAudio();
                        _showDialog();
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

  void getUrl() async {
    StorageReference storageReference;
    if (widget.ujian.jilid == 2){
      storageReference = FirebaseStorage().ref().child("jilid${widget.ujian.jilid}/${widget.halaman+1}.PNG");
    } else {
      storageReference = FirebaseStorage().ref().child("jilid${widget.ujian.jilid}/${widget.halaman+1}.png");
    }
    String temp = await storageReference.getDownloadURL();
    print(">> link : "+temp);
    setState(() {
      url = temp;
    });
  }

  void backDashboard(){
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  void initializeViewModel() {
    viewModel = UjianHalamanModel();
    // TODO: implement initializeViewModel
  }

  _showDialog() async {
    await showDialog<String>(
      context: context,
      child: AlertDialog(
        title: Text("Form Penilaian", textAlign: TextAlign.center,),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Text("Nama"),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(":"),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(widget.ujian.santri_nama),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Text("Halaman"),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(":"),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(widget.ujian.halaman.toString()),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: DropdownButton(
                  items: [
                    DropdownMenuItem(
                      value: true,
                      child: Text("lulus"),
                    ),
                    DropdownMenuItem(
                      value: false,
                      child: Text("gagal"),
                    ),
                  ],
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      _selectedKelulusan = value;
                    });
                  },
                  value: _selectedKelulusan,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Feedback",
                  hintText: "eg. bacaan kurang lancar"
                ),
                controller: viewModel.feedback,
              )
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("SUBMIT"),
            onPressed: (){
              print("submitted");
              widget.presenter.submitAudio(widget.ujian, _selectedKelulusan);
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text("CANCEL"),
            onPressed: (){
              print("cancelled");
              Navigator.pop(context);
            },
          ),
        ],
      )
    );
  }
}