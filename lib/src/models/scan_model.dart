import 'package:latlong/latlong.dart';

class ScanModel {

    int id;
    String type;
    String valor;

    ScanModel({
        this.id,
        this.type,
        this.valor,
    }){

      if ( this.valor.contains('http')) {

        this.type = 'http';
      } else {
        this.type = 'geo';
      }
    }

    factory ScanModel.fromJson(Map<String, dynamic> json) => new ScanModel(
        id: json["id"],
        type: json["type"],
        valor: json["valor"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "valor": valor,
    };


    LatLng getLatLng () {

      final lalo = valor.substring(4).split(',');
      final lat = double.parse(lalo[0]);
      final lng = double.parse(lalo[1]);

      return LatLng (lat, lng);

    }
}
