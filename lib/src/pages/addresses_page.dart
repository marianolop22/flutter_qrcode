import 'package:flutter/material.dart';
import 'package:flutter_qrcode/src/bloc/scans_bloc.dart';
import 'package:flutter_qrcode/src/models/scan_model.dart';
import 'package:flutter_qrcode/src/utils/utils.dart' as utils;
//import 'package:flutter_qrcode/src/providers/db_provider.dart';

class AddressesPage extends StatelessWidget {
  //const AddressesPage({Key key}) : super(key: key);

  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {

    scansBloc.getScans();

    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStreamHttp,
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
          itemBuilder: (context, i) => Dismissible (
            key: UniqueKey(),
            background: Container(
              color: Colors.red,
            ),
            child: ListTile(
              leading: Icon (Icons.cloud_queue, color: Theme.of(context).primaryColor,),
              title: Text(scans[i].valor),
              subtitle: Text( 'ID ${scans[i].id}' ),
              trailing: Icon (Icons.keyboard_arrow_right, color: Colors.grey,),
              onTap: (){
                utils.openScan(context, scans[i]);
              },
            ),
            onDismissed: ( direction ) => scansBloc.deleteScan( scans[i].id ),
          )
        );


        
      },
    );
  }
}