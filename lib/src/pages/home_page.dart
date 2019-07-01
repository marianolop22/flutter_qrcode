import 'package:flutter/material.dart';
import 'package:flutter_qrcode/src/pages/addresses_page.dart';
import 'package:flutter_qrcode/src/pages/maps_page.dart';

class HomePage extends StatefulWidget {
  //const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {},
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _createBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon ( Icons.filter_center_focus),
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _createBottomNavigationBar() {

    return BottomNavigationBar(

      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon (Icons.map),
          title: Text('Mapas')
        ),
        BottomNavigationBarItem(
          icon: Icon (Icons.brightness_5),
          title: Text('Direcciones')
        ),

      ],
    );

  }

  Widget _callPage( int actualPage ) {

    switch (actualPage) {
      case 0:
        return MapsPage();
        break;
      case 1:
        return AddressesPage();
        break;
      default:
        return MapsPage();
    }



  }
}