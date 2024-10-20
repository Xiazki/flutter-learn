// import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/util/default.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<StatefulWidget> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  // AMapController? _mapController;

  @override
  Widget build(BuildContext context) {
    ///使用默认属性创建一个地图
    // final AMapWidget map = AMapWidget(
    //   apiKey: DefaultUtil.amapApiKeys,
    //   onMapCreated: onMapCreated,
    //   privacyStatement: DefaultUtil.amapPrivacyStatement,
    // );
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Text('todo'),
    );
  }

  // void onMapCreated(AMapController controller) {
  //   setState(() {
  //     _mapController = controller;
  //     getApprovalNumber();
  //   });
  // }

  /// 获取审图号
  // void getApprovalNumber() async {
  //   //普通地图审图号
  //   String? mapContentApprovalNumber = await _mapController?.getMapContentApprovalNumber();
  //   //卫星地图审图号
  //   String? satelliteImageApprovalNumber = await _mapController?.getSatelliteImageApprovalNumber();
  // }
}
