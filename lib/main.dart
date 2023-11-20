import 'package:flutter/cupertino.dart';
import 'package:solaatun_nariya/app.dart';
import 'package:solaatun_nariya/repositories/zikr_repository.dart';
import 'package:solaatun_nariya/services/local_data_source.dart';
late ZikrRepository repository;
void main()async{
  WidgetsFlutterBinding.ensureInitialized();

  final db = await LocalDataSourceImpl.init;
  LocalDataSource dataSource = LocalDataSourceImpl(db: db);
  repository = ZikrRepositoryImpl(dataSource: dataSource);
 runApp(const App());
}