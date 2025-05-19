import 'package:flutter/material.dart';
import 'package:chatview_utils/chatview_utils.dart';

import '../../values/enumeration.dart';
import 'suggestion_list_config.dart';

class ReplySuggestionsConfig {
  final SuggestionItemConfig? itemConfig;
  final SuggestionListConfig? listConfig;
  final ValueSetter<SuggestionItemData>? onTap;
  final bool autoDismissOnSelection;
  final SuggestionItemsType suggestionItemType;
  final double spaceBetweenSuggestionItemRow;

  const ReplySuggestionsConfig({
    this.listConfig,
    this.itemConfig,
    this.onTap,
    this.autoDismissOnSelection = true,
    this.suggestionItemType = SuggestionItemsType.scrollable,
    this.spaceBetweenSuggestionItemRow = 10,
  });
}
