import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class RoundButton extends StatefulWidget {
  RoundButton({
    Key key,
    @required this.icon,
    @required this.onPressed,
    @required this.label,
    @required this.loadingController,
    this.interval = const Interval(0, 1, curve: Curves.ease),
    this.size = 60,
  }) : super(key: key);

  final Widget icon;
  final VoidCallback onPressed;
  final String label;
  final AnimationController loadingController;
  final Interval interval;
  final double size;

  @override
  _RoundButtonState createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton>
    with SingleTickerProviderStateMixin {
  AnimationController _pressController;
  Animation<double> _scaleLoadingAnimation;
  Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 500),
    );
    _scaleLoadingAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: widget.loadingController,
        curve: widget.interval,
      ),
    );
    _scaleAnimation = Tween<double>(begin: 1, end: .75).animate(
      CurvedAnimation(
        parent: _pressController,
        curve: Curves.easeOut,
        reverseCurve: ElasticInCurve(0.3),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pressController.dispose();
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor =
        Colors.white;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ScaleTransition(
        scale: _scaleLoadingAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ScaleTransition(
              scale: _scaleAnimation,
              child: SizedBox(
                width: widget.size,
                height: widget.size,
                child: FittedBox(
                  child: FloatingActionButton(
                    // allow more than 1 FAB in the same screen (hero tag cannot be duplicated)
                    heroTag: null,
                    backgroundColor: primaryColor,
                    child: widget.icon,
                    onPressed: () {
                      _pressController.forward().then((_) {
                        _pressController.reverse();
                      });
                      widget.onPressed();
                      setState(() {
                        _onBasicAlertPressed(context);
                      });
                    },
                    foregroundColor: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text( // icons name text
              widget.label,
              style:
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
