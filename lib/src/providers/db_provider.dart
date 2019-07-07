import 'dart:io';

import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_qrcode/src/models/scan_model.dart';
export 'package:flutter_qrcode/src/models/scan_model.dart';

class DBProvider { //singleton, unica instancia para toda la app

  static Database _database;
  static final DBProvider db = DBProvider._(); //constructor privado

  DBProvider._();

  Future <Database> get database async {

    if ( _database != null ) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB () async {

    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join ( documentsDirectory.path, 'ScansDB.db');

    return await openDatabase (
      path, 
      version: 1,
      onOpen: (db){},
      onCreate: ( Database db, int version ) async {
        await db.execute(
          'CREATE TABLE Scans ('
          ' id INTEGER PRIMARY KEY,'
          ' type TEXT,'
          ' valor TEXT'
          ')'
        );
      }
    );
  }

  //Crear registros
  newScanRaw ( ScanModel scanModel ) async {

    final db = await database; //llama al get de arriba
    final response = await db.rawInsert(
      'INSERT INTO Scans (id, type, valor) '
      'VALUES '
      "( ${scanModel.id}, '${scanModel.type}', '${scanModel.valor}')"
    );

    return response;
  }

  newScan ( ScanModel scanModel ) async {

    final db = await database; //llama al get de arriba
    final response = await db.insert('Scans', scanModel.toJson());

    return response;
  }

  //traer la info
  Future <ScanModel> getScanId ( int id ) async {

    final db = await database; //llama al get de arriba   
    final response = await db.query(
      'Scans', 
      where: 'id = ?', 
      whereArgs: [id]
    );

    return response.isNotEmpty ? ScanModel.fromJson( response.first ) : null;//el from json devuelve una nueva instancia del model
  }

  Future<List<ScanModel>> getAllScans () async {

    final db = await database; //llama al get de arriba   
    final response = await db.query(
      'Scans'
    );

    List<ScanModel> list = response.isNotEmpty 
        ? response.map( (item) => ScanModel.fromJson( item ) ).toList()
        : [];
    return list;
  }

  Future<List<ScanModel>> getScansByType ( String type ) async {

    final db = await database; //llama al get de arriba   
    final response = await db.rawQuery( "SELECT * FROM Scans WHERE type = '${type}'" );

    List<ScanModel> list = response.isNotEmpty 
        ? response.map( (item) => ScanModel.fromJson( item ) ).toList()
        : [];
    return list;
  }

  //Actualizar registros
  Future<int> updateScan ( ScanModel scanModel ) async {

    final db = await database; //llama al get de arriba   
    final response = await db.update(
      'Scans', 
      scanModel.toJson(), 
      where: 'id = ?',
      whereArgs: [scanModel.id]  );

    return response;
  }

  //Borrar registros
  Future<int> deleteScan ( int id ) async {

    final db = await database; //llama al get de arriba   
    final response = await db.delete(
      'Scans', 
      where: 'id = ?',
      whereArgs: [id]  );

    return response;
  }

  Future<int> deleteAll () async {

    final db = await database; //llama al get de arriba   
    final response = await db.rawDelete(
      'DELETE FROM Scans');

    return response;
  }


}