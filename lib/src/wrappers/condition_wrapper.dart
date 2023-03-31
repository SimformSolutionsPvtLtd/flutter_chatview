import 'package:flutter/material.dart';

class ConditionalWrapper extends StatelessWidget {
  const ConditionalWrapper(
      {Key? key,
      required this.condition,
      required this.wrapper,
      required this.child})
      : super(key: key);

  final bool condition;
  final Widget Function(Widget child) wrapper;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return condition ? wrapper(child) : child;
  }
}
