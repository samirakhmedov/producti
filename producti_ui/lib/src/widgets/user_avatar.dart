import 'package:flutter/material.dart';
import 'package:producti_ui/producti_ui.dart';

class UserAvatar extends StatelessWidget {
  final double? size;
  final ImageProvider? imageProvider;

  const UserAvatar({
    Key? key,
    this.size = 33,
    this.imageProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: imageProvider != null
            ? DecorationImage(
                image: imageProvider!,
                repeat: ImageRepeat.noRepeat,
                fit: BoxFit.cover,
              )
            : null,
        color: kLightGray,
      ),
      child: imageProvider == null
          ? Icon(
              Icons.perm_identity_outlined,
            )
          : null,
    );
  }
}
