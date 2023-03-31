import 'package:baiq_ustadz/model/login_model.dart';
import 'package:baiq_ustadz/view/login_view.dart';
import 'package:mvp/mvp.dart';

class LoginPresenter extends MvpPresenter<LoginModel, LoginPageState>{

  @override
  void initializeViewModel() {
    viewModel = LoginModel();
    // TODO: implement initializeViewModel
  }

  void doLogin(String username, String password) {
    this.viewModel.usernameInput.text = username;
    this.viewModel.passwordInput.text = password;
    bool status = viewModel.isLogin();
    print(">> login Status: "+status.toString());
    if(status){
      this.screen.nextView();
    } else {
      screen.showFailedDialog();
    }

    callback(viewModel);
  }



}