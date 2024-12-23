import 'package:chatview/src/models/data_models/suggestion_item_data.dart';
import 'package:flutter/material.dart';

import '../../values/enumeration.dart';
import 'suggestion_item_config.dart';
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
