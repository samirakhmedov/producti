part of 'launch_bloc.dart';

class LaunchState extends Equatable {
  final bool onboardingPassed;

  const LaunchState({
    this.onboardingPassed = false,
  });

  @override
  List<Object> get props => [onboardingPassed];

  Map<String, dynamic> toJson() {
    return {
      'onboarding_passed': onboardingPassed,
    };
  }

  factory LaunchState.fromJson(Map<String, dynamic> json) => LaunchState(
        onboardingPassed: json['onboarding_passed'] as bool,
      );

  LaunchState copyWith({
    bool? onboardingPassed,
  }) {
    return LaunchState(
      onboardingPassed: onboardingPassed ?? this.onboardingPassed,
    );
  }
}
