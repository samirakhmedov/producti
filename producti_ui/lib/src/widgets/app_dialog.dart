import 'package:flutter/material.dart';
import 'package:producti_ui/producti_ui.dart';

class AppDialog extends StatelessWidget {
  final Widget? child;

  const AppDialog({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeHelper.getTheme(context);

    final size = MediaQuery.of(context).size;

    return Dialog(
      backgroundColor: theme.backgroundColor,
      elevation: 8,
      child: SizedBox(
        width: size.width * .8,
        height: size.height * .3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              if (child != null)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: child,
                  ),
                ),
              Positioned(
                right: 16,
                top: 16,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(
                    Icons.close,
                    color: ThemeHelper.isDarkMode(context) ? kWhite : kBlack,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
