import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'launch_state.dart';

@injectable
class LaunchBloc extends HydratedCubit<LaunchState> {
  LaunchBloc() : super(const LaunchState());

  void mutate({
    bool? onboardingPassed,
    bool? showcaseShown,
  }) =>
      emit(
        LaunchState(
          onboardingPassed: onboardingPassed ?? state.onboardingPassed,
          showcaseShown: showcaseShown ?? state.showcaseShown,
        ),
      );

  @override
  LaunchState? fromJson(Map<String, dynamic> json) =>
      LaunchState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(LaunchState state) => state.toJson();
}
