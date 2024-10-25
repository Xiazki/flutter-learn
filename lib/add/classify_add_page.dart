import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_learn/model/classify_value.dart';
import 'package:flutter_learn/model/entity.dart';
import 'package:flutter_learn/state/data_state.dart';
import 'package:flutter_learn/util/auto_resize_image.dart';
import 'package:flutter_learn/util/data_util.dart';
import 'package:provider/provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

// ignore: must_be_immutable
class ClassifyAddPage extends StatefulWidget {
  ClassifyValue? classifyValue;

  List<Entity>? firstSelectedEntities;

  ClassifyAddPage({super.key, this.classifyValue});

  @override
  State<StatefulWidget> createState() => ClassifyAddState();
}

class ClassifyAddState extends State<ClassifyAddPage> {
  double areaFactor = 0.75;
  double buttonFactor = 0.1;

  List<Entity>? _selectedEntities;
  String? id;
  bool edit = false;

  bool loading = false;

  DateTime? startTime;
  DateTime? endTime;

  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var existed = widget.classifyValue;
    if (existed != null) {
      id = existed.id;
      _selectedEntities = existed.topEntities;
      edit = true;
      titleController.text = existed.title;
      descController.text = existed.des ?? '';
      startTime = existed.getStartDateTime();
      endTime = existed.getEndDateTime();
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descController.dispose();
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
            // mainAxisAlignment: MainAxisAlignment.start, // 确保主轴对齐方式正确
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * areaFactor,
                child: Column(
                  children: [
                    _buildSelectedItem(_selectedEntities),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      child: _buildTitleItem(),
                    ),
                    const Divider(
                      height: 1,
                      thickness: 0.2,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      child: _buildContentItem(),
                    ),
                    const Divider(
                      height: 0.1,
                      thickness: 0.2,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      child: _buildTimeItem(),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * buttonFactor,
                child: _buildCreate(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveOrUpdate(DataState dataState) async {
    if (loading) {
      return;
    }
    var title = titleController.text;
    var desc = descController.text;
    if (title == '') {
      showCreateAlertDialog("😲标题不能为空");
      return;
    }
    if (_selectedEntities == null || _selectedEntities!.isEmpty) {
      showCreateAlertDialog("😲请选择几张图片吧");
      return;
    }

    var imageUrl = _selectedEntities![0].url;

    ClassifyValue classify = ClassifyValue(edit ? id! : DataUtil.genUid(), title, imageUrl: imageUrl, des: desc);
    classify.imageCount = _selectedEntities?.length ?? 0;
    classify.topEntities = _selectedEntities;

    classify.startTime = startTime?.toIso8601String();
    classify.endTime = endTime?.toIso8601String();

    setState(() {
      loading = true;
    });
    try {
      if (edit) {
        await dataState.editClassify(classify);
      } else {
        await dataState.addClassify(classify);
      }

      setState(() {
        loading = false;
      });
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } catch (e) {
      showCreateAlertDialog("❗️出现错误");
      setState(() {
        loading = false;
      });
    }
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
                  onPressed: () {
                    saveOrUpdate(dataState);
                  },
                  child: Text(edit ? "修改相册" : "创建相册")),
            )));
  }

  Future<void> selectStartDateTime() async {
    var selectRange = await showDateRangePicker(context: context, firstDate: DateTime(2010), lastDate: DateTime(2200));
    setState(() {
      startTime = selectRange?.start;
      endTime = selectRange?.end;
    });
  }

  Widget _buildTimeItem() {
    List<Widget> list = [
      const Icon(
        Icons.calendar_month,
        color: Colors.green,
        size: 20,
      ),
      const SizedBox(width: 4.0),
    ];
    String text = "选择时间范围";
    if (startTime != null && endTime != null) {
      text = '${startTime!.year}年${startTime!.month}月${startTime!.day}日 - ${endTime!.year}年${endTime!.month}月${endTime!.day}日';
    }

    list.add(TextButton(
        onPressed: () {
          selectStartDateTime();
        },
        child: Text(text)));

    return Row(
        mainAxisAlignment: MainAxisAlignment.start, // 左对齐
        children: list);
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

  Widget _buildTitleItem() {
    return SizedBox(
      height: 50,
      child: TextField(
        controller: titleController,
        decoration: const InputDecoration(hintText: "请写一个标题（少于15个字）", border: InputBorder.none, hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
      ),
    );
  }

  Widget _buildContentItem() {
    return SizedBox(
      height: 200,
      child: TextField(
        controller: descController,
        maxLines: 200,
        decoration: const InputDecoration(hintText: "添加正文，说一些你想说的话吧", border: InputBorder.none, hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
      ),
    );
  }

  Widget _buildSelectedItem(List<Entity>? entities) {
    List<Widget> list = [];
    var addItemButton = SizedBox(
      width: 200,
      height: 200,
      child: GestureDetector(
          onTap: selectAssets,
          child: const Card(
            // color: Colors.grey,
            margin: EdgeInsets.all(4.0),
            child: Icon(
              Icons.add_photo_alternate,
              color: Colors.green,
              size: 40,
            ),
          )),
    );
    if (entities == null) {
      list.add(addItemButton);
    } else {
      for (var item in entities) {
        list.add(SizedBox(
            width: 200,
            height: 200,
            child: Stack(
              children: [
                LayoutBuilder(builder: (BuildContext context, BoxConstraints constructors) {
                  return Container(
                    margin: const EdgeInsets.all(2.0),
                    // elevation: 5,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AutoResizeImage(
                                imageProvider: FileImage(File.fromRawPath(utf8.encode(item.url))),
                                width: constructors.maxWidth,
                                height: constructors.maxHeight))),
                  );
                }),
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: IconButton(
                      padding: const EdgeInsets.all(1),
                      onPressed: () {
                        delete(item);
                      },
                      style: const ButtonStyle(
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
            )));
      }
      if (entities.length < 9) {
        list.add(addItemButton);
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: list,
      ),
    );
  }

  void delete(Entity entity) {
    setState(() {
      if (_selectedEntities != null) {
        _selectedEntities!.remove(entity);
      }
    });
  }

  Future<void> selectAssets() async {
    int limit = 9;
    if (_selectedEntities != null) {
      int c = _selectedEntities!.length;
      limit = limit - c;
    }
    if (limit <= 0) {
      return;
    }
    List<AssetEntity>? result = await AssetPicker.pickAssets(context,
        permissionRequestOption: const PermissionRequestOption(
            androidPermission: AndroidPermission(
          type: RequestType.common,
          mediaLocation: true,
        )),
        pickerConfig: AssetPickerConfig(textDelegate: const AssetPickerTextDelegate(), maxAssets: limit, requestType: RequestType.image));
    if (result != null) {
      var assets = Set<AssetEntity>.from(result);
      List<Entity> selectValues = [];
      for (var asset in assets) {
        File? file = await asset.file;
        if (file != null) {
          selectValues.add(Entity(DataUtil.genUid(), file.path, Entity.IMAGE));
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
}
