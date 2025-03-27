import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

abstract class LocalStorageService {
  Future<void> init();
  Future<void> saveSecure(String key, String value);
  Future<String?> getSecure(String key);
  Future<void> removeSecure(String key);
  Future<void> clearSecure();
  Future<void> save<T>(String key, T value);
  Future<T?> get<T>(String key);
  Future<void> remove(String key);
  Future<void> clear();
  Future<Box<T>> openBox<T>(String boxName);
  Future<void> closeBox<T>(Box<T> box);
  Future<void> deleteBox(String boxName);
}

class LocalStorageServiceImpl implements LocalStorageService {
  late FlutterSecureStorage _secureStorage;
  
  @override
  Future<void> init() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDir.path);
    
    _secureStorage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock,
      ),
    );
  }
  
  @override
  Future<void> saveSecure(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }
  
  @override
  Future<String?> getSecure(String key) async {
    return await _secureStorage.read(key: key);
  }
  
  @override
  Future<void> removeSecure(String key) async {
    await _secureStorage.delete(key: key);
  }
  
  @override
  Future<void> clearSecure() async {
    await _secureStorage.deleteAll();
  }
  
  @override
  Future<void> save<T>(String key, T value) async {
    final box = await Hive.openBox('app_box');
    await box.put(key, value);
    await box.close();
  }
  
  @override
  Future<T?> get<T>(String key) async {
    final box = await Hive.openBox('app_box');
    final value = box.get(key) as T?;
    await box.close();
    return value;
  }
  
  @override
  Future<void> remove(String key) async {
    final box = await Hive.openBox('app_box');
    await box.delete(key);
    await box.close();
  }
  
  @override
  Future<void> clear() async {
    final box = await Hive.openBox('app_box');
    await box.clear();
    await box.close();
  }
  
  @override
  Future<Box<T>> openBox<T>(String boxName) async {
    return await Hive.openBox<T>(boxName);
  }
  
  @override
  Future<void> closeBox<T>(Box<T> box) async {
    await box.close();
  }
  
  @override
  Future<void> deleteBox(String boxName) async {
    await Hive.deleteBoxFromDisk(boxName);
  }
}

