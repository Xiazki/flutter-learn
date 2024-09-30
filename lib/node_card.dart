import 'package:flutter/material.dart';
import 'package:flutter_learn/model/entity.dart';
import 'package:flutter_learn/model/node_value.dart';
import 'package:flutter_learn/util/auto_resize_image.dart';
import 'package:flutter_learn/util/data_util.dart';
import 'package:interactiveviewer_gallery/hero_dialog_route.dart';
import 'package:interactiveviewer_gallery/interactiveviewer_gallery.dart';

//旅游节点卡片
class NodeCard extends StatefulWidget {
  NodeValue nodeValue;
  List<NodeValue> allNodeValue;
  int indexOfNode;

  NodeCard({super.key, required this.nodeValue,required this.allNodeValue,required this.indexOfNode});

  @override
  State<StatefulWidget> createState() => _NodeCardState();
}

class _NodeCardState extends State<NodeCard> {

  late List<Entity> _allEntityValue;

  @override
  void initState() {
    _allEntityValue = DataUtil.getAllEntities(widget.allNodeValue);
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
          margin: const EdgeInsets.all(2.0),
          child: Image(
              fit: BoxFit.cover,
              image: AutoResizeImage(
                  imageProvider: AssetImage(entity.url),
                  width: constructors.maxWidth,
                  height: constructors.maxHeight)),
        );
      });
    } else {
      return Card(
        margin: const EdgeInsets.all(2.0),
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          alignment: AlignmentDirectional.center,
          children: [
            LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constructors) {
              return Image(
                  fit: BoxFit.cover,
                  image: AutoResizeImage(
                      imageProvider: AssetImage(entity.url),
                      width: constructors.maxWidth,
                      height: constructors.maxHeight)
                      );
            }),
            Container(
              alignment: Alignment.center,
              child:
                  Icon(Icons.play_circle, color: Colors.white.withOpacity(0.8)),
            ), 
            Container(
              alignment: Alignment.bottomRight,
              child:
                  Text("1:20",style: TextStyle(color: Colors.white.withOpacity(0.8),fontSize: 12),),
            )
          ],
        ),
      );
    }
  }

  // todo 图片&视频preview


  //   void _openGallery(Entity source,int index) {
  //   Navigator.of(context).push(
  //     HeroDialogRoute<void>(
  //       // DisplayGesture is just debug, please remove it when use
  //       builder: (BuildContext context) => DisplayGesture(
  //         child: InteractiveviewerGallery<Entity>(
  //           sources: _allEntityValue,
  //           initIndex: sourceList.indexOf(source),
  //           itemBuilder: itemBuilder,
  //           onPageChanged: (int pageIndex) {
  //             print("nell-pageIndex:$pageIndex");
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }

}
