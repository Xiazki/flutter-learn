// import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:flutter/material.dart';

class DefaultUtil {
  // static const AMapApiKey amapApiKeys = AMapApiKey(androidKey: 'b20dea00eb86a6dfbb96daf1d18b496a', iosKey: 'b20dea00eb86a6dfbb96daf1d18b496a');

  // static const AMapPrivacyStatement amapPrivacyStatement = AMapPrivacyStatement(hasContains: true, hasShow: true, hasAgree: true);

  static Widget divider() {
    return Divider(
      height: 1,
      thickness: 1,
    );
  }

  /// 格式化Duration为"小时:分钟:秒"格式的字符串
  static String formatDurationToHMS(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    if (hours == 0) {
      return '${_pad(minutes)}:${_pad(seconds)}';
    }
    return '${_pad(hours)}:${_pad(minutes)}:${_pad(seconds)}';
  }

  /// 补充不足两位的数字前面加上零
  static String _pad(int number) {
    return number.toString().padLeft(2, '0');
  }

  static RelativeRect calPosition(BuildContext context) {
    final RenderBox button = context.findRenderObject()! as RenderBox;
    final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;

    Offset offset = Offset(0.0, button.size.height);

    RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(offset, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero) + offset, ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    return position;
  }
}
