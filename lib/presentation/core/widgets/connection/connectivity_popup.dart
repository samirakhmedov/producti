import 'package:flutter/material.dart';
import 'package:producti/generated/l10n.dart';
import 'package:producti_ui/producti_ui.dart';
import 'package:simple_animations/simple_animations.dart';

enum _AnimationProps { one }

class ConnectivityPopup extends StatelessWidget {
  final bool hasConnection;
  final void Function() onComplete;

  const ConnectivityPopup({
    Key? key,
    required this.onComplete,
    required this.hasConnection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _position = TimelineTween<_AnimationProps>()
      ..addScene(
        begin: Duration.zero,
        duration: const Duration(seconds: 4),
        curve: Curves.easeIn,
      ).animate(
        _AnimationProps.one,
        tween: Tween<double>(begin: 0, end: 1),
      )
      ..addScene(
        begin: const Duration(
          milliseconds: 4750,
        ),
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.easeIn,
      ).animate(
        _AnimationProps.one,
        tween: Tween<double>(begin: 1, end: 0),
      );

    return PlayAnimation<TimelineValue<_AnimationProps>>(
      tween: _position,
      onComplete: onComplete,
      builder: (context, child, value) {
        return Positioned(
          left: 0,
          top: 30 * value.get(_AnimationProps.one) - 30,
          child: child!,
        );
      },
      child: Material(
        color: Colors.white.withOpacity(0),
        child: _ConnectivityPopupContent(
          hasConnection: hasConnection,
        ),
      ),
    );
  }
}

class _ConnectivityPopupContent extends StatelessWidget {
  final bool hasConnection;

  const _ConnectivityPopupContent({
    Key? key,
    required this.hasConnection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);

    final theme = Theme.of(context);

    final textTheme = theme.textTheme;

    final intl = S.of(context);

    return Container(
      height: 60 + query.padding.top,
      width: query.size.width,
      decoration: BoxDecoration(
        color: hasConnection ? kGreen : kRed,
        borderRadius: const BorderRadius.only(
          bottomLeft: const Radius.circular(12),
          bottomRight: const Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 30 + query.padding.top,
          ),
          Center(
            child: Text(
              hasConnection ? intl.connected : intl.disconnected,
              style: textTheme.caption!.copyWith(
                color: theme.backgroundColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
