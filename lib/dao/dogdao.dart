//manipular dados do banco de dados

import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import '../database/db.dart';
import '../model/dogmodel.dart';

//INSERT

Future<int>insertDog(Map<String, dynamic> dog) async {
  final db = await getDatabase();
  return await db.insert('dogs', dog);
}

//delete
Future<int> deleteDog(int id) async {
  final db = await getDatabase();
  return await db.delete(
    'dogs',
    where: 'id = ?',
    whereArgs: [id],
  );
}



