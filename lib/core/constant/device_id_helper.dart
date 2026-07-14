// import 'dart:io';
// import 'package:device_info_plus/device_info_plus.dart';
//
// class DeviceIdHelper {
//   static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
//
//   static Future<String?> getDeviceId() async {
//     try {
//       if (Platform.isAndroid) {
//         final androidInfo = await _deviceInfoPlugin.androidInfo;
//         return androidInfo.id; // Android ID
//       } else if (Platform.isIOS) {
//         final iosInfo = await _deviceInfoPlugin.iosInfo;
//         return iosInfo.identifierForVendor; // iOS identifierForVendor
//       } else if (Platform.isWindows) {
//         final windowsInfo = await _deviceInfoPlugin.windowsInfo;
//         return windowsInfo.deviceId;
//       } else if (Platform.isMacOS) {
//         final macInfo = await _deviceInfoPlugin.macOsInfo;
//         return macInfo.systemGUID;
//       } else if (Platform.isLinux) {
//         final linuxInfo = await _deviceInfoPlugin.linuxInfo;
//         return linuxInfo.machineId;
//       }
//       return null;
//     } catch (e) {
//       return null;
//     }
//   }
//
//   static Future<Map<String, dynamic>?> getDeviceInfo() async {
//     try {
//       if (Platform.isAndroid) {
//         final androidInfo = await _deviceInfoPlugin.androidInfo;
//         return {
//           'deviceId': androidInfo.id,
//           'manufacturer': androidInfo.manufacturer,
//           'model': androidInfo.model,
//           'brand': androidInfo.brand,
//           'device': androidInfo.device,
//           'product': androidInfo.product,
//           'androidId': androidInfo.id,
//           'systemVersion': androidInfo.version.release,
//           'sdkInt': androidInfo.version.sdkInt,
//         };
//       } else if (Platform.isIOS) {
//         final iosInfo = await _deviceInfoPlugin.iosInfo;
//         return {
//           'deviceId': iosInfo.identifierForVendor,
//           'name': iosInfo.name,
//           'model': iosInfo.model,
//           'systemName': iosInfo.systemName,
//           'systemVersion': iosInfo.systemVersion,
//           'identifierForVendor': iosInfo.identifierForVendor,
//           'isPhysicalDevice': iosInfo.isPhysicalDevice,
//         };
//       }
//       return null;
//     } catch (e) {
//       return null;
//     }
//   }
// }
