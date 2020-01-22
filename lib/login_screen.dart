import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'constants.dart';
import 'custom_route.dart';
import 'dashboard_screen.dart';
import 'users.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/auth';

  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  Future<String> _loginUser(LoginData data) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(data.name)) {
        return '이메일이 존지하지 않습니다';
      }
      if (mockUsers[data.name] != data.password) {
        return '비밀번호가 일치하지 않습니다.';
      }
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(name)) {
        return '이메일이 존지하지 않습니다';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );

    return FlutterLogin(
      title: Constants.appName,
      logo: 'assets/images/Jaram.png',
      logoTag: Constants.logoTag,
      titleTag: Constants.titleTag,
      messages: LoginMessages(
        usernameHint: '이메일',
        passwordHint: '비밀번호',
        confirmPasswordHint: '비밀번호 확인',
        loginButton: '로그인',
        signupButton: '회원가입',
        forgotPasswordButton: '비밀번호를 까먹으셨다구?',
        recoverPasswordButton: '비밀번호를 알려줭!',
        goBackButton: '뒤로 가기',
        confirmPasswordError: '비밀번호가 일치하지 않습니다',
        recoverPasswordIntro: '비밀번호를 잃어버렸엉?',
        recoverPasswordDescription: '가입한 이메일을 적어주시면 비밀번호 보내드릴께 ^^77',
        recoverPasswordSuccess: '비밀번호 전송 완료!',
      ),
      theme: LoginTheme(
        
        primaryColor: Colors.black,
        accentColor: Colors.black,
        errorColor: Colors.black,
        pageColorLight: Colors.black,
        pageColorDark: Colors.black,
        titleStyle: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          //fontFamily: 'Quicksand',
          letterSpacing: 4,
        ),
        // beforeHeroFontSize: 50,
        // afterHeroFontSize: 20,
        // bodyStyle: TextStyle(
        //   //fontStyle: FontStyle.italic,
        //   //decoration: TextDecoration.underline,
        // ),
        textFieldStyle: TextStyle(
          color: Colors.black,
          //shadows: [Shadow(color: Colors.yellow)],
        ),
        buttonStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        cardTheme: CardTheme(
          
          color: Colors.white,
          elevation: 5,
          margin: EdgeInsets.only(top: 15),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(100.0)),
        ),
        inputTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.black45,
          // contentPadding: EdgeInsets.zero,
          errorStyle: TextStyle(
            //backgroundColor: Colors.orange,
            color: Colors.red,
          ),
          labelStyle: TextStyle(fontSize: 18),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 5),
            borderRadius: inputBorder,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 5),
            borderRadius: inputBorder,
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade700, width: 7),
            borderRadius: inputBorder,
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade400, width: 8),
            borderRadius: inputBorder,
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 5),
            borderRadius: inputBorder,
          ),
        ),
        buttonTheme: LoginButtonTheme(
          splashColor: Colors.red,
          backgroundColor: Colors.black,
          highlightColor: Colors.red,
          elevation: 9.0,
          highlightElevation: 6.0,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(1000),
          ),
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          // shape: CircleBorder(side: BorderSide(color: Colors.green)),
          // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
        ),
      ),
      emailValidator: (value) {
        if (!value.contains('@') || !value.endsWith('.com')) {
          return "이메일 주소는 반드시 '@' 를 포함하고 '.com' 로 끝나야 해~!";
        }
        return null;
      },
      passwordValidator: (value) {
        if (value.isEmpty) {
          return '비밀번호가 입력되지 않았습니다';
        }
        return null;
      },
      onLogin: (loginData) {
        print('Login info');
        print('Name: ${loginData.name}');
        print('Password: ${loginData.password}');
        return _loginUser(loginData);
      },
      onSignup: (loginData) {
        print('Signup info');
        print('Name: ${loginData.name}');
        print('Password: ${loginData.password}');
        return _loginUser(loginData);
      },
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(FadePageRoute(
          builder: (context) => DashboardScreen(),
        ));
      },
      onRecoverPassword: (name) {
        print('Recover password info');
        print('Name: $name');
        return _recoverPassword(name);
        // Show new password dialog
      },
      showDebugButtons: false,
    );
  }
}
