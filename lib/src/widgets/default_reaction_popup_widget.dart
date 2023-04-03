part of '../../chatview.dart';

class DefaultReactionPopup extends StatelessWidget {
  const DefaultReactionPopup(
      {Key? key, this.reactionPopupConfig, required this.reactionPopupRow})
      : super(key: key);

  final ReactionPopupConfiguration? reactionPopupConfig;
  final Widget reactionPopupRow;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: reactionPopupConfig?.maxWidth ?? 350),
      margin: reactionPopupConfig?.margin ??
          const EdgeInsets.symmetric(horizontal: 25),
      padding: reactionPopupConfig?.padding ??
          const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 14,
          ),
      decoration: BoxDecoration(
        color: reactionPopupConfig?.backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          reactionPopupConfig?.shadow ??
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 8,
                spreadRadius: -2,
                offset: const Offset(0, 8),
              )
        ],
      ),
      child: reactionPopupRow,
    );
  }
}
