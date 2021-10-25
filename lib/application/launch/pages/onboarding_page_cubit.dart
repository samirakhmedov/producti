import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'onboarding_page_state.dart';

class OnboardingPageCubit extends Cubit<OnboardingPageState> {
  OnboardingPageCubit() : super(const OnboardingPageState());

  void change(int change) {
    final newState = state.currentIndex + change;

    if (newState < 0) {
      return;
    } else if (newState > 2) {
      return;
    }

    emit(state.copyWith(currentIndex: state.currentIndex + change));
  }
}
