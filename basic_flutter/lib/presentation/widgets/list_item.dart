import 'package:flutter/material.dart';

import '/data/dummy_class.dart';

class ListItem extends StatelessWidget {
  const ListItem(
      {Key? key, required this.index, required this.switchToEmployeePage})
      : super(key: key);

  final int index;
  final Function switchToEmployeePage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          switchToEmployeePage(context);
        },
        child: Card(
          elevation: 10,
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "${DummyClass.dummyList[index].firstName} ${DummyClass.dummyList[index].lastName}",
                  style: Theme.of(context).textTheme.headline6),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                DummyClass.dummyList[index].email,
                style: const TextStyle(
                    fontFamily: "Raleway-ExtraBold", fontSize: 16),
                softWrap: true,
              ),
            ),
            trailing: TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.delete_forever),
                label: const Text("Delete"),
                style: TextButton.styleFrom(
                    primary: Theme.of(context).errorColor)),
          ),
        ));
  }
}
