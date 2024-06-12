import 'package:chatview/src/utils/emoji.dart';
import 'package:flutter/widgets.dart';

/// This is code is take from the https://github.com/petehouston/flutter-emoji/blob/master/lib/flutter_emoji.dart
/// All Credit of below class goes to @petehouston flutter_emoji
///
/// Constants defined for Emoji.
///
class EmojiConst {
  static final String charNonSpacingMark = String.fromCharCode(0xfe0f);
  static const String charColon = ':';
  static const String charEmpty = '';
  static const String skinToneChars = '\uD83C[\uDFFB-\uDFFF]';
}

/// List of pre-defined message used in this library
class EmojiMessage {
  static const String errorMalformedEmojiName = 'Malformed emoji name';
}

///
/// Utilities to handle emoji operations.
///
class EmojiUtil {
  ///
  /// Strip colons for emoji name.
  /// So, ':heart:' will become 'heart'.
  ///
  static String? stripColons(String? name,
      [void Function(String message)? onError]) {
    if (name == null) {
      return null;
    }
    Iterable<Match> matches = EmojiParser.regexName.allMatches(name);
    if (matches.isEmpty) {
      if (onError != null) {
        onError(EmojiMessage.errorMalformedEmojiName);
      }
      return name;
    }
    return name.replaceAll(EmojiConst.charColon, EmojiConst.charEmpty);
  }

  ///
  /// Wrap colons on both sides of emoji name.
  /// So, 'heart' will become ':heart:'.
  ///
  static String ensureColons(String name) {
    if (name.isEmpty) {
      return "";
    }
    var res = name;
    if (name[0] != EmojiConst.charColon) {
      res = EmojiConst.charColon + name;
    }

    if (!name.endsWith(EmojiConst.charColon)) {
      res += EmojiConst.charColon;
    }

    return res;
  }

  ///
  /// When processing emojis, we don't need to store the graphical byte
  /// which is 0xfe0f, or so-called 'Non-Spacing Mark'.
  ///
  static String? stripNSM(String? name) => name?.replaceAll(
      RegExp(EmojiConst.charNonSpacingMark), EmojiConst.charEmpty);

  ///
  /// When processing emojis, we don't need to store the skin tone.
  ///
  static String? stripSkinTone(String? name) {
    return name?.replaceAll(
      RegExp(EmojiConst.skinToneChars),
      EmojiConst.charEmpty,
    );
  }
}

///
/// The representation of an emoji.
/// There are three properties availables:
///   - 'name' : the emoji name (no colon)
///   - 'full' : the full emoji name. It is name with colons on both sides.
///   - 'code' : the actual graphic presentation of emoji.
///
/// Emoji.None is being used to represent a NULL emoji.
///
class Emoji {
  ///
  /// If emoji not found, the parser always returns this.
  ///
  static final Emoji none = Emoji(EmojiConst.charEmpty, EmojiConst.charEmpty);

  final String name;
  final String code;

  Emoji(this.name, this.code);

  String get full => EmojiUtil.ensureColons(name);

  @override
  bool operator ==(other) {
    return other is Emoji && name == other.name && code == other.code;
  }

  Emoji clone() {
    return Emoji(name, code);
  }

  @override
  String toString() {
    return 'Emoji{name="$name", full="$full", code="$code"}';
  }

  @override
  int get hashCode => name.hashCode;
}

///
/// Emoji storage and parser.
/// You will need to instantiate one of this instance to start using.
///
class EmojiParser {
  static final RegExp regexName = RegExp(r':([\w-+]+):');

  final Map<String, Emoji> _emojisByName = <String, Emoji>{};
  final Map<String?, Emoji> _emojisByCode = <String, Emoji>{};

  static final EmojiParser _emojiParser = EmojiParser._();

  factory EmojiParser() {
    return _emojiParser;
  }

  EmojiParser._({bool init = true}) {
    if (init == true) {
      emojis.forEach((k, v) {
        _emojisByName[v.slug] = Emoji(v.slug, v.char);
        _emojisByCode[EmojiUtil.stripNSM(v.char)] = Emoji(v.slug, v.char);
      });
    }
  }

  ///
  /// Get emoji based on emoji code.
  ///
  /// For example:
  ///
  ///   var parser = EmojiParser();
  ///   var emojiHeart = parser.getEmoji('❤');
  ///   print(emojiHeart); '{name: heart, full: :heart:, emoji: ❤️}'
  ///
  /// Returns null if not found.
  ///
  Emoji? getEmoji(String? emoji) {
    return _emojisByCode[EmojiUtil.stripNSM(EmojiUtil.stripSkinTone(emoji))];
  }

  ///
  /// This method will unemojify the text containing the Unicode emoji symbols
  /// into emoji name.
  ///
  /// For example: 'I ❤️ Flutter' => 'I :heart: Flutter'
  ///
  String unemojify(String text) {
    if (text.isEmpty) return text;

    final characters = Characters(text);
    final buffer = StringBuffer();
    for (final character in characters) {
      final maybeEmoji = getEmoji(character);
      if (maybeEmoji != null) {
        var result = character;
        result = result.replaceAll(
          character,
          maybeEmoji.full,
        );

        buffer.write(result);
      } else {
        buffer.write(character);
      }
    }
    return buffer.toString();
  }

  ///
  /// Return a list of emojis found in the input text
  ///
  /// For example: parseEmojis('I ❤️ Flutter just like ☕') => ['❤️', '☕']
  ///
  List<String> parseEmojis(String text) {
    if (text.isEmpty) return List.empty();

    List<String> result = <String>[];
    for (final character in text.characters) {
      if (getEmoji(character) != null) {
        result.add(character);
      }
    }
    return result;
  }
}
