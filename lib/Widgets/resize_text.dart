import 'package:flutter/material.dart';

class CroppedText extends StatelessWidget {
  final String text;
  final TextStyle theme;
  final TextAlign textAlign;

  CroppedText({this.text, this.theme, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      style: theme,
    );
  }
}

class ResizePyramidText extends StatelessWidget {
  final String text;
  final TextStyle theme;
  final TextAlign textAlign;

  ResizePyramidText({this.text, this.theme, this.textAlign});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Text(
      text,
      textAlign: textAlign,
      style: getResizePyramidThemeText(text, size, theme),
    );
  }
}

getResizePyramidThemeText(text, size, theme) {
  double fontSize = 18;
  if (text.length > 3 && text.length <= 5) {
    fontSize = size * (text.length / 20);
  } else if (text.length > 5 && text.length <= 10) {
    fontSize = size * (text.length / 150);
  } else if (text.length > 10 && text.length <= 20) {
    fontSize = size * (text.length / 450);
  }  else {
    fontSize = size * (text.length / 550);
  }

  if(fontSize > theme.fontSize){
    fontSize = theme.fontSize;
  }

  return TextStyle(
      fontSize: fontSize,
      fontFamily: theme.fontFamily,
      fontWeight: theme.fontWeight,
      color: theme.color);
}

class ResizeText extends StatelessWidget {
  final String text;
  final TextStyle theme;
  final TextAlign textAlign;

  ResizeText({this.text, this.theme, this.textAlign});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Text(
      text,
      textAlign: textAlign,
      style: getThemeText(text, size, theme),
    );
  }
}

getThemeText(text, size, theme) {
  double fontSize = 18;
  if (text.length > 3 && text.length <= 5) {
    fontSize = size * (text.length / 20);
  } else if (text.length > 5 && text.length <= 10) {
    fontSize = size * (text.length / 125);
  } else if (text.length > 10 && text.length <= 20) {
    fontSize = size * (text.length / 250);
  } else if (text.length > 20 && text.length <= 40) {
    fontSize = size * (text.length / 900);
  } else {
    fontSize = size * (text.length / 1250);
  }

  if(fontSize > theme.fontSize*2){
    fontSize = theme.fontSize*2;
  }
  
  return TextStyle(
      fontSize: fontSize,
      fontFamily: theme.fontFamily,
      fontWeight: theme.fontWeight,
      color: theme.color);
}

class ResizeTitleText extends StatelessWidget {
  final String text;
  final TextStyle theme;

  ResizeTitleText({this.text, this.theme});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Text(
      text,
      style: getThemeTitleText(text, size, theme),
    );
  }
}

getThemeTitleText(text, size, theme) {
  double fontSize = 18;
  if (text.length > 3 && text.length <= 5) {
    fontSize = size * (text.length / 50);
  } else if (text.length > 5 && text.length < 8) {
    fontSize = size * (text.length / 75);
  } else if (text.length >= 8 && text.length <= 12) {
    fontSize = size * (text.length / 130);
  } else if (text.length > 12 && text.length <= 40) {
    fontSize = size * (text.length / 200);
  } else {
    fontSize = size * (text.length / 250);
  }

  if(fontSize > theme.fontSize || fontSize < theme.fontSize/2) {
    fontSize = theme.fontSize;
  }

  return TextStyle(
      fontSize: fontSize,
      fontFamily: theme.fontFamily,
      fontWeight: theme.fontWeight,
      color: theme.color);
}

class ResizeTableText extends StatelessWidget {
  final String text;
  final TextStyle theme;
  final TextAlign textAlign;

  ResizeTableText({this.text, this.theme, this.textAlign});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Text(
      text,
      style: getThemeTableText(text, size, theme),
      textAlign: textAlign,
    );
  }
}

getThemeTableText(text, size, theme) {
  double fontSize = 18;
  if (text.length > 3 && text.length <= 6) {
    fontSize = size * (text.length / 100);
  } else if (text.length > 6 && text.length <= 10) {
    fontSize = size * (text.length / 200);
  } else if (text.length > 10 && text.length <= 15) {
    fontSize = size * (text.length / 330);
  } else {
    fontSize = size * (text.length / 600);
  }

  if(fontSize > theme.fontSize || fontSize < theme.fontSize/2) {
    fontSize = theme.fontSize;
  }

  return TextStyle(
      fontSize: fontSize,
      fontFamily: theme.fontFamily,
      fontWeight: theme.fontWeight,
      color: theme.color);
}
