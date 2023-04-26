import 'package:sport/extensions/imports.dart';

enum FingerPrint {
  none,
  forward,
  backward,
}

class HomeScrollProvider extends ChangeNotifier {
  FingerPrint fingerPrint = FingerPrint.none;

  void fingerPrintAnimationForward() {
    fingerPrint = FingerPrint.forward;
    notifyListeners();
  }

  void fingerPrintAnimationBackward() {
    fingerPrint = FingerPrint.backward;
    notifyListeners();
  }

  void reset() {
    fingerPrint = FingerPrint.none;
    notifyListeners();
  }
}
