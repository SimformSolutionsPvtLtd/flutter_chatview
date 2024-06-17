import 'package:chatview/src/extensions/extensions.dart';
import 'package:chatview/src/models/models.dart';
import 'package:chatview/src/utils/constants/constants.dart';
import 'package:chatview/src/widgets/suggestions/suggestion_item.dart';
import 'package:flutter/material.dart';

class SuggestionList extends StatefulWidget {
  const SuggestionList({
    super.key,
    required this.suggestions,
    this.gap,
  });

  final List<SuggestionItemData> suggestions;
  final double? gap;

  @override
  State<SuggestionList> createState() => _SuggestionListState();
}

class _SuggestionListState extends State<SuggestionList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  ValueNotifier<List<SuggestionItemData>>? newSuggestions;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: suggestionListAnimationDuration,
      vsync: this,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      newSuggestions = provide?.chatController.newSuggestions;
      newSuggestions?.addListener(animateSuggestionList);
    });
  }

  void animateSuggestionList() {
    newSuggestions = provide?.chatController.newSuggestions;
    if (newSuggestions != null) {
      newSuggestions!.value.isEmpty
          ? _controller.reverse()
          : _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final suggestionsItemConfig = suggestionsConfig?.itemConfig;
    final suggestionsListConfig =
        suggestionsConfig?.listConfig ?? const SuggestionListConfig();
    return Container(
      decoration: suggestionsListConfig.decoration,
      padding:
          suggestionsListConfig.padding ?? const EdgeInsets.only(left: 8.0),
      margin: suggestionsListConfig.margin,
      child: SizeTransition(
        sizeFactor: _controller,
        axisAlignment: -1.0,
        fixedCrossAxisSizeFactor: 1,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(
              widget.suggestions.length,
              (index) {
                final suggestion = widget.suggestions[index];
                return suggestion.config?.customItemBuilder
                        ?.call(index, suggestion) ??
                    suggestionsItemConfig?.customItemBuilder
                        ?.call(index, suggestion) ??
                    Padding(
                      padding: EdgeInsets.only(
                        right: index == widget.suggestions.length
                            ? 0
                            : (suggestionsListConfig.itemSeparatorWidth),
                      ),
                      child: SuggestionItem(
                        suggestionItemData: suggestion,
                      ),
                    );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    newSuggestions?.removeListener(animateSuggestionList);
    super.dispose();
  }
}
