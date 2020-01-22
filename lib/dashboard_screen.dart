import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/theme.dart';
import 'package:flutter_login/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'constants.dart';
import 'transition_route_observer.dart';
import 'widgets/animated_numeric_text.dart';
import 'widgets/fade_in.dart';
import 'widgets/round_button.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin, TransitionRouteAware {
  Future<bool> _goToLogin(BuildContext context) {
    return Navigator.of(context)
        .pushReplacementNamed('/')
        // we dont want to pop the screen, just replace it completely
        .then((_) => false);
  }

  final routeObserver = TransitionRouteObserver<PageRoute>();
  static const headerAniInterval =
      const Interval(.1, .3, curve: Curves.easeOut);
  Animation<double> _headerScaleAnimation;
  AnimationController _loadingController;

  @override
  void initState() {
    super.initState();

    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1250),
    );

    _headerScaleAnimation =
        Tween<double>(begin: .6, end: 1).animate(CurvedAnimation(
      parent: _loadingController,
      curve: headerAniInterval,
    ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _loadingController.dispose();
    super.dispose();
  }
void _onBasicAlertPressed(context) {
        Alert(
                context: context,
                title: "개발중!",
                buttons: [
                  DialogButton(
                    child: Text(
                      "확인",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Colors.black,
                    onPressed: () => Navigator.pop(context),
                    width: 120,
                  )
                ],
                desc: "현재 자람앱 기능 구현 개발 중에 있습니다.")
            .show();
      }
  @override
  void didPushAfterTransition() => _loadingController.forward();

  AppBar _buildAppBar(ThemeData theme) {
    final menuBtn = IconButton(
      color: Colors.black,
      icon: const Icon(FontAwesomeIcons.bars),
      onPressed: () {
        setState(() {
          _onBasicAlertPressed(context);
        });
      },
    );
    final signOutBtn = IconButton(
      icon: const Icon(FontAwesomeIcons.signOutAlt),
      color: Colors.black,
      onPressed: () => _goToLogin(context),
    );
    final title = Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Hero(
              tag: Constants.logoTag,
              child: Image.asset(
                'assets/images/Jaram.png',
                filterQuality: FilterQuality.high,
                height: 30,
              ),
            ),
          ),
          HeroText(
            Constants.appName,
            tag: Constants.titleTag,
            viewState: ViewState.shrunk,
            style: LoginThemeHelper.loginTextStyle,
          ),
          SizedBox(width: 20),
        ],
      ),
    );

    return AppBar(
      leading: FadeIn(
        child: menuBtn,
        controller: _loadingController,
        offset: .3,
        curve: headerAniInterval,
        fadeDirection: FadeDirection.startToEnd,
      ),
      actions: <Widget>[
        FadeIn(
          child: signOutBtn,
          controller: _loadingController,
          offset: .3,
          curve: headerAniInterval,
          fadeDirection: FadeDirection.endToStart,
        ),
      ],
      title: title,
      backgroundColor: theme.primaryColor.withOpacity(.1),
      elevation: 0,
      textTheme: theme.accentTextTheme,
      iconTheme: theme.accentIconTheme,
    );
  }

  Widget _buildHeader(ThemeData theme) {
    final primaryColor =
        Colors.white;
    final linearGradient = LinearGradient(colors: [
      primaryColor,
      primaryColor,
    ]).createShader(Rect.fromLTWH(0.0, 0.0, 418.0, 78.0));

    return ScaleTransition(
      scale: _headerScaleAnimation,
      child: FadeIn(
        controller: _loadingController,
        curve: headerAniInterval,
        fadeDirection: FadeDirection.bottomToTop,
        offset: .5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              
              '회계의 생명지수',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40.0,
                fontWeight: FontWeight.bold
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text( // money state text
                  '\₩',
                  style: theme.textTheme.display2.copyWith(
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 5),
                AnimatedNumericText(
                  initialValue: 14,
                  targetValue: 3467.87,
                  curve: Interval(0, .5, curve: Curves.easeOut),
                  controller: _loadingController,
                  style: theme.textTheme.display2.copyWith(
                    foreground: Paint()..shader = linearGradient,
                  ),
                ),
                Text( // money state text
                  '\ 원',
                  style: theme.textTheme.display2.copyWith(
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Text('Account Balance', style: theme.textTheme.caption),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({Widget icon, String label, Interval interval}) {
    return RoundButton(
      
      icon: icon,
      label: label,
      loadingController: _loadingController,
      interval: Interval(
        interval.begin,
        interval.end,
        curve: ElasticOutCurve(0.42),
      ),
      onPressed: () {},
    );
  }

  Widget _buildDashboardGrid() {
    const step = 0.04;
    const aniInterval = 0.75;

    return GridView.count(
      padding: const EdgeInsets.symmetric(
        horizontal: 32.0,
        vertical: 20,
      ),
      childAspectRatio: .9,
      // crossAxisSpacing: 5,
      crossAxisCount: 3,
      children: [
        // _buildButton(
        //   icon: Icon(FontAwesomeIcons.user),
        //   label: '프로필',
        //   interval: Interval(0, aniInterval),
        // ),
        // _buildButton(
        //   icon: Container(
            
        //     // fix icon is not centered like others for some reasons
        //     padding: const EdgeInsets.only(left: 16.0),
        //     alignment: Alignment.centerLeft,
        //     child: Icon(
              
        //       FontAwesomeIcons.moneyBillAlt,
        //       size: 20,
        //       color: Colors.black,
        //     ),
        //   ),
        //   label: '회비 관리',
        //   interval: Interval(step, aniInterval + step),
        // ),
        _buildButton(
          icon: Icon(FontAwesomeIcons.dollarSign),
          label: '가계부',
          interval: Interval(step * 2, aniInterval + step * 2),
        ),
        _buildButton(
          icon: Icon(FontAwesomeIcons.handHoldingUsd),
          label: '회비 관리',
          interval: Interval(0, aniInterval),
        ),
        _buildButton(
          icon: Icon(FontAwesomeIcons.book),
          label: '블랙리스트',
          interval: Interval(0, aniInterval),
        ),
        // _buildButton(
        //   icon: Icon(Icons.vpn_key),
        //   label: '회원 등록',
        //   interval: Interval(step, aniInterval + step),
        // ),
        // _buildButton(
        //   icon: Icon(FontAwesomeIcons.history),
        //   label: '기록',
        //   interval: Interval(step * 2, aniInterval + step * 2),
        // ),
        // _buildButton(
        //   icon: Icon(FontAwesomeIcons.ellipsisH),
        //   label: '대외',
        //   interval: Interval(0, aniInterval),
        // ),
        // _buildButton(
        //   icon: Icon(FontAwesomeIcons.search, size: 20),
        //   label: '회원 검색',
        //   interval: Interval(step, aniInterval + step),
        // ),
        // _buildButton(
        //   icon: Icon(FontAwesomeIcons.slidersH, size: 20),
        //   label: '설정',
        //   interval: Interval(step * 2, aniInterval + step * 2),
        // ),
      ],
    );
  }

  Widget _buildDebugButtons() {
    const textStyle = TextStyle(fontSize: 12, color: Colors.white);

    return Positioned(
      bottom: 0,
      right: 0,
      child: Row(
        children: <Widget>[
          RaisedButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Colors.red,
            child: Text('loading', style: textStyle),
            onPressed: () => _loadingController.value == 0
                ? _loadingController.forward()
                : _loadingController.reverse(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () => _goToLogin(context),
      child: SafeArea(
        child: Scaffold(
          appBar: _buildAppBar(theme),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            //color: theme.primaryColor.withOpacity(.1),
            color: Colors.black,
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(height: 40),
                    Expanded(
                      flex: 2,
                      child: _buildHeader(theme),
                    ),
                    Expanded(
                      flex: 8,
                      child: ShaderMask(
                        // blendMode: BlendMode.srcOver,
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            tileMode: TileMode.clamp,
                            colors: <Color>[ // all icons background color can be rainbow color
                              Colors.white,
                              Colors.white,
                              Colors.white,
                              Colors.white,
                            ],
                          ).createShader(bounds);
                        },
                        child: _buildDashboardGrid(),
                      ),
                    ),
                  ],
                ),
                if (!kReleaseMode) _buildDebugButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
