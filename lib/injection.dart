import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

/// `Service locator`. Will be holding all
/// app dependecies. Let us to not make
/// our app (more conretely, widget tree
/// and Widget classes implementation) a
/// living nightmare.
final sl = GetIt.instance;

@InjectableInit(
  initializerName: 'initDependecies',
)
Future<void> configureDependecies() => initDependecies(sl);
