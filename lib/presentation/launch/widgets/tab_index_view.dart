import 'package:flutter/material.dart';
import 'package:producti/presentation/core/constants/constants.dart';
import 'package:producti_ui/producti_ui.dart';

class TabIndexView extends StatefulWidget {
  final int length;
  final int current;

  const TabIndexView({
    Key? key,
    required this.length,
    required this.current,
  }) : super(key: key);

  @override
  _TabIndexViewState createState() => _TabIndexViewState();
}

class _TabIndexViewState extends State<TabIndexView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (widget.length * 10) + (widget.length - 1) * 13,
      height: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          widget.length,
          (index) => TabIndexWidget(
            selected: index == widget.current,
          ),
        ),
      ),
    );
  }
}

class TabIndexWidget extends StatefulWidget {
  final bool selected;

  const TabIndexWidget({
    Key? key,
    this.selected = false,
  }) : super(key: key);

  @override
  _TabIndexWidgetState createState() => _TabIndexWidgetState();
}

class _TabIndexWidgetState extends State<TabIndexWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.selected ? theme.primaryColor : kLightGray,
      ),
    );
  }
}
