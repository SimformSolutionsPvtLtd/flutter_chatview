import 'package:chatview/src/extensions/extensions.dart';
import 'package:chatview/src/models/models.dart';
import 'package:flutter/material.dart';

class SuggestionItem extends StatelessWidget {
  const SuggestionItem({
    super.key,
    required this.suggestionItemData,
  });

  final SuggestionItemData suggestionItemData;

  @override
  Widget build(BuildContext context) {
    final suggestionsConfig =
        context.suggestionsConfig ?? const ReplySuggestionsConfig();
    final suggestionsListConfig = suggestionsConfig.itemConfig;
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        suggestionsConfig.onTap?.call(suggestionItemData);
        if (suggestionsConfig.autoDismissOnSelection) {
          context.chatViewIW?.chatController.removeReplySuggestions();
        }
      },
      child: Container(
        padding: suggestionItemData.config?.padding ??
            suggestionsListConfig?.padding ??
            const EdgeInsets.all(6),
        decoration: suggestionItemData.config?.decoration ??
            suggestionsListConfig?.decoration ??
            BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                color: theme.primaryColor,
              ),
            ),
        child: Text(
          suggestionItemData.text,
          style: suggestionItemData.config?.textStyle ??
              suggestionsListConfig?.textStyle,
        ),
      ),
    );
  }
}
