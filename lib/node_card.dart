import 'package:flutter/material.dart';
import 'package:flutter_learn/model/entity.dart';
import 'package:flutter_learn/model/node_value.dart';
import 'package:flutter_learn/util/auto_resize_image.dart';

//旅游节点卡片
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start, // 确保主轴对齐方式正确
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 2.0, 10.0, 10.0),
          child: Text(widget.nodeValue.desc),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 2.0, 10.0, 10.0),
          child: GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children:
                  List.generate(widget.nodeValue.entities.length, (index) {
                return _getItem(nodeValue.entities[index]);
              })),
        ),
      ],
    );
  }

  Widget _getItem(Entity entity) {
    if (entity.type == Entity.IMAGE) {
      return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constructors) {
        return Card(
          child: Image(
              fit: BoxFit.cover,
              image: AutoResizeImage(
                  imageProvider: AssetImage(entity.url),
                  width: constructors.maxWidth,
                  height: constructors.maxHeight)),
        );
      });
    } else {
      return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constructors) {
        return Card(
          child: Stack(
            children: [
              Image(
                  fit: BoxFit.cover,
                  image: AutoResizeImage(
                      imageProvider: AssetImage(entity.url),
                      width: constructors.maxWidth,
                      height: constructors.maxHeight)),
              Container(
                alignment: Alignment.center,
                child: Icon(Icons.play_circle, color: Colors.grey.withOpacity(0.5)),
              )
            ],
          ),
        );
      });
    }
  }
}
