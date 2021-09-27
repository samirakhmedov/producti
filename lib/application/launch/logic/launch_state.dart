part of 'launch_bloc.dart';

class LaunchState extends Equatable {
  final bool onboardingPassed;
  final bool showcaseShown;

  const LaunchState({
    this.showcaseShown = false,
    this.onboardingPassed = false,
  });

  @override
  List<Object> get props => [onboardingPassed, showcaseShown];

  LaunchState copyWith({
    bool? onboardingPassed,
    bool? showcaseShown,
  }) {
    return LaunchState(
      onboardingPassed: onboardingPassed ?? this.onboardingPassed,
      showcaseShown: showcaseShown ?? this.showcaseShown,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'onboardingPassed': onboardingPassed,
      'showcaseShown': showcaseShown,
    };
  }

  factory LaunchState.fromJson(Map<String, dynamic> json) {
    return LaunchState(
      onboardingPassed: json['onboardingPassed'] as bool,
      showcaseShown: json['showcaseShown'] as bool,
    );
  }

  String toString() =>
      'LaunchState(onboarding: $onboardingPassed, showcase: $showcaseShown)';
}
