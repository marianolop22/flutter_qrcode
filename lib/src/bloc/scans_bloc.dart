import 'dart:async';

import 'package:flutter_qrcode/src/providers/db_provider.dart';

class ScansBloc {

  static final ScansBloc _singleton = new ScansBloc._internal(); //es para tener una unica instancia del scansbloc

  factory ScansBloc () {
    return _singleton;
  }

  ScansBloc._internal() {
    //obtener scans de la base de datos
    getScans(); //al ejecutarse esto se llena _scansController y eso emite el scanStream

  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scansController.stream;


  dispose () {
    _scansController?.close(); //por si no esta instanciado el objeto

 }

  getScans () async {
    _scansController.sink.add( await DBProvider.db.getAllScans() );    
  }

  addScan ( ScanModel scanModel ) async {
    await DBProvider.db.newScan(scanModel);
    getScans();
  }

  deleteScan ( int id ) async {

    await DBProvider.db.deleteScan(id);
    getScans();

  }

  deleteAllScans () async {

    await DBProvider.db.deleteAll();
    getScans();
  }
}