import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PatternStyle {
  PatternStyle(this.from, this.regExp, this.replace, this.textStyle);

  final Pattern from;
  final RegExp regExp;
  final String replace;
  final TextStyle textStyle;

  String get pattern => regExp.pattern;

  static PatternStyle get bold => PatternStyle(
        RegExp('(\\*\\*|\\*)'),
        RegExp('(\\*\\*|\\*)(.*?)(\\*\\*|\\*)'),
        '',
        const TextStyle(fontWeight: FontWeight.bold),
      );

  static PatternStyle get code => PatternStyle(
        '`',
        RegExp('`(.*?)`'),
        '',
        TextStyle(
          fontFamily: Platform.isIOS ? 'Courier' : 'monospace',
        ),
      );

  static PatternStyle get italic => PatternStyle(
        '_',
        RegExp('_(.*?)_'),
        '',
        const TextStyle(fontStyle: FontStyle.italic),
      );

  static PatternStyle get lineThrough => PatternStyle(
        '~',
        RegExp('~(.*?)~'),
        '',
        const TextStyle(decoration: TextDecoration.lineThrough),
      );

  static PatternStyle get at => PatternStyle(
        '@',
        RegExp(r"@\w+"),
        '',
        const TextStyle(backgroundColor: Colors.grey),
      );
}
