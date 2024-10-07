import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/model/classify_value.dart';
import 'package:flutter_learn/model/entity.dart';
import 'package:flutter_learn/unit/media_view.dart';
import 'package:flutter_learn/util/auto_resize_image.dart';
import 'package:flutter_learn/util/data_util.dart';
import 'package:interactiveviewer_gallery/hero_dialog_route.dart';
import 'package:interactiveviewer_gallery/interactiveviewer_gallery.dart';

// ignore: must_be_immutable
class TopNodeCard extends StatefulWidget {
  ClassifyValue classifyValue;

  TopNodeCard({super.key, required this.classifyValue});

  @override
  State<StatefulWidget> createState() => _TopCardState();
}

class _TopCardState extends State<TopNodeCard> {
  late ClassifyValue stateValue;

  @override
  void initState() {
    super.initState();
    stateValue = widget.classifyValue;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [
      Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
        child: Text(
          stateValue.title ?? "",
          style: const TextStyle(fontSize: 30),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
        child: Text(
          "${stateValue.startTime ?? ""}-${stateValue.endTime ?? ""}",
          style: const TextStyle(color: Colors.grey),
        ),
      ),
    ];
    if (stateValue.topEntities != null) {
      list.add(SizedBox(
          child: CarouselSlider(
        options:
            CarouselOptions(autoPlay: true, aspectRatio: 1, disableCenter: true
                // enlargeCenterPage: true,
                ),
        items: _imageItems(),
      )));
    }
    list.add(Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 16.0, 5.0, 10.0),
      child: Text(
        stateValue.des ?? "",
      ),
    ));
    return Column(
      mainAxisAlignment: MainAxisAlignment.start, // 确保主轴对齐方式正确
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }

  List<Widget> _imageItems() {
    var list = stateValue.topEntities!;
    return list.map((entity) {
      return Container(
        margin: const EdgeInsets.all(5.0),
        child:GestureDetector(
          onTap: ()=>_openGallery(entity),
          child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constructors) {
            return Image(
                fit: BoxFit.cover,
                image: AutoResizeImage(
                    imageProvider: AssetImage(entity.url),
                    width: constructors.maxWidth,
                    height: constructors.maxHeight));
          }),
        ),
        ) ,
      );
    }).toList();
  }

  void _openGallery(Entity entity) {
    int index = DataUtil.indexOfAll(stateValue.topEntities!, entity);
    Navigator.of(context).push(
      HeroDialogRoute<void>(
        // DisplayGesture is just debug, please remove it when use
        builder: (BuildContext context) => InteractiveviewerGallery<Entity>(
          sources: stateValue.topEntities!,
          initIndex: index,
          itemBuilder: (context, index, isFocus) {
            var entity = stateValue.topEntities![index];
            return ImageView(entity, "");
          },
          onPageChanged: (int pageIndex) {
            // print("nell-pageIndex:$pageIndex");
          },
        ),
      ),
    );
  }
}
