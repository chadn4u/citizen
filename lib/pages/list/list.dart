
import 'package:citizens/bloc/list/blocList.dart';
import 'package:citizens/bloc/list/blocListEvents.dart';
import 'package:citizens/bloc/list/blocListState.dart';
import 'package:citizens/models/list/ListData.dart';
import 'package:citizens/models/list/listFeed.dart';
import 'package:citizens/models/list/searchList.dart';
import 'package:citizens/models/responseDio/responseDio.dart';
import 'package:citizens/utils/mainUtils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:citizens/pages/list/detail/listDetail.dart';

import '../loginpages.dart';

class ListData extends StatefulWidget {
  final String jobCd;
  final String strCd;
  final String empNo;
  final String corpFg;

  const ListData({Key key, this.jobCd, this.strCd, this.empNo, this.corpFg})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final searchController = TextEditingController();
  final List<ListDataModel> lstData = [];
  final List<ListDataModel> lstDataSearch = [];
  final List<ListDataModel> lstDataTemp = [];
  final int initialMin = 0;
  final int initialMax = 20;
  var stateAsListFetched;
  int minMove;
  int maxMove;
  int minMoveTemp;
  int maxMoveTemp;
  int totalData;
  int totalDataTemp;
  bool isEnded = false;
  bool isLoading = false;
  bool isSearch = false;
  Map<String, dynamic> dataForRequest = new Map();
  ScrollController scrollController = new ScrollController();

  ListBloc listBloc;
  // final AsyncMemoizer _memoizer = AsyncMemoizer();

  // _fetchData() {
  //   return this._memoizer.runOnce(() async {
  //     await Future.delayed(Duration(seconds: 2));
  //     return ApiRepository().getListRepo(dataForRequest);
  //   });
  // }

  List<DropdownMenuItem<SearchList>> _dropdownMenuItems;
  SearchList selectedSearch;

