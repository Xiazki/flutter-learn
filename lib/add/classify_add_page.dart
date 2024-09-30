import 'package:flutter/material.dart';
import 'package:flutter_learn/model/entity.dart';

class ClassifyAddPage extends StatefulWidget {
  List<Entity>? firstSelectedEntities;

  ClassifyAddPage({super.key});

  @override
  State<StatefulWidget> createState() => ClassifyAddState();
}

class ClassifyAddState extends State<ClassifyAddPage> {
  List<Entity>? _selectedEntities;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start, // 确保主轴对齐方式正确
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSelectedItem(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  child: _buildTitleItem(),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  child: _buildContentItem(),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  child: _buildLocationItem(),
                ),
              ],
            ),
            Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(500, 50),
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0))),
                        onPressed: () {},
                        child: const Text("创建分类"))))
          ],
        ),
      ),
    );
  }

  Widget _buildLocationItem() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {},
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start, // 左对齐
            children: [
              Icon(Icons.location_pin,color: Colors.red,size: 20,),
              SizedBox(width: 4.0),
              Text('添加地点'),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildTitleItem() {
    return const SizedBox(
      height: 50,
      child: TextField(
        decoration: InputDecoration(
            hintText: "请写一个标题（少于15个字）",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
      ),
    );
  }

  Widget _buildContentItem() {
    return const SizedBox(
      height: 200,
      child: TextField(
        maxLines: 100,
        decoration: InputDecoration(
            hintText: "添加正文，说一些你想说的话吧",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
      ),
    );
  }

  Widget _buildSelectedItem() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(8, (index) {
          return SizedBox(
            width: 200,
            height: 200,
            child: Card(
              margin: const EdgeInsets.all(4.0),
              child: Text("$index"),
            ),
          );
        }),
      ),
    );
    // return GridView.builder(
    //     itemCount: 9,
    //     shrinkWrap: true,
    //     gridDelegate:
    //         SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
    //     itemBuilder: (context, index) {
    //       return SizedBox(
    //         width: 200,
    //         height: 400,
    //         child: Card(
    //           margin: const EdgeInsets.all(4.0),
    //           child: Text("$index"),
    //         ),
    //       );
    //     });
  }
}
