
import 'package:flutter/material.dart';
import 'package:flutter_learn/model/node_value.dart';
import 'package:flutter_learn/unit/grid_media.dart';
import 'package:flutter_learn/util/data_util.dart';
import 'package:flutter_learn/util/default.dart';

class TravelNodeAdd extends StatefulWidget {
  const TravelNodeAdd({super.key});

  @override
  State<StatefulWidget> createState() => TravelNodeAddState();
}

class TravelNodeAddState extends State<TravelNodeAdd> {
  // List<Entity>? _entities;

  NodeValue? nodeValue;

  double areaFactor = 0.75;
  double buttonFactor = 0.1;

  @override
  void initState() {
    nodeValue = DataUtil.getNodeValueByClassify("key").first;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
          onPressed: () {
            // 当点击返回按钮时触发的动作
            // 导航回到上一个页面
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * areaFactor,
                  child: Column(
                    children: [
                      _buildContentItem(),
                      DefaultUtil.divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      _buildSelectedItem(),
                      DefaultUtil.divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      _buildLocationItem()
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * buttonFactor,
                  child: _buildCreate(),
                )
              ],
            ),
          )),
    );
  }

  Widget _buildCreate() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(400, 50),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0))),
                onPressed: () {},
                child: const Text("添加一个节点"))));
  }

  Widget _buildSelectedItem() {
    List<Widget> body = [];
    Widget addItem = GestureDetector(
      onTap: () {
        //todo
      },
      child: const Card(
        // elevation: 5,
        
          margin: EdgeInsets.all(2.0),
          // color: Colors.grey,
          child: Icon(
            Icons.add_photo_alternate,
            color: Colors.grey,
          )),
    );
    if (nodeValue != null) {
      int count = nodeValue!.entities.length;
      body = List.generate(count, (index) {
        return GridMedia(entity: nodeValue!.entities[index]);
      });
    }
    body.add(addItem);

    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 2.0, 10.0, 10.0),
      child: GridView.count(
          crossAxisCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: body),
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

  Widget _buildLocationItem() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {},
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start, // 左对齐
            children: [
              Icon(
                Icons.location_pin,
                color: Colors.red,
                size: 20,
              ),
              SizedBox(width: 4.0),
              Text('添加地点'),
            ],
          ),
        )
      ],
    );
  }
}
