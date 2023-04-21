import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PatternStyle {
  const PatternStyle(
    this.name,
    this.from,
    this.regExp,
    this.replace,
    this.textStyle,
  );

  final Pattern from;
  final RegExp regExp;
  final String replace;
  final TextStyle textStyle;
  final String name;

  String get pattern => regExp.pattern;

  static PatternStyle get bold => PatternStyle(
        'bold',
        RegExp('(\\*\\*|\\*)'),
        RegExp('(\\*\\*|\\*)(.*?)(\\*\\*|\\*)'),
        '',
        const TextStyle(fontWeight: FontWeight.bold),
      );

  static PatternStyle get code => PatternStyle(
        "code",
        '`',
        RegExp('`(.*?)`'),
        '',
        TextStyle(
          fontFamily: Platform.isIOS ? 'Courier' : 'monospace',
        ),
      );

  static PatternStyle get italic => PatternStyle(
        'italic',
        '_',
        RegExp('_(.*?)_'),
        '',
        const TextStyle(fontStyle: FontStyle.italic),
      );

  static PatternStyle get lineThrough => PatternStyle(
        'linethrough',
        '~',
        RegExp('~(.*?)~'),
        '',
        const TextStyle(decoration: TextDecoration.lineThrough),
      );
}
