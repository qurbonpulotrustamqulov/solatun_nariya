import 'package:solaatun_nariya/services/local_data_source.dart';

abstract class ZikrRepository {
  Future<bool> storeCounter();
  Future<bool>storeZero();

  Future<bool> storeHistory(List<String> x, int y);

  List<String> readHistory();

  int readCounter();
}

class ZikrRepositoryImpl implements ZikrRepository {
  final LocalDataSource dataSource;

  const ZikrRepositoryImpl({required this.dataSource});

  @override
  List<String> readHistory() {
    /// String => json => Object
    List<String> data = dataSource.readHistory() ?? [];
    return data;
  }

  @override
  Future<bool> storeHistory(List<String> x, int y) {
//
    x.add("${"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"}=>$y");
    return dataSource.storeHistory(x);
  }

  @override
  Future<bool> storeCounter() {
    final list = readHistory();
    final int x;
    if (list.any((element) => element
        .contains("${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"))) {
      x = readCounter() + 1;
    } else {
      x = 1;
    }
    storeHistory(list, x);
    return dataSource.storeCounter(x);
  }

  @override
  Future<bool>storeZero(){
    final list = readHistory();
    storeHistory(list, 0);
    return dataSource.storeCounter(0);
  }

  @override
  int readCounter() {
    int data = dataSource.readCounter() ?? 0;
    return data;
  }
}
