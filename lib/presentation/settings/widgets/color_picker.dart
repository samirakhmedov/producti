import 'package:flutter/material.dart';
import 'package:producti_ui/producti_ui.dart';

class ColorPicker extends StatelessWidget {
  final void Function(Color color)? onSelect;

  const ColorPicker({Key? key, this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        itemCount: colorList.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const Gap(size: 25),
        itemBuilder: (context, index) => InkWell(
          onTap: () => onSelect?.call(colorList[index]),
          child: _ColorCircle(
            color: colorList[index],
          ),
        ),
      ),
    );
  }
}

class _ColorCircle extends StatelessWidget {
  final Color color;

  const _ColorCircle({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
