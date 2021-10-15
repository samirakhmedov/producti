import 'package:flutter/material.dart';
import 'package:producti_ui/producti_ui.dart';

class AppBottomSheet extends StatelessWidget {
  final Widget? child;

  const AppBottomSheet({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final screenWidth = size.width;
    final popupHeight = size.height * 0.37;

    final theme = ThemeHelper.getTheme(context);

    return Container(
      width: screenWidth,
      height: popupHeight,
      color: theme.backgroundColor,
      padding: EdgeInsets.zero,
      child: Container(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: ThemeHelper.isDarkMode(context) ? kGray : kLightGray,
            ),
          ],
          color: theme.backgroundColor,
        ),
        child: Stack(
          children: [
            if (child != null) child!,
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
    );
  }
}
