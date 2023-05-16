part of '../../../chatview.dart';

class WhatsappStyleMessageTimeWidget extends StatelessWidget {
  const WhatsappStyleMessageTimeWidget(this.message, {super.key});

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(DateTime.fromMillisecondsSinceEpoch(message.createdAt)
              .getTimeFromDateTime),
          if (message.status == MessageStatus.pending) ...[
            const Icon(Icons.check_box)
          ]
        ],
      ),
    );
  }
}
