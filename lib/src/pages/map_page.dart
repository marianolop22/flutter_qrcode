import 'package:flutter/material.dart';
//import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map/flutter_map.dart';
//import 'package:latlong/latlong.dart';

import 'package:flutter_qrcode/src/models/scan_model.dart';

class MapPage extends StatelessWidget {
  // const MapPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Coordenadas QR'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.my_location),
              onPressed: (){},
            )
          ],
        ),
        body: _createFlutterMap( scan )
      ),
    );
  }

  Widget _createFlutterMap( ScanModel scan) {

    return FlutterMap(
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15
      ),
      layers: [
        _createMap(),
        _createMarkers( scan )
      ],
    );

  }

  LayerOptions  _createMap() {

    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
        '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken':'pk.eyJ1IjoibWFyaWFub2xvcDIyIiwiYSI6ImNqeHdkcHM5bjBlbWozbmxxN3NrN2hvYWYifQ.ju5b-A-_utroLcEgKUT5SA',
        'id':'mapbox.streets' // tipos .streets .dark .light .outdoors, satellite
      }
    );

  }

  LayerOptions _createMarkers( ScanModel scan ) {

    return MarkerLayerOptions(

      markers: <Marker> [
        Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLatLng(),
          builder: (context) => Container(
            child: Icon ( 
              Icons.location_on, 
              size: 70.0, 
              color: 
              Theme.of(context).primaryColor, 
            ),

          )
        )
      ]
    );


  }
}