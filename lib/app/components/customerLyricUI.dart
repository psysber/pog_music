import 'package:flutter/material.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:flutter_lyric/lyric_ui/lyric_ui.dart';

class CustomerLyricUI extends LyricUI {
  double defaultSize;
  double defaultExtSize;
  double otherMainSize;
  double bias;
  double lineGap;
  double inlineGap;
  LyricAlign lyricAlign;
  LyricBaseLine lyricBaseLine;
  bool highlight;
  HighlightDirection highlightDirection;

  CustomerLyricUI(
      {this.defaultSize = 18,
      this.defaultExtSize = 14,
      this.otherMainSize = 16,
      this.bias = 0.5,
      this.lineGap = 25,
      this.inlineGap = 25,
      this.lyricAlign = LyricAlign.CENTER,
      this.lyricBaseLine = LyricBaseLine.CENTER,
      this.highlight = true,
      this.highlightDirection = HighlightDirection.LTR});

  CustomerLyricUI.clone(CustomerLyricUI customerLyricUI)
      : this(
          defaultSize: customerLyricUI.defaultSize,
          defaultExtSize: customerLyricUI.defaultExtSize,
          otherMainSize: customerLyricUI.otherMainSize,
          bias: customerLyricUI.bias,
          lineGap: customerLyricUI.lineGap,
          inlineGap: customerLyricUI.inlineGap,
          lyricAlign: customerLyricUI.lyricAlign,
          lyricBaseLine: customerLyricUI.lyricBaseLine,
          highlight: customerLyricUI.highlight,
          highlightDirection: customerLyricUI.highlightDirection,
        );

  @override
  TextStyle getPlayingExtTextStyle() =>
      TextStyle(color: Colors.purple[300], fontSize: defaultExtSize);

  @override
  TextStyle getOtherExtTextStyle() => TextStyle(
        color: Colors.purple[300],
        fontSize: defaultExtSize,
      );

  @override
  TextStyle getOtherMainTextStyle() =>
      TextStyle(color: Colors.black, fontSize: otherMainSize);

  @override
  TextStyle getPlayingMainTextStyle() => TextStyle(
        color: Colors.purple[300],
        fontSize: defaultSize,
      );

  @override
  double getInlineSpace() => inlineGap;

  @override
  double getLineSpace() => lineGap;

  @override
  double getPlayingLineBias() => bias;

  @override
  LyricAlign getLyricHorizontalAlign() => lyricAlign;

  @override
  LyricBaseLine getBiasBaseLine() => lyricBaseLine;

  @override
  Color getLyricHightlightColor() {
    // TODO: implement getLyricHightlightColor
    return Color(0xffb37feb);
  }

  @override
  bool enableHighlight() => highlight;

  @override
  HighlightDirection getHighlightDirection() => highlightDirection;
}
