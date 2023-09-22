import 'package:flutter/material.dart';

class MyDropdownMenu extends StatelessWidget {
  final List<String> items;
  final String selectedItem;
  final ValueChanged<String?> onChanged;

  MyDropdownMenu({
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
  }
}

class MyDrawerMenu extends StatelessWidget {
  final List<String> items;
  final ValueChanged<String?> onChanged;

  MyDrawerMenu({
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: items.map((String item) {
          return ListTile(
            title: Text(item),
            onTap: () {
              onChanged(item);
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }
}
