import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/util/default.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<StatefulWidget> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  AMapController? _mapController;

  @override
  Widget build(BuildContext context) {
    ///使用默认属性创建一个地图
    final AMapWidget map = AMapWidget(
      apiKey: DefaultUtil.amapApiKeys,
      onMapCreated: onMapCreated,
      privacyStatement: DefaultUtil.amapPrivacyStatement,
    );
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: map,
    );
  }

  void onMapCreated(AMapController controller) {
    setState(() {
      _mapController = controller;
      var son = LatLng(19.158951, 70.749941);
      var nor = LatLng(53.961716, 141.758028);
      LatLngBounds bounds = LatLngBounds(southwest: son, northeast: nor);
      _mapController?.moveCamera(CameraUpdate.newLatLngBounds(bounds, 1));
      getApprovalNumber();
    });
  }

  // 获取审图号
  void getApprovalNumber() async {
    //普通地图审图号
    String? mapContentApprovalNumber = await _mapController?.getMapContentApprovalNumber();
    //卫星地图审图号
    String? satelliteImageApprovalNumber = await _mapController?.getSatelliteImageApprovalNumber();
  }
}
