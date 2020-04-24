import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:citizens/models/settings/tableAuth.dart';


final String tableAuth = 'Auth';
final String columnId = 'empId';
final String columnempNm = 'empNm';
final String columnPassw = 'passw';

class DbHelper {
  Database _datebase;
  Future openDB() async {
    if (_datebase == null) {
      _datebase = await openDatabase(join(await getDatabasesPath(), "auth.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE $tableAuth($columnId String PRIMARY KEY,$columnempNm TEXT,$columnPassw TEXT)");
      });
    }
  }

  Future<int> insertAuth(TableAuth tableAuths) async {
    await openDB();
    return await _datebase.insert(tableAuth, tableAuths.toJson());
  }

  Future<TableAuth> getAuthList() async {
    await openDB();
    List<Map> maps = await _datebase.query(tableAuth,
        columns: [columnId, columnempNm],);
        TableAuth tabAuth ;
        for(int i = 0; i < maps.length; i++){
          tabAuth = TableAuth(maps[i][columnId].toString(),maps[i][columnempNm],maps[i][columnPassw]);
        }
    if (maps.length > 0) {
      
      return tabAuth;
    }
    return null;
  }

  Future<int> updateAuth(TableAuth tableAuths) async {
    await openDB();
    return await _datebase.update(tableAuth, tableAuths.toJson(),
        where: 'id=?', whereArgs: [tableAuths.empId]);
  }

  Future<void> deleteAuth(String id) async {
    await openDB();
    await _datebase.delete(tableAuth, where: "$columnId = ? ", whereArgs: [id]);
  }

  Future<TableAuth> getSingleData(String id) async {
    await openDB();
    List<Map> maps = await _datebase.query(tableAuth,
        columns: [columnId, columnempNm],
        where: '$columnId = ?',
        whereArgs: [id]);
        TableAuth tabAuth ;
        for(int i = 0; i < maps.length; i++){
          tabAuth = TableAuth(maps[i][columnId].toString(),maps[i][columnempNm],maps[i][columnPassw]);
        }
    if (maps.length > 0) {
      
      return tabAuth;
    }
    return null;
  }

  Future close() async => _datebase.close();
}
