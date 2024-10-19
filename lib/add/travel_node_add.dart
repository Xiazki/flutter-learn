import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_learn/model/entity.dart';
import 'package:flutter_learn/model/node_value.dart';
import 'package:flutter_learn/state/data_state.dart';
import 'package:flutter_learn/unit/grid_media.dart';
import 'package:flutter_learn/util/data_util.dart';
import 'package:flutter_learn/util/default.dart';
import 'package:provider/provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

// ignore: must_be_immutable
class TravelNodeAdd extends StatefulWidget {
  TravelNodeAdd({super.key, required this.classifyId, this.nodeValue});

  NodeValue? nodeValue;

  String classifyId;

  @override
  State<StatefulWidget> createState() => TravelNodeAddState();
}

class TravelNodeAddState extends State<TravelNodeAdd> {
  NodeValue? nodeValue;

  List<Entity>? _selectedEntities;

  double areaFactor = 0.75;
  double buttonFactor = 0.1;

  final descController = TextEditingController();

  String? id;
  bool edit = false;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    nodeValue = widget.nodeValue;
    if (nodeValue != null) {
      descController.text = nodeValue!.desc;
      _selectedEntities = nodeValue!.entities;
      id = nodeValue!.id;
      edit = true;
    }
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
                      // _buildLocationItem()
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
            child: Consumer<DataState>(
              builder: (context, dataState, child) => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(400, 50),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
                  onPressed: loading
                      ? null
                      : () {
                          saveOrUpdate(dataState);
                        },
                  child: Text(edit ? "编辑时光节点" : "创建时光节点")),
            )));
  }

  void showCreateAlertDialog(String text) {
    showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(text),
          );
        });
  }

  Future<void> saveOrUpdate(DataState dataState) async {
    if (loading) {
      return;
    }
    var optId = edit ? this.id : DataUtil.genUid();
    if (_selectedEntities == null) {
      showCreateAlertDialog("请选择图片或者视频");
      return;
    }
    if (descController.text.isEmpty) {
      showCreateAlertDialog("请写一段关于这些时光的话吧");
      return;
    }
    NodeValue saveNode = NodeValue(optId!, widget.classifyId, _selectedEntities!, descController.text);

    setState(() {
      loading = true;
    });
    try {
      if (edit) {
        await dataState.updateNode(widget.classifyId, saveNode);
      } else {
        await dataState.addNode(widget.classifyId, saveNode);
      }
      setState(() {
        loading = false;
      });
      Navigator.pop(context);
    } catch (e) {
      showCreateAlertDialog("保存失败${e}");
      setState(() {
        loading = true;
      });
    }
  }

  Widget _buildSelectedItem() {
    List<Widget> body = [];
    Widget addItem = GestureDetector(
      onTap: () {
        selectAssets();
      },
      child: const Card(
          // elevation: 5,
          margin: EdgeInsets.all(2.0),
          // color: Colors.grey,
          child: Icon(
            Icons.add_photo_alternate,
            color: Colors.green,
          )),
    );
    if (_selectedEntities != null) {
      int count = _selectedEntities!.length;
      body = List.generate(count, (index) {
        var item = _selectedEntities![index];
        return Stack(
          fit: StackFit.expand,
          children: [
            GridMedia(entity: item),
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                height: 15,
                width: 15,
                child: IconButton(
                  padding: const EdgeInsets.all(1),
                  onPressed: () {
                    delete(item);
                  },
                  style: const ButtonStyle(
                    // alignment: Alignment.topLeft,
                    backgroundColor: WidgetStatePropertyAll(Colors.red),
                  ),
                  icon: const Icon(
                    Icons.close,
                  ),
                  iconSize: 12,
                ),
              ),
            )
          ],
        );
      });
    }
    body.add(addItem);

    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 2.0, 10.0, 10.0),
      child: GridView.count(crossAxisCount: 4, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), children: body),
    );
  }

  Widget _buildContentItem() {
    return SizedBox(
      height: 200,
      child: TextField(
        controller: descController,
        maxLines: 100,
        decoration: const InputDecoration(hintText: "添加正文，说一些你想说的话吧", border: InputBorder.none, hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
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

  Future<void> selectAssets() async {
    int limit = 50;
    if (_selectedEntities != null) {
      int c = _selectedEntities!.length;
      limit = limit - c;
    }
    if (limit <= 0) {
      return;
    }
    List<AssetEntity>? result = await AssetPicker.pickAssets(context,
        pickerConfig: AssetPickerConfig(
          textDelegate: const AssetPickerTextDelegate(),
          maxAssets: limit,
        ));
    if (result != null) {
      var assets = Set<AssetEntity>.from(result);
      List<Entity> selectValues = [];
      for (var asset in assets) {
        File? file = await asset.file;
        if (file != null) {
          if (asset.type == AssetType.image) {
            var vlaue = Entity(DataUtil.genUid(), file.path, Entity.IMAGE);
            vlaue.crateTime = asset.createDateTime;
            vlaue.lat = asset.latitude;
            vlaue.long = asset.longitude;
            selectValues.add(vlaue);
          } else if (asset.type == AssetType.video) {
            // asset.
            var value = Entity(DataUtil.genUid(), file.path, Entity.VIDEO);
            value.videUrl = file.path;
            // VideoPlayerController.

            // 使用video_player插件来获取视频的元数据
            Duration duration = asset.videoDuration;
            var thumbnail = await asset.thumbnailData;
            value.duration = duration;
            value.thumbnailData = thumbnail;
            selectValues.add(value);
          }
        }
      }
      setState(() {
        if (_selectedEntities == null) {
          _selectedEntities = selectValues;
        } else {
          _selectedEntities!.addAll(selectValues);
        }
      });
    }
  }

  void delete(Entity entity) {
    setState(() {
      if (_selectedEntities != null) {
        _selectedEntities!.remove(entity);
      }
    });
  }
}
