import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return '아이디가 일치하지 않습니다.';
      }
      if (users[data.name] != data.password) {
        return '비밀번호가 일치하지 않습니다.';
      }
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return '등록된 이메일이 없습니다.';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
    
      theme: LoginTheme( 
        accentColor: Colors.white,
        textFieldStyle: TextStyle(color: Colors.white),
        beforeHeroFontSize: 50.0,
      ),
      title: 'JARAM',
      logo: 'assets/images/Jaram.png',
      onLogin: _authUser,
      onSignup: _authUser,
      onRecoverPassword: _recoverPassword,
    );
  }
}