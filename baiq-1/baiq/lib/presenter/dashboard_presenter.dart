import 'package:baiq/model/dashboard_model.dart';
import 'package:baiq/view/dashboard_view.dart';
import 'package:mvp/mvp.dart';

class DashboardPresenter extends MvpPresenter<DashboardModel, DashboardPageState>{
  @override
  void initializeViewModel() {
    viewModel = DashboardModel();
    // TODO: implement initializeViewModel
  }

  void logOutAuth(){
    viewModel.auth.signOut();
    viewModel.prefs.remove("uid");
    screen.viewlogOut();
    callback(viewModel);
  }
}