/*
 * Copyright (c) 2022 Simform Solutions
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import 'package:animated_text_kit/animated_text_kit.dart';

///Configuration for Animated Typewriter functionality as in a chatbot.
class TypewriterAnimatedConfiguration {
  ///Toggle to enable
  /// By default it is set to false.
  final bool enableConfiguration;

  /// A controller for managing the state of an animated text sequence.
  ///
  /// This controller exposes methods to play, pause, and reset the animation.
  /// The [AnimatedTextState] enum represents the various states the animation
  /// can be in. By calling [play()], [pause()], or [reset()], you can transition
  /// between these states and the animated widget will react accordingly.
  AnimatedTextController? controller;

  /// Should the animation ends up early and display full text if you tap on it?
  ///
  /// By default it is set to false.
  final bool displayFullTextOnTap;

  ///The [Duration] of the delay between the apparition of each characters

  ///By default it is set to 50 milliseconds.
  final Duration duration;

  TypewriterAnimatedConfiguration({
    this.displayFullTextOnTap = false,
    this.controller,
    this.enableConfiguration = false,
    this.duration = const Duration(milliseconds: 50),
  });
}
