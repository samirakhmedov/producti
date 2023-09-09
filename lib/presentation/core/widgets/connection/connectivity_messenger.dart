import 'package:flutter/cupertino.dart';
import 'package:producti/application/core/cubit/connection_cubit.dart';
import 'package:producti/presentation/core/widgets/connection/connectivity_popup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectivityMessenger {
  static void showConnectionMessage(BuildContext context) {
    late OverlayEntry overlayEntry;

    final connection = context.read<ConnectionCubit>();

    overlayEntry = OverlayEntry(
      builder: (context) => ConnectivityPopup(
        onComplete: () {
          overlayEntry.remove();
        },
        hasConnection: connection.state.connectionStatus == ConnectionStatus.connected,
      ),
    );

    Overlay.of(context).insert(overlayEntry);
  }
}
