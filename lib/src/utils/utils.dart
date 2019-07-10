import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_qrcode/src/models/scan_model.dart';

openScan( BuildContext context, ScanModel scanModel) async {

  if ( scanModel.type == 'http') {
    if (await canLaunch(scanModel.valor)) {
      await launch(scanModel.valor);
    } else {
      throw 'Could not launch ${scanModel.valor}';
    }
  } else {

    Navigator.pushNamed(context, 'mapa', arguments: scanModel);

  }


}