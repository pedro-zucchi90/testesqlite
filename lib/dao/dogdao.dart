//Manipular dados do banco de dados

import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../database/db.dart';
import '../model/dogmodel.dart';

//Insert
Future<int>insertDog(DogModel dog) async {
  Database db = await getDatabase();
  
  return await db.insert(
    'dogs',
    dog.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

//findAll
Future<List<Map>> findAll() async {
  final db = await getDatabase();
  return db.query('dogs');
}

//Buscar por nome
Future<List<Map>> buscarPorNome(String nome) async {
  final db = await getDatabase();
  return db.query(
    'dogs',
    where: 'nome LIKE ?',
    whereArgs: ['%'+nome+'%'],
  );
}

//Buscar por idade
Future<List<Map>> buscarPorIdade(int idade) async {
  final db = await getDatabase();
  return db.query(
    'dogs',
    where: 'idade = ?',
    whereArgs: [idade],
  );
}

//remove
Future<int> removeDog(int id) async {
  final db = await getDatabase();
  return db.delete(
    'dogs',
    where: 'id = ?',
    whereArgs: [id],
  );
}





