import 'package:citizens/utils/behavior.dart';
import 'package:citizens/utils/colors.dart';
import 'package:citizens/widget/customShape.dart';
import 'package:flutter/material.dart';

class Citizen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double _borderRadius = 24;
    var items = [
      PlaceInfo(
        'List',
        Color(0xff6DC8F3),
        Color(0xff73A1F9),
        Icons.list,
      ),
      PlaceInfo(
        'New User',
        Color(0xffFFB157),
        Color(0xffFFA057),
        Icons.fiber_new,
      ),
      PlaceInfo(
        'Repairing',
        Color(0xffFF5B95),
        Color(0xffF8556D),
        Icons.developer_mode,
      ),
      // PlaceInfo('Express Food Court', Color(0xffD76EF5), Color(0xff8F7AFE), 4.1,
      //     'Dubai', 'Casual · Good for kids · Delivery'),
      // PlaceInfo('BurJuman Food Court', Color(0xff42E695), Color(0xff3BB2B8),
      //     4.2, 'Dubai · In BurJuman', '...'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Citizen'),
        flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
              colorGradientBtnClick1,
              colorGradientBtnClick2
            ]))),
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(_borderRadius),
                        gradient: LinearGradient(
                            colors: [
                              items[index].startColor,
                              items[index].endColor
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        boxShadow: [
                          BoxShadow(
                            color: items[index].endColor,
                            blurRadius: 12,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      top: 0,
                      child: CustomPaint(
                        size: Size(100, 150),
                        painter: CustomCardShapePainter(_borderRadius,
                            items[index].startColor, items[index].endColor),
                      ),
                    ),
                    Positioned.fill(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Icon(
                              items[index].icon,
                              size: 64,
                              color: Colors.white,
                            ),
                            // Image.asset(
                            //   'assets/icon.png',
                            //   height: 64,
                            //   width: 64,
                            // ),
                            flex: 2,
                          ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  items[index].name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Avenir',
                                      fontSize: 33,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class PlaceInfo {
  final String name;
  final IconData icon;
  final Color startColor;
  final Color endColor;

  PlaceInfo(
    this.name,
    this.startColor,
    this.endColor,
    this.icon,
  );
}
