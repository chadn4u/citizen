import 'package:citizens/bloc/newUser/newUserBloc.dart';
import 'package:citizens/bloc/newUser/newUserEvents.dart';
import 'package:citizens/bloc/newUser/newUserState.dart';
import 'package:citizens/models/newUser/newUser.dart';
import 'package:citizens/models/newUser/newUserFeed.dart';
import 'package:citizens/models/responseDio/responseDio.dart';
import 'package:citizens/utils/colors.dart';
import 'package:citizens/utils/mainUtils.dart';
import 'package:citizens/widget/newUser/modalBottom.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rounded_letter/rounded_letter.dart';
import 'package:rounded_letter/shape_type.dart';

class SubmitRequest extends StatefulWidget {
  final String jobCd;
  final String strCd;
  final String empNo;
  final String corpFg;
  final String allCorp;
  final String directorat;
  final ScrollController scrollControllers;

  const SubmitRequest(
      {Key key,
      this.jobCd,
      this.strCd,
      this.empNo,
      this.corpFg,
      this.allCorp,
      this.directorat,
      this.scrollControllers})
      : super(key: key);
  @override
  _SubmitRequestState createState() => _SubmitRequestState();
}

class _SubmitRequestState extends State<SubmitRequest> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<NewUser> newUser = [];
  final List<NewUser> newUserSearch = [];
  final List<NewUser> newUserTemp = [];
  final int initialMin = 0;
  final int initialMax = 20;

  ScrollController scrollController = new ScrollController();
  NewUserBloc _newUserBloc;

  int minMove;
  int maxMove;
  int minMoveTemp;
  int maxMoveTemp;
  int totalData;
  int totalDataTemp;
  bool isEnded = false;
  bool isLoading = false;
  bool isSearch = false;
  bool isEndOfResult = false;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Widget _buildLoaderItem() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _showBottomSheet(int idx) {
    _scaffoldKey.currentState
        .showBottomSheet<void>((BuildContext context) {
          return NewUserBottom(
            corpFg: newUser[idx].corpFg,
            reqCorpFg: widget.corpFg,
            strCd: widget.strCd,
            jobCd: newUser[idx].jobCd,
            directorat: widget.directorat,
            empNo: newUser[idx].empNo,
            totalData: totalData,
            allCorp: widget.allCorp,
            maxMove: maxMove,
            doj: newUser[idx].doj,
            empNm: newUser[idx].empNm,
            level: newUser[idx].levelEmp,
            reqEmpNo: widget.empNo,
            reqJobCd: widget.jobCd,
          );
        })
        .closed
        .whenComplete(() {});
  }

  Widget _buildListItem(int idx) {
    return InkWell(
      onTap: () {
        _showBottomSheet(idx);
      },
      child: Container(
        height: 10,
        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: colorPrimary,
        ),
        alignment: Alignment.center,
        child: ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              RoundedLetter(
                shapeSize: 30,
                fontSize: 15,
                text: Utils().getFirstLetter(newUser[idx].empNm),
                shapeColor: Utils()
                    .getRandomColor(Utils().getFirstLetter(newUser[idx].empNm)),
                shapeType: ShapeType.circle,
                borderColor: Colors.white,
                borderWidth: 2,
              ),
            ],
          ),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(newUser[idx].empNm,
                  style: TextStyle(color: Colors.white, fontSize: 9),
                  overflow: TextOverflow.ellipsis),
              Text(newUser[idx].empNo,
                  style: TextStyle(color: Colors.grey, fontSize: 7))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog pr =
        ProgressDialog(context, isDismissible: true, showLogs: true);
    pr.style(message: 'Please Wait...');
    return Scaffold(
      key: _scaffoldKey,
      body: BlocBuilder<NewUserBloc, NewUserState>(
        builder: (ctx, state) {
          if (state is NewUserUninitialized) {
            Future.microtask(() async => await pr.show());
            return Center(child: Text('Uninitialized State'));
          } else if (state is NewUserEmpty) {
            Future.delayed(Duration(seconds: 1)).then((value) {
              pr.hide();
            });
            return Center(child: Text('No Data Found'));
          } else if (state is NewUserError) {
            final stateError = state;
            DioError dioError = stateError.dioError;
            Utils().onError(_scaffoldKey, dioError, context);
            Future.delayed(Duration(seconds: 1)).then((value) {
              pr.hide();
            });

            return Center(
              child: Text(dioError.response.toString()),
            );
          } else {
            isLoading = false;
            isEndOfResult = false;
            Future.delayed(Duration(seconds: 1)).then((value) {
              pr.hide();
            });
            final stateAsListFetched = state as NewUserFetched;

            ResponseDio responseDio = stateAsListFetched.responsedio;
            NewUserFeed newUserFeed = responseDio.data;
            if (totalData == null) {
              minMove = initialMin;
              maxMove = initialMax;
            }
            totalData = int.parse(newUserFeed.totalData);

            if (!isSearch) {
              if (stateAsListFetched.refresh) newUser.clear();

              newUser.addAll(newUserFeed.data);
              print(newUser);
            } else {
              totalDataTemp = totalData;
              totalData = int.parse(newUserFeed.totalData);

              newUserTemp.addAll(newUser);
              newUser.clear();
              newUser.addAll(newUserFeed.data);
            }

            return NotificationListener(
              onNotification: onNotification,
              child: GridView.builder(
                  padding: EdgeInsets.only(top: 0),
                  controller: scrollController,
                  itemCount:
                      isEndOfResult ? newUser.length : newUser.length + 2,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 0.0,
                      childAspectRatio: 4.0,
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext ctx, int idx) {
                    return idx >= newUser.length
                        ? _buildLoaderItem()
                        : _buildListItem(idx);
                  }),
            );
          }
        },
      ),
    );
  }

  bool onNotification(ScrollNotification notification) {
    var innerPos = scrollController.position.pixels;
    var maxOuterPos = widget.scrollControllers.position.maxScrollExtent;
    var currentOutPos = widget.scrollControllers.position.pixels;
    if (innerPos >= 0 && currentOutPos < maxOuterPos) {
      //print("parent pos " + currentOutPos.toString() + "max parent pos " + maxOuterPos.toString());
      widget.scrollControllers.position.moveTo(innerPos + currentOutPos);
    } else {
      var currenParentPos = innerPos + currentOutPos;
      if (innerPos == 0)
        widget.scrollControllers.position.moveTo(0);
      else
        widget.scrollControllers.position.moveTo(currenParentPos);

    }
    if (!isEnded) {
      if (notification is ScrollUpdateNotification) {
        if (scrollController.position.maxScrollExtent ==
            scrollController.offset) {
          if (minMove >= totalData) {
            minMove = initialMin;
            maxMove = initialMax;
            maxMoveTemp = initialMax;
            minMoveTemp = initialMin;
            isEnded = true;
            _scaffoldKey.currentState.removeCurrentSnackBar();
            _scaffoldKey.currentState
                .showSnackBar(SnackBar(content: Text('Already End of Page')));
          } else {
            isEndOfResult = true;
            if (!isLoading) {
              minMove = maxMove + 1;
              maxMove = maxMove + initialMax;
              if (!isSearch) {
                isLoading = true;
                _newUserBloc = BlocProvider.of<NewUserBloc>(context);
                _newUserBloc.add(LoadMoreEvent(
                    widget.jobCd,
                    widget.strCd,
                    widget.empNo,
                    widget.corpFg,
                    widget.directorat,
                    minMove,
                    maxMove,
                    totalData));
              } else {
                isLoading = true;
                // listBloc.add(LoadMoreSearchEvent(
                //     widget.jobCd,
                //     widget.strCd,
                //     widget.empNo,
                //     widget.corpFg,
                //     minMove,
                //     maxMove,
                //     totalData,
                //     selectedSearch.id,
                //     searchController.text));
              }
            } else {
              _scaffoldKey.currentState.removeCurrentSnackBar();
              _scaffoldKey.currentState.showSnackBar(
                  SnackBar(content: Text('Still Processing Request....')));
            }
          }
        }
      }
    }

    return true;
  }
}
