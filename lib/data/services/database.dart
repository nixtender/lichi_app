import 'package:lichi_app/domain/models/db_model.dart';
import 'package:lichi_app/domain/models/product.dart';
import 'package:lichi_app/domain/models/product_base.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart' show rootBundle;

class DB {
  DB._();
  static final DB instance = DB._();
  static late Database _db;
  static bool _initialized = false;

  Future init() async {
    if (!_initialized) {
      var databasePath = await getDatabasesPath();
      var path = join(databasePath, "db_v1.0.0.db");

      _db = await openDatabase(path, version: 1, onCreate: _createDB);
      _initialized = true;
    }
  }

  Future _createDB(Database db, int version) async {
    var dbInitScript = await rootBundle.loadString("assets/db_init.sql");
    dbInitScript.split(';').forEach((element) async {
      if (element.isNotEmpty) {
        await db.execute(element);
      }
    });
  }

  static final _factories = <Type, Function(Map<String, dynamic> map)>{
    ProductBase: ((map) => ProductBase.fromMap(map)),
  };

  String _dbName(Type type) {
    if (type == DbModel) {
      throw Exception("type is REQUERED");
    }
    return "t_$type";
  }

  Future<Iterable<T>> getAll<T extends DbModel>(
      {Map<String, dynamic>? whereMap, int? take, int? skip}) async {
    Iterable<Map<String, dynamic>> query;

    if (whereMap != null) {
      var whereBuilder = <String>[];
      var whereArgs = <dynamic>[];
      whereMap.forEach((key, value) {
        if (value is Iterable<dynamic>) {
          whereBuilder
              .add("$key IN (${List.filled(value.length, '?').join(',')})");
          whereArgs.addAll(value.map((e) => "$e"));
        } else {
          whereBuilder.add("$key = ?");
          whereArgs.add(value);
        }
      });
      query = await _db.query(_dbName(T),
          offset: skip,
          limit: take,
          where: whereBuilder.join(' and '),
          whereArgs: whereArgs);
    } else {
      query = await _db.query(_dbName(T), offset: skip, limit: take);
    }
    var resList = query.map((e) => _factories[T]!(e)).cast<T>();

    return resList;
  }

  Future<T?> get<T extends DbModel>(dynamic id) async {
    var res = await _db.query(_dbName(T), where: 'id = ? ', whereArgs: [id]);
    return res.isNotEmpty ? _factories[T]!(res.first) : null;
  }

  Future<int> insert<T extends DbModel>(T model) async {
    if (model.id == "") {
      var modelmap = model.toMap();
      // modelmap["id"] = const Uuid().v4();
      model = _factories[T]!(modelmap);
    }
    return await _db.insert(_dbName(T), model.toMap());
  }

  Future<int> update<T extends DbModel>(T model) async =>
      await _db.update(_dbName(T), model.toMap(),
          where: 'id = ?', whereArgs: [model.id]);

  Future<int> delete<T extends DbModel>(T model) async =>
      await _db.delete(_dbName(T), where: 'id = ?', whereArgs: [model.id]);

  Future<int> createUpdate<T extends DbModel>(T model) async {
    var dbItem = await get<T>(model.id);
    var res = dbItem == null ? insert(model) : update(model);
    return await res;
  }
}
