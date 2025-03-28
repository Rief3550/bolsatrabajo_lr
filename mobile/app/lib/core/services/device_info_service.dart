abstract class DeviceInfoService {
  Future<Map<String, dynamic>> getDeviceInfo();
  Future<String> getDeviceId();
  Future<String> getDeviceModel();
  Future<String> getDeviceOS();
  Future<String> getDeviceOSVersion();
}

class DeviceInfoServiceImpl implements DeviceInfoService {
  @override
  Future<Map<String, dynamic>> getDeviceInfo() async {
    // En una implementación real, usaríamos device_info_plus
    return {
      'id': 'unknown',
      'model': 'unknown',
      'os': 'unknown',
      'osVersion': 'unknown',
    };
  }

  @override
  Future<String> getDeviceId() async {
    return 'unknown';
  }

  @override
  Future<String> getDeviceModel() async {
    return 'unknown';
  }

  @override
  Future<String> getDeviceOS() async {
    return 'unknown';
  }

  @override
  Future<String> getDeviceOSVersion() async {
    return 'unknown';
  }
}

