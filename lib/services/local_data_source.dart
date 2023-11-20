import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<bool> storeCounter(int data);

  Future<bool> storeHistory(List<String> data);

  int? readCounter();

  List<String>? readHistory();
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences db;

  const LocalDataSourceImpl({required this.db});

  static Future<SharedPreferences> get init async {
    return SharedPreferences.getInstance();
  }

  @override
  int? readCounter() {
    return db.getInt('counter');
  }

  @override
  List<String>? readHistory() {
    return db.getStringList('history');
  }

  @override
  Future<bool> storeCounter(int data) async {
    return db.setInt('counter', data);
  }

  @override
  Future<bool> storeHistory(List<String> data) async {
    if (data.length > 1 &&
        data.last.contains(
            "${"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"}=>") &&
        data[data.indexOf(data.last) - 1].contains(
            "${"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"}=>")) {
      data.remove(data[data.indexOf(data.last) - 1]);
    }
    return db.setStringList('history', data);
  }
}
