import 'package:citizens/models/ListData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:citizens/pages/list/detail/listDetail.dart';

class ListData extends StatefulWidget {
  @override
  State < StatefulWidget > createState() => _ListDataState();

}

class _ListDataState extends State < ListData > {
  final List < ListDataModel > lstData = [
    ListDataModel('100001091', 'Richard Mario', '13323', 'Detail Name', 'Job 1', 'Pasar Rebo', '04', 'chgFg'),
    ListDataModel('100001092', 'Richard Mario', '13323', 'Detail Name', 'Job 2', 'Pasar Rebo', '04', 'chgFg'),
    ListDataModel('100001093', 'Richard Mario', '13323', 'Detail Name', 'Job 3', 'Pasar Rebo', '04', 'chgFg'),
    ListDataModel('100001094', 'Richard Mario', '13323', 'Detail Name', 'Job 4', 'Pasar Rebo', '04', 'chgFg'),
    ListDataModel('100001095', 'Richard Mario', '13323', 'Detail Name', 'Job 5', 'Pasar Rebo', '04', 'chgFg'),
    ListDataModel('100001091', 'Richard Mario', '13323', 'Detail Name', 'Job 1', 'Pasar Rebo', '04', 'chgFg'),
    ListDataModel('100001091', 'Richard Mario', '13323', 'Detail Name', 'Job 1', 'Pasar Rebo', '04', 'chgFg'),
    ListDataModel('100001091', 'Richard Mario', '13323', 'Detail Name', 'Job 1', 'Pasar Rebo', '04', 'chgFg'),
    ListDataModel('100001091', 'Richard Mario', '13323', 'Detail Name', 'Job 1', 'Pasar Rebo', '04', 'chgFg'),
  ];

  _createCard(ListDataModel listDataModel,ctx) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (ctx) => DetailList()));
      },
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [BoxShadow(
            color: Colors.blue[900],
            blurRadius: 20,
            offset: Offset(0, 10)
          )]
        ),
        child: ListTile(
          leading: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: < Widget > [
                Text(listDataModel.corpFg, style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25
                ), ),
              ],
            ),
          ),
          title: Container(
            child: Text(listDataModel.empNm, style: TextStyle(
              color: Colors.blue,
              fontSize: 22
            )),
          ),
          subtitle: Container(
            child: Row(
              children: < Widget > [
                Text(listDataModel.jobNm)
              ],
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: < Widget > [
              Material(
                color: Colors.white,
                child: InkWell(
                  splashColor: Colors.blue[900], // inkwell color
                  child: SizedBox(width: 33, height: 33, child: Icon(Icons.more_horiz)),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    return Scaffold(
      extendBody: true,
      body: Container(
        color: Colors.blue[900],
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: lstData.length,
          itemBuilder: (BuildContext ctx, int idx) {
            return Dismissible(
              key: Key(lstData[idx].empNo),
              child: _createCard(lstData[idx],context),
              confirmDismiss: (direction) async {
                final bool res = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text(
                        "Want to see the detail of ${lstData[idx].empNm} ? "),
                      actions: < Widget > [
                        FlatButton(
                          child: Text(
                            "No",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                          child: Text(
                            "Yes",
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailList()));
                          },
                        ),
                      ],
                    );
                  });
                return res;
              },
            );


            // _createCard(lstData[idx]);
          }),
      ),
      bottomNavigationBar: Container(
        height: 55,
        child: BottomAppBar(
          color: Colors.blue[900],
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: < Widget > [
              IconButton(
                iconSize: 22,
                padding: EdgeInsets.only(left: 20),
                color: Colors.white,
                icon: Icon(Icons.arrow_back_ios), onPressed: () {
                  Navigator.of(context).pop();
                }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue[900],
        child: Icon(Icons.search, color: Colors.white, )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}