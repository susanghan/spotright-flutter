import 'package:flutter/material.dart';

class SrGridView extends StatelessWidget {
  SrGridView({Key? key, required this.children}) : super(key: key);

  List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _Items(),
    );
  }

  List<Row> _Items() {
    List<Row> result = [];

    for (int i = 0; i < children.length; i += 2) {
      var row = Row(
        children: [
          Flexible(child: children[i]),
          Flexible(
              child: i + 1 < children.length ? children[i + 1] : const SizedBox.shrink()
          )
        ],
      );

      result.add(row);
    }

    return result;
  }
}
