import 'package:citizens/bloc/newUser/newUserBloc.dart';
import 'package:citizens/bloc/newUser/newUserEvents.dart';
import 'package:citizens/bloc/newUser/newUserState.dart';
import 'package:citizens/models/newUser/newUser.dart';
import 'package:citizens/models/newUser/newUserFeed.dart';
import 'package:citizens/models/responseDio/responseDio.dart';
import 'package:citizens/utils/mainUtils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rounded_letter/rounded_letter.dart';
import 'package:rounded_letter/shape_type.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

import '../loginpages.dart';

class NewUserMain extends StatefulWidget {
  final String jobCd;
  final String strCd;
  final String empNo;
  final String corpFg;
  final String directorat;

  const NewUserMain(
      {Key key,
      this.jobCd,
      this.strCd,
      this.empNo,
      this.corpFg,
      this.directorat})
      : super(key: key);
  @override
  _NewUserMainState createState() => _NewUserMainState();
}

class _NewUserMainState extends State<NewUserMain> {
  List<Widget> _listWidget = [];
  final List<NewUser> newUser = [];
  final List<NewUser> newUserSearch = [];
  final List<NewUser> newUserTemp = [];
  final int initialMin = 0;
  final int initialMax = 20;
  final TextEditingController employeeNo = TextEditingController();
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

  bool sap = false;
  bool gmd = false;
  bool b2b = false;
  bool inet = false;
  bool email = false;
  bool wifi = false;
  bool mEmail = false;
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
                    pr.hide();
                    final stateError = state as NewUserError;
                    DioError dioError = stateError.dioError;
                    switch (dioError.type) {
                      case DioErrorType.CONNECT_TIMEOUT:
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _scaffoldKey.currentState.removeCurrentSnackBar();
                          _scaffoldKey.currentState.showSnackBar(
                              SnackBar(content: Text('Connection Timeout')));
                        });

                        break;
                      case DioErrorType.SEND_TIMEOUT:
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _scaffoldKey.currentState.removeCurrentSnackBar();
                          _scaffoldKey.currentState.showSnackBar(
                              SnackBar(content: Text('Send Timeout')));
                        });

                        break;
                      case DioErrorType.RECEIVE_TIMEOUT:
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _scaffoldKey.currentState.removeCurrentSnackBar();
                          _scaffoldKey.currentState.showSnackBar(
                              SnackBar(content: Text('Receive Timeout')));
                        });

                        break;
                      case DioErrorType.RESPONSE:
                        if (dioError.response
                            .toString()
                            .contains('Invalid Token')) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            _scaffoldKey.currentState.removeCurrentSnackBar();
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Token Expired.... try Relogin'),
                                action: SnackBarAction(
                                  label: 'Relogin',
                                  onPressed: () {
                                    Utils().logout(LoginPages(), context);
                                  },
                                )));
                          });
                        } else {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            _scaffoldKey.currentState.removeCurrentSnackBar();
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text(
                                    'Error ${dioError.response.toString()}')));
                          });
                        }

                        break;
                      case DioErrorType.CANCEL:
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _scaffoldKey.currentState.removeCurrentSnackBar();
                          _scaffoldKey.currentState.showSnackBar(
                              SnackBar(content: Text('Operation Cancelled')));
                        });

                        break;
                      case DioErrorType.DEFAULT:
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _scaffoldKey.currentState.removeCurrentSnackBar();
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text(
                                  'Failed host lookup, Please make sure you have used Lotte Connection')));
                        });

                        break;
                    }
                    return Center(
                      child: Text(dioError.response.toString()),
                    );
                  } else {
                    isLoading = false;
                    isEndOfResult = false;
                    pr.hide();
                    final stateAsListFetched = state as NewUserFetched;

                    ResponseDio responseDio = stateAsListFetched.responsedio;
                    NewUserFeed newUserFeed = responseDio.data;
                    if (totalData == null) {
                      minMove = initialMin;
                      maxMove = initialMax;
                    }

                    totalData = int.parse(newUserFeed.totalData);
                    if (!isSearch)
                      newUser.addAll(newUserFeed.data);
                    else {
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

  //input widget
  Widget _input(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: TextField(
        decoration:
            InputDecoration(labelText: label, hoverColor: Colors.blue[900]),
        controller: controller,
        //  controller: amountController,
        //  onSubmitted: (_) => submitData(),
      ),
    );
  }

  _showBottomSheet() {
    _scaffoldKey.currentState
        .showBottomSheet<void>((BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext ctx, StateSetter state) {
            return DecoratedBox(
              decoration: BoxDecoration(color: Colors.transparent),
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(28),
                            topRight: Radius.circular(28)),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.grey,
                                    ),
                                    child: Icon(Icons.close),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'ADD',
                                  style: TextStyle(color: Colors.blue[900]),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  _input('Employee No', employeeNo),
                                  _input('Employee Name', employeeNo),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Request Application :',
                                              style: TextStyle(
                                                  color: Colors.blue[900])),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      _checkbox('SAP', sap, state),
                                      _checkbox('GMD', gmd, state),
                                      _checkbox('B2B', b2b, state),
                                      _checkbox('INTERNET', inet, state),
                                      _checkbox('Email', email, state),
                                      _checkbox('Wi-Fi', wifi, state),
                                      _checkbox('Mobile Email', mEmail, state),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Division :',
                                              style: TextStyle(
                                                  color: Colors.blue[900])),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Division :',
                                              style: TextStyle(
                                                  color: Colors.blue[900])),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Division :',
                                              style: TextStyle(
                                                  color: Colors.blue[900])),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Division :',
                                              style: TextStyle(
                                                  color: Colors.blue[900])),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Division :',
                                              style: TextStyle(
                                                  color: Colors.blue[900])),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      )),
                ),
              ),
            );
          });
        })
        .closed
        .whenComplete(() {});
  }

  Widget _checkbox(String title, bool boolValue, StateSetter state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 10),
        ),
        Checkbox(
          value: boolValue,
          onChanged: (bool value) {
            state(() {
              switch (title) {
                case 'SAP':
                  sap = value;
                  break;
                case 'GMD':
                  gmd = value;
                  break;
                case 'B2B':
                  b2b = value;
                  break;
                case 'INTERNET':
                  inet = value;
                  break;
                case 'Email':
                  email = value;
                  break;
                case 'Wi-Fi':
                  wifi = value;
                  break;
                case 'Mobile Email':
                  mEmail = value;
                  break;
              }
            });
          },
        )
      ],
    );
  }

  Widget _buildListItem(int idx) {
    return InkWell(
      onTap: () {
        _showBottomSheet();
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
