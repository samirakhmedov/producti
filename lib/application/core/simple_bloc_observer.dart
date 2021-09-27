import 'package:bloc/bloc.dart';
import 'package:producti/presentation/core/constants/logger.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);

    logger.i('BLoC created! $bloc');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);

    logger.i('New event comes to $bloc! => $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    logger.i(
        '$bloc state moving from ${change.currentState} to ${change.nextState}.');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);

    logger.i(
        '$bloc state moved from ${transition.currentState} to ${transition.nextState}.');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);

    logger.e('Error occured in $bloc! $error, $stackTrace');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);

    logger.i('$bloc instance closed!');
  }
}
