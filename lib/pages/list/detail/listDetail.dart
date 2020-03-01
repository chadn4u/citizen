import 'package:citizens/utils/customShapeClippers.dart';
import 'package:citizens/utils/mainUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:rounded_letter/rounded_letter.dart';
import 'package:rounded_letter/shape_type.dart';

class DetailList extends StatefulWidget {
  final String name;
  final String empNo;
  final String jobNm;
  final String strCd;
  final String corpFg;

  const DetailList(
      {Key key, this.name, this.empNo, this.jobNm, this.strCd, this.corpFg})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailListState();
}

class _DetailListState extends State<DetailList> {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.blue[900]);
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    ClipPath(
                      clipper: CustomShapeClipper(),
                      child: Container(
                        height: 170,
                        color: Colors.blue[900],
                      ),
                    ),
                    Container(
                      height: 200,
                      child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  RoundedLetter(
                                    text: Utils().getFirstLetter(widget.name),
                                    shapeColor: Utils().getRandomColor(
                                        Utils().getFirstLetter(widget.name)),
                                    shapeType: ShapeType.circle,
                                    borderColor: Colors.white,
                                    borderWidth: 2,
                                  ),
                                ],
                              ),
                            ],
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    widget.name,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blue[900],
                                  blurRadius: 20,
                                  offset: Offset(0, 10))
                            ]),
                        child: Text(
                          widget.empNo,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blue[900],
                                  blurRadius: 20,
                                  offset: Offset(0, 10))
                            ]),
                        child: Text(
                          widget.jobNm,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blue[900],
                                  blurRadius: 20,
                                  offset: Offset(0, 10))
                            ]),
                        child: Text(
                          widget.strCd,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blue[900],
                                  blurRadius: 20,
                                  offset: Offset(0, 10))
                            ]),
                        child: Text(
                          widget.corpFg,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.blue[900]),
                    width: double.infinity,
                    child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Back',
                          style: TextStyle(color: Colors.white),
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
