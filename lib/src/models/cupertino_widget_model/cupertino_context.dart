import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../chatview.dart';

class CupertinoMenuConfiguration {
  final List<Widget> Function(Message message)? actionsBuilder;

  final EdgeInsets? padding;

  final Widget Function(
    BuildContext context,
    Animation<double> animation,
    Message message,
    Widget emojiSelectorWidget,
    Widget child,
  )? previewBuilder;

  final bool ignorePointer;

  final DefaultMenuActionsConfiguration defaultMenuActionsConfigurations;

  final bool showCupertinoContextMenu;

  const CupertinoMenuConfiguration(
      {this.actionsBuilder,
      this.padding,
      this.previewBuilder,
      this.showCupertinoContextMenu = true,
      this.defaultMenuActionsConfigurations =
          const DefaultMenuActionsConfiguration(),
      this.ignorePointer = true});
}

class DefaultMenuActionsConfiguration {
  final IconData? shareIcon;

  final Function(Message message)? shareOnPressed;

  final bool showShareMenu;

  final Widget shareWidget;

  final IconData? copyIcon;

  final Function(Message message)? copyOnPressed;

  final bool showCopyMenu;

  final Widget copyWidget;

  final IconData? favoriteIcon;

  final bool showfavoriteMenu;

  final Function(Message message)? favoriteOnPressed;

  final Widget favoriteWidget;

  final IconData? reactionsIcon;

  final bool showReactionsMenu;

  final Function(Message message)? reactionsOnPressed;

  final Widget reactionsWidget;

  final IconData? deleteIcon;

  final bool showDeleteMenu;

  final Function(Message message)? deleteOnPressed;

  final Widget deleteWidget;

  const DefaultMenuActionsConfiguration({
    this.shareIcon = CupertinoIcons.share,
    this.shareOnPressed,
    this.showShareMenu = true,
    this.shareWidget = const Text('Share'),
    this.copyIcon = CupertinoIcons.doc_on_clipboard_fill,
    this.copyOnPressed,
    this.showCopyMenu = true,
    this.copyWidget = const Text('Copy'),
    this.favoriteIcon = CupertinoIcons.heart,
    this.favoriteOnPressed,
    this.showfavoriteMenu = true,
    this.favoriteWidget = const Text('Favorite'),
    this.reactionsIcon = Icons.add_reaction_outlined,
    this.reactionsOnPressed,
    this.showReactionsMenu = true,
    this.reactionsWidget = const Text('Reactions'),
    this.deleteIcon = CupertinoIcons.delete,
    this.deleteOnPressed,
    this.showDeleteMenu = true,
    this.deleteWidget = const Text('Delete'),
  });
}
