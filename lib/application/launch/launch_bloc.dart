import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'launch_event.dart';
part 'launch_state.dart';

@injectable
class LaunchBloc extends HydratedBloc<LaunchEvent, LaunchState> {
  LaunchBloc() : super(const LaunchState());

  @override
  Stream<LaunchState> mapEventToState(
    LaunchEvent event,
  ) async* {
    if (event is LaunchSwitchOnboardingStatus) {
      yield state.copyWith(
        onboardingPassed: !state.onboardingPassed,
      );
    }
  }

  @override
  LaunchState? fromJson(Map<String, dynamic> json) =>
      LaunchState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(LaunchState state) => state.toJson();
}
