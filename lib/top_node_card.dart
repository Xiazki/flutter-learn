import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/model/classify_value.dart';
import 'package:flutter_learn/util/auto_resize_image.dart';

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
    stateValue = widget.classifyValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start, // 确保主轴对齐方式正确
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        SizedBox(
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 1,
                disableCenter: true
                // enlargeCenterPage: true,
              ),
              items: _imageItems(),
            )),
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 16.0, 5.0, 10.0),
          child: Text(
            stateValue.des ?? "",
          ),
        )
      ],
    );
  }

  List<Widget> _imageItems() {
    var list = stateValue.topEntities!;
    return list.map((entity) {
      return Container(
        margin: const EdgeInsets.all(5.0),
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
      );
    }).toList();
  }
}
