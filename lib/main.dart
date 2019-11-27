import 'package:flutter/material.dart';
import 'package:flutter_sqflite/database/dbhelper.dart';

import 'models/carmodel.dart';

void main() async{
//  runApp(MyApp());
var dbHelper = DbHelper();

//Car car1 = Car(id: 1,title: 'araba 1',description : 'guzel araba 1', price: 1200 ,imageUrl :'1 yok');
//Car car2 = Car(id: 2,title: 'araba 2',description : 'guzel araba 2', price: 2200 ,imageUrl :'2 yok');
//Car car3 = Car(id: 3,title: 'araba 3',description : 'guzel araba 3', price: 3200 ,imageUrl :'3 yok');
////
//dbHelper.saveCar(car1);
//dbHelper.saveCar(car2);
//dbHelper.saveCar(car3);

List<Car> list = await dbHelper.getCars();

for (int i = 0; i<list.length;i++) {
  print("car id : ${list[i].id} - title ${list[i].title} - ${list[i].description} - ${list[i].price} - ${list[i].imageUrl}");
}

//dbHelper.updateCar(car);
dbHelper.deleteCar(2);



}

