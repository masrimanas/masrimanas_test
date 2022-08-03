import 'package:masrimanas_test/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

abstract class LocalDataSource {
  Future<List<String>> getData();
  Future<void> saveData(String name, String age);
}

class LocalDataSourceImpl implements LocalDataSource {
  LocalDataSourceImpl();

  @override
  Future<void> saveData(String name, String age) async {
    final stores = await SharedPreferences.getInstance();
    await stores.setString(
      'nama',
      name,
    );
    await stores.setString(
      'umur',
      age,
    );
  }

  @override
  Future<List<String>> getData() async {
    var result = <String>[];
    final stores = await SharedPreferences.getInstance();
    final nama = stores.getString('nama');
    final umur = stores.getString('umur');
    // await stores.clear();

    if (nama != null && umur != null) {
      result = List.from([nama, umur]);
    } else {
      throw const DatabaseException('Data tidak ditemukan');
    }
    return result;
  }
}
