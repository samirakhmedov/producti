import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:producti/application/core/cubit/connection_cubit.dart';
import 'package:producti/presentation/core/widgets/connection/connectivity_messenger.dart';

class ConnectivityListener extends StatelessWidget {
  final Widget? child;

  const ConnectivityListener({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectionCubit, ConnectionCubitState>(
      listener: (context, state) =>
          ConnectivityMessenger.showConnectionMessage(context),
      child: child,
    );
  }
}