  _createCard(ListDataModel listDataModel, ctx) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => DetailList(
                      corpFg: listDataModel.corpFg,
                      empNo: listDataModel.empNo,
                      jobNm: listDataModel.jobNm,
                      name: listDataModel.empNm,
                      strCd: listDataModel.strNm,
                    )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                  color: Colors.blue[900],
                  blurRadius: 20,
                  offset: Offset(0, 10))
            ]),
        child: ListTile(
          leading: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  listDataModel.corpFg,
                  style: TextStyle(color: Colors.blue, fontSize: 25),
                ),
              ],
            ),
          ),
          title: Container(
            child: Text(listDataModel.empNm,
                style: TextStyle(color: Colors.blue, fontSize: 22)),
          ),
          subtitle: Container(
            child: Row(
              children: <Widget>[
                Text(
                  listDataModel.jobNm,
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                color: Colors.white,
                child: InkWell(
                  splashColor: Colors.blue[900], // inkwell color
                  child: SizedBox(
                      width: 33, height: 33, child: Icon(Icons.more_horiz)),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
            if (!isLoading) {
              minMove = maxMove + 1;
              maxMove = maxMove + initialMax;
              // dataForRequest['min'] =
              //     minMove >= totalData ? totalData : minMove;
              // dataForRequest['max'] =
              //     maxMove >= totalData ? totalData : maxMove;

              if (!isSearch) {
                isLoading = true;
                listBloc.add(LoadMoreEvent(widget.jobCd, widget.strCd,
                    widget.empNo, widget.corpFg, minMove, maxMove, totalData));
              } else {
                isLoading = true;
                listBloc.add(LoadMoreSearchEvent(
                    widget.jobCd,
                    widget.strCd,
                    widget.empNo,
                    widget.corpFg,
                    minMove,
                    maxMove,
                    totalData,
                    selectedSearch.id,
                    searchController.text));
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
    listBloc.close();
    super.dispose();
  }

  List<DropdownMenuItem<SearchList>> buildDropdownMenuItems(List searchlistss) {
    List<DropdownMenuItem<SearchList>> items = List();
    for (SearchList searchlist in searchlistss) {
      items.add(
        DropdownMenuItem(
          value: searchlist,
          child: Text(searchlist.searchKey),
        ),
      );
    }
    return items;
  }

  @override
  void initState() {
    super.initState();

    _dropdownMenuItems = buildDropdownMenuItems(SearchList.getList());
    selectedSearch = _dropdownMenuItems[0].value;
    listBloc = ListBloc();
    listBloc.add(FirstLoadEvent(
        widget.jobCd, widget.strCd, widget.empNo, widget.corpFg, 0, 20));
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    return BlocProvider(
      create: (BuildContext context) => listBloc,
      child: Scaffold(
        key: _scaffoldKey,
        extendBody: true,
        body: BlocBuilder<ListBloc, ListState>(builder: (ctx, state) {
          if (state is ListUninitializedState) {
            return Center(child: Text('Uninitialized State'));
          } else if (state is ListEmptyState) {
            return Center(child: Text('No Data Found'));
          } else if (state is ListErrorState) {
            final stateError = state as ListErrorState;
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
                  _scaffoldKey.currentState
                      .showSnackBar(SnackBar(content: Text('Send Timeout')));
                });

                break;
              case DioErrorType.RECEIVE_TIMEOUT:
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scaffoldKey.currentState.removeCurrentSnackBar();
                  _scaffoldKey.currentState
                      .showSnackBar(SnackBar(content: Text('Receive Timeout')));
                });

                break;
              case DioErrorType.RESPONSE:
                if (dioError.response.toString().contains('Invalid Token')) {
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
                        content:
                            Text('Error ${dioError.response.toString()}')));
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
            if (state is ListFetchedState) {
              stateAsListFetched = state as ListFetchedState;
            } else {
              stateAsListFetched = state as ListFetchedSearchState;
            }
            ResponseDio responseDio = stateAsListFetched.responsedio;
            ListFeed listFeed = responseDio.data;
            //dataForRequest['totalData'] = listFeed.totalData;
            minMove = initialMin;
            maxMove = initialMax;
            totalData = int.parse(listFeed.totalData);
            if (!isSearch)
              lstData.addAll(listFeed.data);
            else {
              totalDataTemp = totalData;
              totalData = int.parse(listFeed.totalData);

              lstDataTemp.addAll(lstData);
              lstData.clear();
              lstData.addAll(listFeed.data);
            }

            return NotificationListener(
              onNotification: onNotification,
              child: Container(
                color: Colors.blue[900],
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    controller: scrollController,
                    itemCount: lstData.length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      return Dismissible(
                        key: Key(lstData[idx].empNo),
                        child: _createCard(lstData[idx], context),
                        direction: DismissDirection.startToEnd,
                        confirmDismiss: (direction) async {
                          final bool res = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text(
                                      "Want to see the detail of ${lstData[idx].empNm} ? "),
                                  actions: <Widget>[
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
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailList(
                                                      corpFg:
                                                          lstData[idx].corpFg,
                                                      empNo: lstData[idx].empNo,
                                                      jobNm: lstData[idx].jobNm,
                                                      name: lstData[idx].empNm,
                                                      strCd: lstData[idx].strNm,
                                                    )));
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
            );
          }
        }),
        bottomNavigationBar: Container(
          height: 55,
          child: BottomAppBar(
            color: Colors.blue[900],
            shape: CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                    iconSize: 22,
                    padding: EdgeInsets.only(left: 20),
                    color: Colors.white,
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (isSearch) {
                setState(() {
                  minMove = minMoveTemp;
                  maxMove = maxMoveTemp;
                  totalData = totalDataTemp;

                  minMoveTemp = 0;
                  maxMoveTemp = initialMax;
                  totalDataTemp = null;

                  isSearch = false;
                  lstData.clear();
                  lstData.addAll(lstDataTemp);
                  lstDataTemp.clear();
                });
              } else {
                _settingModalBottomSheet(context);
              }
            },
            backgroundColor: Colors.blue[900],
            child: Icon(
              isSearch ? Icons.close : Icons.search,
              color: Colors.white,
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(
            builder: (BuildContext ctx, StateSetter state) {
              return Container(
                padding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: new Wrap(
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[100]))),
                        child: DropdownButton<SearchList>(
                            isExpanded: true,
                            value: selectedSearch,
                            items: _dropdownMenuItems,
                            onChanged: (SearchList selected) {
                              state(() {
                                selectedSearch = selected;
                              });
                            })),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[200]))),
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: selectedSearch.searchKey,
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: Colors.blue[900]),
                          width: double.infinity,
                          child: FlatButton(
                              onPressed: () {
                                isSearch = true;
                                minMoveTemp = minMove;
                                maxMoveTemp = maxMove;
                                minMove = initialMin;
                                maxMove = initialMax;
                                // dataForRequest['min'] = minMove;
                                // dataForRequest['max'] = maxMove;
                                // dataForRequest['totalData'] = null;
                                // dataForRequest['pilihan'] = selectedSearch.id;
                                // dataForRequest['konten'] =
                                //     searchController.text;
                                listBloc.add(FirstLoadSearchEvent(
                                    widget.jobCd,
                                    widget.strCd,
                                    widget.empNo,
                                    widget.corpFg,
                                    minMove,
                                    maxMove,
                                    selectedSearch.id,
                                    searchController.text));

                                Navigator.pop(context);
                              },
                              child: Text(
                                'Search',
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
