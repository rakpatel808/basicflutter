import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  static List<Color> randomColors = [
    Colors.grey,
    Colors.grey[200],
    Colors.grey[800],
    Colors.red,
    Colors.purple,
    Colors.lightBlueAccent
  ];
  static List<Color> randomFontColors = [
    Colors.white,
    Colors.grey[700],
    Colors.black
  ];
  static int maxRotate = 45;
  static int baseFontSize = 20;
  static int randomFontSize = 40;
  static int maxBorderRadios = 20;
  static List<FontWeight> fontWeightList = [FontWeight.bold, FontWeight.normal];
  static List<FontStyle> fontStyleList = [FontStyle.italic, FontStyle.normal];
  static List<Function> textStyleList = [
    GoogleFonts.notoSerif,
    GoogleFonts.mPlus1p,
    GoogleFonts.sawarabiMincho,
    GoogleFonts.kosugiMaru
  ];
}




class RondomProvider {
  final _rand = Random();
  Color getColors() {
    return Constants.randomColors[_rand.nextInt(Constants.randomColors.length)];
  }

  Animation<double> getRotate() {
    return AlwaysStoppedAnimation(
        (Constants.maxRotate * (_rand.nextDouble() - _rand.nextDouble())) /
            360);
  }

  BorderRadius getBorderRadious() {
    return BorderRadius.only(
      topRight:
          Radius.circular(_rand.nextInt(Constants.maxBorderRadios).toDouble()),
      topLeft:
          Radius.circular(_rand.nextInt(Constants.maxBorderRadios).toDouble()),
      bottomRight:
          Radius.circular(_rand.nextInt(Constants.maxBorderRadios).toDouble()),
      bottomLeft:
          Radius.circular(_rand.nextInt(Constants.maxBorderRadios).toDouble()),
    );
  }

  TextStyle getTextStyle() {
    return Constants
            .textStyleList[_rand.nextInt(Constants.textStyleList.length)](
        fontSize: Constants.baseFontSize +
            Constants.randomFontSize * _rand.nextDouble(),
        color: Constants.randomFontColors[
            _rand.nextInt(Constants.randomFontColors.length)]);
  }
}


class BlackStr extends StatelessWidget {
  final String __str;
  BlackStr(this.__str);

  @override
  Widget build(BuildContext context) {
    var tnp = RondomProvider();
    return RotationTransition(
        turns: tnp.getRotate(),
        child: Container(
          decoration: BoxDecoration(
              color: tnp.getColors(), borderRadius: tnp.getBorderRadious()),
          child: Text(__str, style: tnp.getTextStyle()),
        ));
  }
}


class BlackMail extends StatefulWidget {
  final String __str;
  BlackMail(this.__str);
  @override
  _BlackMailState createState() => _BlackMailState();
}

class _BlackMailState extends State<BlackMail>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: widget.__str
              .split("")
              .map((item) => ScaleTransition(
                  scale: _animationController.drive(
                    CurveTween(
                      curve: const Interval(0, 0.8, curve: Curves.elasticInOut),
                    ),
                  ),
                  child: BlackStr(item)))
              .toList()),
    ));
  }
}

