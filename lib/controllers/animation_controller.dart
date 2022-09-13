import 'package:get/get.dart';

class MyAnimationController extends GetxController {
  double _margin = 0;
  double get margin => _margin;

  double _opacity = 0;
  double get opacity => _opacity;

  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 1))
        .then((value) => {myFormContainerAnimation()});
  }

  void onClose() {
    super.onClose();
  }

  myFormContainerAnimation() {
    _margin = 50;
    _opacity = 1;
    update();
  }

  validateTextField(val) {
    if (val != "") {
      try {
        double value = double.parse(val);
        return true;
      } catch (e) {
        return false;
      }
    }
    return null;
  }

  validateBodyFat(val) {
    if (val != "") {
      try {
        double value = double.parse(val);
        if (value >= 0 && value <= 100) {
          print("true");
          return true;
        }
        return false;
      } catch (e) {
        return false;
      }
    }
    return null;
  }

  checkNull(val) {
    if (val == "") {
      return true;
    }
    return false;
  }

  updateState() {
    update();
  }
}
