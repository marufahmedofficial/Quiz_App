import 'package:flutter/material.dart';

import '../temp_db.dart';

class ListItem extends StatelessWidget {
  final int index;
  const ListItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: index.isEven?Colors.grey:Colors.greenAccent,
      subtitle: Text(items[index]),
      title: Text('Item $index'),);
  }
}
