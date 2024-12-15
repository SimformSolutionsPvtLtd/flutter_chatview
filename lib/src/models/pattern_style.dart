import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PatternStyle {
  const PatternStyle(
      this.name, this.from, this.regExp, this.replace, this.textStyle,
      {this.atSource});

  final Pattern from;
  final RegExp regExp;
  final String replace;
  final TextStyle textStyle;
  final String name;
  final String? atSource;
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
          fontFamily: (!kIsWeb && Platform.isIOS) ? 'Courier' : 'monospace',
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

  static PatternStyle get at => PatternStyle(
        'at',
        '@',
        RegExp(r"(@samarth girolkar|@yogesh dubey)"),
        '',
        const TextStyle(color: Color.fromARGB(255, 2, 100, 145)),
      );
}
