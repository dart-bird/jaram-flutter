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

  String pwValidator (String pw) {
    if(pw.length>=5 && pw.length<=10) {
      return null;
    } else return '비밀번호가 너무 짧습니다 (최소 5자리 이상 10자리 이하)';
  }
  
  String emailValidator (String email) {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    if (emailValid == false) {
      return '올바른 이메일 형식이 아닙니다';
    } else return null;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      passwordValidator: pwValidator,
      emailValidator: emailValidator,
      messages: LoginMessages(
        usernameHint: '이메일',
        passwordHint: '비밀번호',
        confirmPasswordHint: '비밀번호 확인',
        forgotPasswordButton: '비밀번호 찾기',
        loginButton: '로그인',
        signupButton: '회원가입',
        recoverPasswordButton: '전송',
        recoverPasswordIntro: '가입하신 이메일을 적어주세요',
        recoverPasswordDescription: '작성하신 이메일로 비밀번호가 전송됩니다!',
        goBackButton: '뒤로',
        confirmPasswordError: '비밀번호가 일치하지 않습니다',
        recoverPasswordSuccess: '비밀번호 전송성공'
      ),
      theme: LoginTheme(
        titleStyle: TextStyle(
          fontWeight: FontWeight.bold
        ),
        inputTheme: InputDecorationTheme(
          fillColor: Colors.black12,
          filled: true,
          labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
        ),
        buttonTheme: LoginButtonTheme(
          splashColor: Colors.white
        ),
        accentColor: Colors.white,
        beforeHeroFontSize: 50.0,
        bodyStyle: TextStyle(
          color: Colors.black
        ),
        cardTheme: CardTheme(
          color: Colors.white
        )
      ),
      title: 'JARAM',
      logo: 'assets/images/Jaram.png',
      onLogin: _authUser,
      onSignup: _authUser,
      onRecoverPassword: _recoverPassword,
    );
  }
}