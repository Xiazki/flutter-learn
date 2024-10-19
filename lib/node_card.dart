import 'package:flutter/material.dart';
import 'package:flutter_learn/add/travel_node_add.dart';
import 'package:flutter_learn/model/entity.dart';
import 'package:flutter_learn/model/node_value.dart';
import 'package:flutter_learn/state/data_state.dart';
import 'package:flutter_learn/unit/grid_media.dart';
import 'package:flutter_learn/unit/media_view.dart';
import 'package:flutter_learn/util/data_util.dart';
import 'package:flutter_learn/util/default.dart';
import 'package:interactiveviewer_gallery/hero_dialog_route.dart';
import 'package:interactiveviewer_gallery/interactiveviewer_gallery.dart';
import 'package:provider/provider.dart';

//旅游节点卡片
// ignore: must_be_immutable
class NodeCard extends StatefulWidget {
  NodeValue nodeValue;
  List<NodeValue> allNodeValue;
  int indexOfNode;

  NodeCard({super.key, required this.nodeValue, required this.allNodeValue, required this.indexOfNode});

  @override
  State<StatefulWidget> createState() => _NodeCardState();
}

class _NodeCardState extends State<NodeCard> {
  late List<Entity> _allEntityValue;
  late List<NodeValue> _allNodeValue;

  @override
  void initState() {
    super.initState();
    _allEntityValue = DataUtil.getAllEntities(widget.allNodeValue);
    _allNodeValue = widget.allNodeValue;
  }

  @override
  Widget build(BuildContext context) {
    var nodeValue = widget.nodeValue;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start, // 确保主轴对齐方式正确
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 10.0),
          child: Column(
            children: [
              // Container(
              //   constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8), // 限制宽度为屏幕宽度的80%
              //   child: Text(
              //     widget.nodeValue.desc,
              //     // overflow: TextOverflow.ellipsis,
              //     softWrap: true,
              //   ),
              // ),
              Text(widget.nodeValue.desc),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [buildActions(context)],
              ),
              // Align(
              //   alignment: Alignment.bottomRight,
              //   child: buildActions(context),
              // )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 10.0),
          child: GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(widget.nodeValue.entities.length, (index) {
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
            NodeValue? nodeValue = DataUtil.getNodeValueByEntity(_allNodeValue, entity);
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

  Widget buildActions(BuildContext context) {
    return Consumer<DataState>(
      builder: (context, dataState, child) {
        return SizedBox(
          width: 30,
          height: 20,
          child: IconButton(
            padding: const EdgeInsets.all(1),
            onPressed: () {
              var position = DefaultUtil.calPosition(context);
              showMenu<String>(context: context, position: position, items: [
                const PopupMenuItem(
                  value: "edit",
                  child: Text("编辑"),
                ),
                const PopupMenuItem(
                  value: "delete",
                  child: Text("删除"),
                )
              ]).then((value) {
                if (value == 'delete') {
                  showDialog(
                    // ignore: use_build_context_synchronously
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          "❗️是否要删除节点",
                          style: TextStyle(fontSize: 20),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // 关闭对话框
                            },
                            child: const Text(
                              '取消',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // 这里可以添加确认操作的逻辑
                              dataState.deleteNode(widget.nodeValue.classifyId, widget.nodeValue).then(
                                (value) {
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pop(); // 关闭对话框
                                },
                              );
                            },
                            child: const Text(
                              '确认删除',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else if (value == 'edit') {
                  Navigator.push(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                          builder: (context) => TravelNodeAdd(
                                classifyId: widget.nodeValue.classifyId,
                                nodeValue: widget.nodeValue,
                              )));
                }
              });
            },
            icon: const Icon(
              Icons.more_horiz,
              size: 18,
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
