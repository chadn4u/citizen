import 'package:citizens/bloc/newUser/newUserBloc.dart';
import 'package:citizens/bloc/newUser/newUserEvents.dart';
import 'package:citizens/bloc/newUser/newUserState.dart';
import 'package:citizens/models/newUser/newUser.dart';
import 'package:citizens/models/newUser/newUserFeed.dart';
import 'package:citizens/models/responseDio/responseDio.dart';
import 'package:citizens/utils/mainUtils.dart';
import 'package:citizens/widget/newUser/modalBottom.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rounded_letter/rounded_letter.dart';
import 'package:rounded_letter/shape_type.dart';


class NewUserMain extends StatefulWidget {
  final String jobCd;
  final String strCd;
  final String empNo;
  final String corpFg;
  final String allCorp;
  final String directorat;

  const NewUserMain(
      {Key key,
      this.jobCd,
      this.strCd,
      this.empNo,
      this.corpFg,
      this.directorat, this.allCorp})
      : super(key: key);
  @override
  _NewUserMainState createState() => _NewUserMainState();
}

class _NewUserMainState extends State<NewUserMain> {
  final List<NewUser> newUser = [];
  final List<NewUser> newUserSearch = [];
  final List<NewUser> newUserTemp = [];
  final int initialMin = 0;
  final int initialMax = 20;

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
  NewUserBloc newUserBloc;
  ScrollController scrollController = new ScrollController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TabBar _tabBar = TabBar(
    tabs: <Widget>[
      Tab(
        icon: Icon(Icons.file_upload),
        text: "Submit Requests",
      ),
      Tab(
        icon: Icon(Icons.library_books),
        text: "Request Status",
      )
    ],
  );

  bool onNotification(ScrollNotification notification) {
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
                newUserBloc.add(LoadMoreEvent(
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

  @override
  void dispose() {
    newUserBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    newUserBloc = NewUserBloc();
    newUserBloc.add(FirstLoadEvent(widget.jobCd, widget.strCd, widget.empNo,
        widget.corpFg, widget.directorat, 0, 20, null));
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog pr =
        ProgressDialog(context, isDismissible: true, showLogs: true);
    pr.style(message: 'Please Wait...');
    return BlocProvider(
      create: (BuildContext context) => newUserBloc,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.blue[900],
            title: Text('New User'),
            bottom: _tabBar,
          ),
          body: TabBarView(
            children: <Widget>[
              BlocBuilder<NewUserBloc, NewUserState>(
                builder: (ctx, state) {
                  if (state is NewUserUninitialized) {
                    Future.microtask(() async => await pr.show());
                    return Center(child: Text('Uninitialized State'));
                  } else if (state is NewUserEmpty) {
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
                          controller: scrollController,
                          itemCount: isEndOfResult
                              ? newUser.length
                              : newUser.length + 2,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
              Center(child: Text('Tab 1')),
            ],
          ),
        ),
      ),
    );
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
            corpFg: widget.corpFg,
            strCd: widget.strCd,
            jobCd: widget.jobCd,
            directorat: widget.directorat,
            empNo: widget.empNo,
            totalData: totalData,
            allCorp: widget.allCorp,
            maxMove: maxMove,
            doj: newUser[idx].doj,
            empNm: newUser[idx].empNm,
            level: newUser[idx].levelEmp,
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
          color: Colors.blue[900],
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
}
