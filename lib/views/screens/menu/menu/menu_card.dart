import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final Widget? page;
  final Color iconColor;

  MenuItem(this.title, this.icon, this.page, this.iconColor);
}

class MenuItemCard extends StatelessWidget {
  final MenuItem item;

  const MenuItemCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            item.icon,
            size: 100.0,
            color: item.iconColor,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              item.title,
              style: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}