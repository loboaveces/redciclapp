import 'package:flutter/widgets.dart';

//We need to import ‘widgets.dart’ in order to use a very convenient
//class in Flutter that’s called MediaQueryData which holds the
//information of the current media, among which there is the size
// of our screen.

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  static double logicalPixelWidth;
  static double logicalPixelHeight;
  static double devicePixelRatio;
  static double devicePixelWidth;
  static double devicePixelHeight;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    logicalPixelWidth = MediaQuery.of(context).size.width;
    logicalPixelHeight = MediaQuery.of(context).size.height;
    devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    devicePixelWidth = logicalPixelWidth * devicePixelRatio;
    devicePixelHeight = logicalPixelHeight * devicePixelRatio;
  }
}
