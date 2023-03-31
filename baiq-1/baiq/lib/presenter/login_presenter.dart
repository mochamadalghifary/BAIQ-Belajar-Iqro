import 'package:baiq/model/login_model.dart';
import 'package:baiq/view/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
//      this.screen.nextView();
    this.screen.loginEmail();
    } else {
      screen.showFailedDialog();
    }

    callback(viewModel);
  }



}