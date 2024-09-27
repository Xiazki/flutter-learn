import 'package:flutter/material.dart';
import 'package:flutter_learn/model/node_value.dart';
import 'package:flutter_learn/util/auto_resize_image.dart';

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
                  return LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constructors) {
                    return Image(
                        fit: BoxFit.cover,
                        image: AutoResizeImage(
                            imageProvider:
                                AssetImage(nodeValue.entities[index].url),
                            width: constructors.maxWidth,
                            height: constructors.maxHeight));
                  });
                })),
          ),
        ],
      ),
    );
  }
}
