import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// 여러 ValueListenable을 동시에 구독하고,
/// 각 listenable의 current value들을 리스트로 전달하는 커스텀 위젯.
class MultiValueListenableBuilder extends StatefulWidget {
  final List<ValueListenable<dynamic>> listenables;
  final Widget Function(
      BuildContext context, List<dynamic> values, Widget? child) builder;
  final Widget? child;

  const MultiValueListenableBuilder({
    Key? key,
    required this.listenables,
    required this.builder,
    this.child,
  }) : super(key: key);

  @override
  _MultiValueListenableBuilderState createState() =>
      _MultiValueListenableBuilderState();
}

class _MultiValueListenableBuilderState
    extends State<MultiValueListenableBuilder> {
  void _listener() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    for (final listenable in widget.listenables) {
      listenable.addListener(_listener);
    }
  }

  @override
  void dispose() {
    for (final listenable in widget.listenables) {
      listenable.removeListener(_listener);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final values = widget.listenables.map((l) => l.value).toList();
    return widget.builder(context, values, widget.child);
  }
}
