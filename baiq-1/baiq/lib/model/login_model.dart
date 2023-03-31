import 'package:flutter/cupertino.dart';

class LoginModel {
  TextEditingController usernameInput ;
  TextEditingController passwordInput = new TextEditingController();

  LoginModel(){
    usernameInput = new TextEditingController();
    passwordInput = new TextEditingController();
  }

  bool isLogin(){
    if(isInputEmpty()){
      return false;
    } else {
      return true;
    }
  }

  bool isInputEmpty() {
    if(this.usernameInput.text == "" || this.passwordInput.text == "") {
      print(">>username: "+ this.usernameInput.text);
      print(">>password: "+ this.passwordInput.text);
      return true;
    } else {
      return false;
    }
  }

}