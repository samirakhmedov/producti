import 'package:flutter/material.dart';
import 'package:producti_ui/producti_ui.dart';

class AppBottomSheet extends StatelessWidget {
  final Widget? child;

  const AppBottomSheet({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final screenWidth = size.width;
    final popupHeight = size.height * 0.57;

    final theme = ThemeHelper.getTheme(context);

    return Container(
      width: screenWidth,
      height: popupHeight,
      color: Colors.transparent,
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
              color: kLightGray,
            ),
          ],
          color: theme.backgroundColor,
        ),
        child: Stack(
          children: [
            Positioned(
              right: 30,
              top: 16,
              child: IconButton(
                constraints: BoxConstraints.expand(
                  height: 15,
                  width: 15,
                ),
                icon: Icon(
                  Icons.close,
                  color: kBlack,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}
