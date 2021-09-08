import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class OnboardingPageController extends GetxController {
  final RxInt _currentIndex = RxInt(0);

  int get currentIndex => _currentIndex.value;

  set currentIndex(int newIndex) => _currentIndex.value = newIndex;
}
