import 'package:baiq_ustadz/model/dashboard_model.dart';
import 'package:baiq_ustadz/presenter/dashboard_presenter.dart';
import 'package:baiq_ustadz/view/login_view.dart';
import 'package:baiq_ustadz/view/rekam_audio_view.dart';
import 'package:baiq_ustadz/view/ujian_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvp/mvp.dart';

import 'belajar_view.dart';
import 'nilai_view.dart';


class Dashboard extends StatefulWidget {
  var presenter = new DashboardPresenter();
  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends MvpScreen<Dashboard, DashboardModel> {

  @override
  void initializeViewModel() {
    viewModel = DashboardModel();
    // TODO: implement initializeViewModel
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.presenter.bind(applyState, this);
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
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard Menu"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.exit_to_app),
            label: Text("Logout"),
            onPressed: () {
              widget.presenter.logOutAuth();
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: GridView.count(crossAxisCount: 2,
              children: List.generate(viewModel.page.length, (index) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: RaisedButton(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  viewModel.iconGrid[index],
                                  viewModel.textGrid[index]
                                ],
                              ),
                            ),
                          onPressed: (){
//                              onClickMenu(index);
                          if(index == 1 || index == 2){
                            onClickMenu(0, index);
                          } else {
                            settingModalBottomSheet(context, index);
                          }

                          },
                        )
                    ),
                  )
                );
              })),
        )
      ),
    );
  }

  void onClickMenu(jilid, index) {
    print(">>Grid menu: "+index.toString());
    Fluttertoast.showToast(
        msg: "Iqra' Jilid "+jilid.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );
    switch(index){
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => BelajarPage(jilid: jilid,)));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => UjianPage()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => NilaiPage()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => RekamAudioPage(jilid: jilid,)));
        break;
    }

    void viewlogOut() async {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
    }
}

  void settingModalBottomSheet(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.filter_1),
                    title: new Text('Jilid 1'),
                    onTap: () {
                      Navigator.pop(context);
                      onClickMenu(1, index);
                    }
                ),
                new ListTile(
                    leading: new Icon(Icons.filter_2),
                    title: new Text('Jilid 2'),
                    onTap: () {
                      Navigator.pop(context);
                      onClickMenu(2, index);
                    }
                ),
                new ListTile(
                    leading: new Icon(Icons.filter_3),
                    title: new Text('Jilid 3'),
                    onTap: () {
                      Navigator.pop(context);
                      onClickMenu(3, index);
                    }
                ),
                new ListTile(
                    leading: new Icon(Icons.filter_4),
                    title: new Text('Jilid 4'),
                    onTap: () {
                      Navigator.pop(context);
                      onClickMenu(4, index);
                    }
                ),
                new ListTile(
                    leading: new Icon(Icons.filter_5),
                    title: new Text('Jilid 5'),
                    onTap: () {
                      Navigator.pop(context);
                      onClickMenu(5, index);
                    }
                ),
                new ListTile(
                    leading: new Icon(Icons.filter_6),
                    title: new Text('Jilid 6'),
                    onTap: () {
                      Navigator.pop(context);
                      onClickMenu(6, index);
                    }
                ),
              ],
            ),
          );
        }
    );
  }

  void viewlogOut() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
  }
}