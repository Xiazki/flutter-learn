import 'package:flutter/material.dart';
import 'package:flutter_learn/model/node_value.dart';

class NodeCard extends StatefulWidget {
  NodeValue nodeValue;

  NodeCard({super.key, required this.nodeValue});

  @override
  State<StatefulWidget> createState() => _NodeCardState();
}

class _NodeCardState extends State<NodeCard> {
  @override
  Widget build(BuildContext context) {
    var nodeValue = widget.nodeValue;
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 10.0),
            child: Text(widget.nodeValue.desc),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 10.0),
            child: GridView.count(
                crossAxisCount: 4,
                children:
                    List.generate(widget.nodeValue.entities.length, (index) {
                  return Image.asset(nodeValue.entities[index].url);
                })),
          ),
        ],
      ),
    );
  }
}
