import 'package:flutter/material.dart';
//import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map/flutter_map.dart';
//import 'package:latlong/latlong.dart';

import 'package:flutter_qrcode/src/models/scan_model.dart';

class MapPage extends StatefulWidget {
  // const MapPage({Key key}) : super(key: key);
  
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final map = new MapController();

  String mapType = 'mapbox.streets';

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: (){
              map.move(scan.getLatLng(), 15);
            },
          )
        ],
      ),
      body: _createFlutterMap( scan ),
      floatingActionButton: _createFloatingButton( context),
    );
  }

  Widget _createFlutterMap( ScanModel scan) {

    return FlutterMap(
      mapController: map,
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
        'id': mapType // tipos .streets .dark .light .outdoors, satellite
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

  Widget _createFloatingButton(BuildContext context) {

    return FloatingActionButton(
      child: Icon (Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: (){

        if ( mapType== 'mapbox.streets' ) {
          mapType = 'mapbox.dark';
        } else if ( mapType== 'mapbox.dark' ) {
          mapType = 'mapbox.light';
        } else if ( mapType== 'mapbox.light' ) {
          mapType = 'mapbox.outdoors';
        } else if ( mapType== 'mapbox.outdoors' ) {
          mapType = 'mapbox.satellite';
        } else {
          mapType = 'mapbox.streets';
        }

        setState(() {});
      },

    );



  }
}