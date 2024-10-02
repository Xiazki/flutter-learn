import 'package:flutter/material.dart';
import 'package:flutter_learn/model/entity.dart';
import 'package:flutter_learn/model/node_value.dart';
import 'package:flutter_learn/unit/grid_media.dart';
import 'package:flutter_learn/unit/media_view.dart';
import 'package:flutter_learn/util/data_util.dart';
import 'package:interactiveviewer_gallery/hero_dialog_route.dart';
import 'package:interactiveviewer_gallery/interactiveviewer_gallery.dart';

//旅游节点卡片
class NodeCard extends StatefulWidget {
  NodeValue nodeValue;
  List<NodeValue> allNodeValue;
  int indexOfNode;

  NodeCard(
      {super.key,
      required this.nodeValue,
      required this.allNodeValue,
      required this.indexOfNode});

  @override
  State<StatefulWidget> createState() => _NodeCardState();
}

class _NodeCardState extends State<NodeCard> {
  late List<Entity> _allEntityValue;
  late List<NodeValue> _allNodeValue;
  late int _indexOfNode;

  @override
  void initState() {
    _allEntityValue = DataUtil.getAllEntities(widget.allNodeValue);
    _allNodeValue = widget.allNodeValue;
    _indexOfNode = widget.indexOfNode;
  }

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
                var entity = nodeValue.entities[index];
                return _buildItem(entity, index);
              })),
        ),
      ],
    );
  }

  Widget _buildItem(Entity entity, int indexOfEntity) {
    return Hero(
        tag: entity.id,
        child: GestureDetector(
          onTap: () => _openGallery(entity, indexOfEntity),
          child: GridMedia(entity: entity),
        ));
  }
  // todo 图片&视频preview

  void _openGallery(Entity entity, int indexOfEntity) {
    int current = DataUtil.indexOfAll(_allEntityValue, entity);
    Navigator.of(context).push(
      HeroDialogRoute<void>(
        // DisplayGesture is just debug, please remove it when use
        builder: (BuildContext context) => InteractiveviewerGallery<Entity>(
          sources: _allEntityValue,
          initIndex: current,
          itemBuilder: (context, index, isFocus) {
            var entity = _allEntityValue[index];
            NodeValue? nodeValue =
                DataUtil.getNodeValueByEntity(_allNodeValue, entity);
            if (entity.type == Entity.IMAGE) {
              return ImageView(entity, nodeValue == null ? "" : nodeValue.desc);
            } else {
              return FlickVideoView(
                entity: entity,
              );
              // return VideoView(entity);
            }
          },
          onPageChanged: (int pageIndex) {
            // print("nell-pageIndex:$pageIndex");
          },
        ),
      ),
    );
  }
}
