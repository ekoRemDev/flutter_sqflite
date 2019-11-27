import 'dart:async';
import 'dart:io' as io;
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_sqflite/models/carmodel.dart';

class DbHelper {
  static Database _db;

  final String tableCar = 'cars';
  final String columnId = 'id';
  final String columnTitle = 'title';
  final String columnDescription = 'description';
  final String columnPrice = 'price';
  final String columnImageUrl = 'imageUrl';

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'Cars2019.db');
    var MyDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return MyDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tableCar($columnId INTEGER PRIMARY KEY AUTOINCREMENT,$columnTitle TEXT, $columnDescription TEXT, $columnPrice REAL , $columnImageUrl TEXT)');
  }

  Future<int> deleteCar(int id) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawDelete('DELETE FROM $tableCar WHERE $columnId = $id');
    });
  }

  Future<int> updateCar(Car car) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawUpdate(
          'UPDATE $tableCar SET $columnTitle = \'${car.title}\',$columnDescription = \'${car.description}\',$columnPrice = ${car.price}, ,$columnImageUrl = \'${car.imageUrl}\' WHERE $columnId = ${car.id}');
    });
  }

  void saveCar(Car car) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO $tableCar ($columnTitle, $columnDescription ,$columnPrice ,$columnImageUrl) VALUES (\'${car.title}\', \'${car.description}\', \'${car.price.toString()}\' , \'${car.imageUrl}\')');
    });
  }


  Future<List<Car>> getCars() async{
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Cars');
    List<Car> cars =List();
    for (int i=0; i < list.length;i++) {
        cars.add(Car(id: list[i]['id'], title:list[i]['title'], description :list[i]['description'],price: list[i]['price'],imageUrl: list[i]['imageUrl']));
    }

    return cars;
  }

}
