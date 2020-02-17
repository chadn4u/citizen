import 'package:citizens/pages/list/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class MainMenu extends StatefulWidget {
  
  @override
  State < StatefulWidget > createState() => _MainMenuState();

}

class _MainMenuState extends State < MainMenu > {

  _top() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[900],
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(80), bottomLeft: Radius.circular(80))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: < Widget > [
          ClipOval(
            child: Material(
              color: Colors.white, // button color
              child: InkWell(
                splashColor: Colors.blue[900], // inkwell color
                child: SizedBox(width: 56, height: 56, child: Icon(Icons.person)),
                onTap: () {},
              ),
            ),
          ),
          SizedBox(height: 12),
          Text('Richard Mario', style: TextStyle(color: Colors.white, fontSize: 22), ),
          SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: < Widget > [
              Text('LSI', style: TextStyle(color: Colors.white, fontSize: 12), ),
              SizedBox(width: 20, ),
              Text('100001091', style: TextStyle(color: Colors.white, fontSize: 12), )
            ],
          )

        ],
      ),
    );
  }

  _middle() {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.blue[900],
        boxShadow: [BoxShadow(
          color: Colors.blue[900],
          blurRadius: 20,
          offset: Offset(0, 10)
        )]
      ),
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(22),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3 / 3
        ),
        children: < Widget > [
          _gridItem(Icons.list, 'List'),
          _gridItem(Icons.fiber_new, 'New User'),
          _gridItem(Icons.leak_add, 'Mutation'),
          _gridItem(Icons.settings_power, 'Resignation'),
           _gridItem(Icons.computer, 'IT Process'),
           _gridItem(Icons.developer_mode, 'Repairing'),
           _gridItem(Icons.desktop_mac, 'Monitoring'),
        ],
      ),

    );
  }

  _gridItem(image, menuName) {
    return Column(
      children: < Widget > [
        ClipOval(
          child: Material(
            color: Colors.white, // button color
            child: InkWell(
              splashColor: Colors.blue[900], // inkwell color
              child: SizedBox(width: 44, height: 44, child: Icon(image)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ListData()));
              },
            ),
          ),
        ),
        SizedBox(height: 8, ),
        Text(menuName, style: TextStyle(color: Colors.white), )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.blue[900]);
    return Scaffold(
      body: ListView(
        children: < Widget > [
          _top(),
          _middle()
        ],
      ),
    );
  }
}