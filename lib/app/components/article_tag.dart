import 'package:flutter/material.dart';

class ArticleTag extends StatelessWidget {
  final String text;
  final Color? color;

  const ArticleTag(this.text, {this.color});

  @override
  Widget build(BuildContext context) {
    var themeColor = color ?? Theme.of(context).colorScheme.secondary;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 3,
        vertical: 0.5,
      ),
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: color ?? themeColor)),
      child: Text(text,
          style: TextStyle(color: color ?? themeColor, fontSize: 10)),
    );
  }
}
