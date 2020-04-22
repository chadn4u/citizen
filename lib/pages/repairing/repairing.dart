import 'package:citizens/pages/repairing/resetPassword.dart';
import 'package:citizens/utils/colors.dart';
import 'package:citizens/utils/mainUtils.dart';
import 'package:flutter/material.dart';
import 'package:rounded_letter/rounded_letter.dart';
import 'package:rounded_letter/shape_type.dart';

class RepairingPages extends StatelessWidget {
  final String jobCd;
  final String strCd;
  final String empNo;
  final String corpFg;
  final String allCorp;
  final String directorat;

  RepairingPages(
      {Key key,
      this.jobCd,
      this.strCd,
      this.empNo,
      this.corpFg,
      this.allCorp,
      this.directorat})
      : super(key: key);

  List<SubMenuRepairing> lstSubMenu = [
    SubMenuRepairing('Employee Data', 'assets/images/list.png', null),
    SubMenuRepairing('HR sudah sync tapi di mutasi tdk muncul',
        'assets/images/cable.png', null),
    SubMenuRepairing('Mutasi Salah Store', 'assets/images/mutation.png', null),
    SubMenuRepairing('Re-Process Input GMD', 'assets/images/input.png', null),
    SubMenuRepairing('Reset Password + Enable', 'assets/images/compass.png',
        ResetPassword()),
    SubMenuRepairing('Back', 'assets/images/exit.png', 0),
  ];
  ScrollController scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                child: _top(context),
              ),
              GridView.builder(
                  controller: scrollController,
                  padding: EdgeInsets.only(top: 100),
                  itemCount: lstSubMenu.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 6.0,
                      childAspectRatio:
                          (MediaQuery.of(context).size.width / 2) /
                              (MediaQuery.of(context).size.height / 3),
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext ctx, int idx) {
                    return _buildListItem(idx, context);
                  }),
            ],
          )
        ],
      ),
    );
  }

  _top(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorPrimary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Repairing',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(int idx, BuildContext context) {
    return InkWell(
      onTap: () {
        if (lstSubMenu[idx].page is ResetPassword) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => lstSubMenu[idx].page));
        } else if (lstSubMenu[idx].page == 0) {
          Navigator.of(context).pop();
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                title: new Text("Belum Ada Menu nya"),
                content: new Text("Menu nye Kage Ade"),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      },
      child: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: layoutBackgroundWhite,
              boxShadow: [
                BoxShadow(
                    color: colorPrimary, blurRadius: 1, offset: Offset(0, 1))
              ]),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(lstSubMenu[idx].icons, width: 80, height: 80),
              // Icon(

              //   lstSubMenu[idx].icons,
              //   color: colorPrimary,
              //   size: 50,

              // ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(lstSubMenu[idx].title,
                    style: TextStyle(fontSize: 10, color: textColorPrimary),
                    overflow: TextOverflow.ellipsis),
              )
            ],
          )),
    );
  }
}

class SubMenuRepairing {
  final String title;
  final String icons;
  final dynamic page;

  SubMenuRepairing(this.title, this.icons, this.page);
}
