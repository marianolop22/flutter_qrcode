import 'package:flutter/material.dart';
import 'package:flutter_qrcode/src/providers/db_provider.dart';

class MapsPage extends StatelessWidget {
  //const MapsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ScanModel>>(
      future: DBProvider.db.getAllScans(),
      // initialData: [],
      builder: (BuildContext context, AsyncSnapshot <List<ScanModel>>snapshot) {

        if ( !snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final scans = snapshot.data;
        
        if ( scans.length == 0 ) {
          return Center(
            child: Text('No hay informacion'),
          );
        }

        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, i) => ListTile(
            leading: Icon (Icons.cloud_queue, color: Theme.of(context).primaryColor,),
            title: Text(scans[i].valor),
            trailing: Icon (Icons.keyboard_arrow_right, color: Colors.grey,),
          )
        );


        
      },
    );
  }
}