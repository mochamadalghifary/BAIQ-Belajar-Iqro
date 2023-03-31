import 'package:baiq/model/dashboard_model.dart';
import 'package:baiq/presenter/dashboard_presenter.dart';
import 'package:baiq/view/belajar_view.dart';
import 'package:baiq/view/login_view.dart';
import 'package:baiq/view/nilai_view.dart';
import 'package:baiq/view/ujian_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvp/mvp.dart';


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
                  key: Key("gricColumn"+index.toString()),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: SizedBox(
                        key: Key("sizedBox"+index.toString()),
                        width: double.infinity,
                        height: double.infinity,
                        child: RaisedButton(
                          key: Key("RaisedButton"+index.toString()),
                            child: Center(
                              key: Key("keyCenter1 "+index.toString()),
                              child: Column(
                                key: Key("keyColumn1 "+index.toString()),
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
                          if (index==2){
                            onClickMenu(0, index);
                            return;
                          }
                          _settingModalBottomSheet(context, index);
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => UjianPage(jilid: jilid,)));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => NilaiPage()));
        break;

    }
//    Navigator.push(context, MaterialPageRoute(builder: (context) => viewModel.page[index]));

  }

  void viewlogOut() async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
  }

  void _settingModalBottomSheet(context, index){
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

}