import 'package:flutter/material.dart';

typedef OnItemClick = void Function(int type);

class MyListTitle extends StatelessWidget {
  const MyListTitle({
    Key? key,
    this.leading = Icons.ac_unit,
    required this.title,
    this.trailingIcon = Icons.chevron_right,
    this.trailingTitle = '',
    required this.onTap, required this.type,
  }) : super(key: key);

  final int type;
  final IconData leading;
  final String title;
  final IconData trailingIcon;
  final String trailingTitle;
  final OnItemClick onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap(type),
      leading: Icon(
        leading,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(title),
      trailing: SizedBox(
        width: 120,
        height: double.infinity,
        child: Center(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  trailingTitle,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              Icon(trailingIcon),
            ],
          ),
        ),
      ),
    );
  }
}
