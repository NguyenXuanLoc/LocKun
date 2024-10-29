import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:get_storage/get_storage.dart';

class StorageUtils {
  static var key = "_____";

  static bool saveData(String value) {
    String oldValue = GetStorage().read(StorageKey.data) ?? "";
    if (oldValue.contains(value)) return false;
    GetStorage().write(StorageKey.data, oldValue + key + value);
    getAllData();
    return true;
  }

  static void removeData(String value) {
    String oldValue = GetStorage().read(StorageKey.data) ?? "";
    logE("TAG oldValue: $oldValue");
    var newValue = oldValue.replaceAll(key + value, "");
    logE("TAG oldValue: ${key + value}  <<<$newValue");
    GetStorage().write(StorageKey.data, newValue);
    getAllData();
  }

  static List<String> getAllData() {
    try {
      String oldValue = GetStorage().read(StorageKey.data) ?? "";
      logE("TAG oldValue: ${oldValue}");
      return oldValue
          .split(key)
          .where((element) => element != "" && element != " ")
          .toList();
    } catch (ex) {}
    return [];
  }
}
