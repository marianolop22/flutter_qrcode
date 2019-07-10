import 'dart:async';

import 'package:flutter_qrcode/src/models/scan_model.dart';

class Validators {

  final validateGeo = StreamTransformer<List<ScanModel>,List<ScanModel>>.fromHandlers( //el primer parametro es lo que entra y el segundo lo que sale
    handleData: ( scans , sink ) { //recibo una lista de scans
 
      final geoScans = scans.where( (item) => item.type == 'geo' ).toList();

      sink.add(geoScans);

    } 
  )  ;

  final validateHttp = StreamTransformer<List<ScanModel>,List<ScanModel>>.fromHandlers( //el primer parametro es lo que entra y el segundo lo que sale
    handleData: ( scans , sink ) { //recibo una lista de scans
 
      final httpScans = scans.where( (item) => item.type == 'http' ).toList();

      sink.add(httpScans);

    } 
  )  ;
  
}