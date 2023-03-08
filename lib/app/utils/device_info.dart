import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  static Future<Map<String, dynamic>> getPhoneInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    final AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    return {
      'version.sdkInt': androidDeviceInfo.version.sdkInt,
      'version.baseOS': androidDeviceInfo.version.baseOS,
      'brand': androidDeviceInfo.brand,
      'device': androidDeviceInfo.device,
      'model': androidDeviceInfo.model,
      'product': androidDeviceInfo.product,
      'id': androidDeviceInfo.id,
      'androidId': androidDeviceInfo.androidId 
    };
  }
}