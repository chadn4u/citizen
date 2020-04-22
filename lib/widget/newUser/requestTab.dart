import 'package:citizens/bloc/newUser/requestStatus/requestStatusBloc.dart';
import 'package:citizens/bloc/newUser/requestStatus/requestStatusEvents.dart';
import 'package:citizens/bloc/newUser/requestStatus/requestStatusState.dart';
import 'package:citizens/models/newUser/requestStatusDetail.dart';
import 'package:citizens/models/newUser/requestStatusFeed.dart';
import 'package:citizens/models/responseDio/responseDio.dart';
import 'package:citizens/utils/mainUtils.dart';
import 'package:data_tables/data_tables.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';

class RequestStatus extends StatefulWidget {
  final String jobCd;
  final String strCd;
  final String empNo;
  final String corpFg;
  final String allCorp;
  final String directorat;

  const RequestStatus(
      {Key key,
      this.jobCd,
      this.strCd,
      this.empNo,
      this.corpFg,
      this.allCorp,
      this.directorat})
      : super(key: key);

  @override
  _RequestStatusState createState() => _RequestStatusState();
}

class _RequestStatusState extends State<RequestStatus> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  RequestStatusBloc requestStatusBloc;

  @override
  void initState() {
    requestStatusBloc = RequestStatusBloc();
    requestStatusBloc.add(FirstLoadEventRS(widget.jobCd, widget.strCd,
        widget.empNo, widget.corpFg, widget.directorat, widget.allCorp));
    super.initState();
  }

  @override
  void dispose() {
    requestStatusBloc.close();
    super.dispose();
  }

  void _sort<T>(Comparable<T> getField(RequestStatusDetail d), int columnIndex,
      bool ascending) {
    _items.sort((RequestStatusDetail a, RequestStatusDetail b) {
      if (!ascending) {
        final RequestStatusDetail c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  List<RequestStatusDetail> _items = [];
  int _rowsOffset = 0;

  @override
  Widget build(BuildContext context) {
    ProgressDialog pr =
        ProgressDialog(context, isDismissible: true, showLogs: true);
    pr.style(message: 'Please Wait...');
    return BlocProvider(
      create: (BuildContext context) => requestStatusBloc,
      child: Scaffold(
          key: _scaffoldKey,
          body: BlocBuilder<RequestStatusBloc, RequestStatusState>(
            builder: (ctx, state) {
              if (state is UninitializedStateRS) {
                Future.microtask(() async => await pr.show());
                return Center(child: Text('Uninitialized State'));
              } else if (state is EmptyStateRS) {
                return Center(child: Text('No Data Found'));
              } else if (state is ErrorStateRS) {
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
                Future.delayed(Duration(seconds: 1)).then((value) {
                  pr.hide();
                });

                final stateAsListFetched = state as FetchedStateRS;

                ResponseDio responseDio = stateAsListFetched.responsedio;
                RequestStatusFeed requestStatusFeed = responseDio.data;

                if (_items.length > 0) {
                  _items.clear();
                }

                _items.addAll(requestStatusFeed.data);

                return NativeDataTable.builder(
                  rowsPerPage: _rowsPerPage,
                  itemCount: _items?.length ?? 0,
                  firstRowIndex: _rowsOffset,
                  handleNext: () async {
                    _rowsOffset += _rowsPerPage;

                    await new Future.delayed(new Duration(seconds: 3));
                    // setState(() {
                    // _items += [
                    //   Dessert('New Item 4', 159, 6.0, 24, 4.0, 87, 14, 1),
                    //   Dessert('New Item 5', 159, 6.0, 24, 4.0, 87, 14, 1),
                    //   Dessert('New Item 6', 159, 6.0, 24, 4.0, 87, 14, 1),
                    // ];
                    // });
                  },
                  handlePrevious: () {
                    _rowsOffset -= _rowsPerPage;
                  },
                  itemBuilder: (int index) {
                    final RequestStatusDetail dessert = _items[index];
                    return DataRow.byIndex(
                        index: index,
                        cells: <DataCell>[  
                          DataCell(Text('${dessert.empNm}'),onTap: (){}),
                          DataCell(Text('${dessert.empNo}'),onTap: (){}),
                          DataCell(Text('${dessert.doj}'),onTap: (){}),
                          DataCell(Text('${dessert.emailFgNm}'),onTap: (){}),
                          DataCell(Text('${dessert.emailStatus}'),onTap: (){}),
                          DataCell(Text('${dessert.sapFgNm}'),onTap: (){}),
                          DataCell(Text('${dessert.sapStatus}'),onTap: (){}),
                          DataCell(Text('${dessert.b2bFgNm}'),onTap: (){}),
                          DataCell(Text('${dessert.b2bStatus}'),onTap: (){}),
                          DataCell(Text('${dessert.netFgNm}'),onTap: (){}),
                          DataCell(Text('${dessert.netStatus}'),onTap: (){}),
                          DataCell(Text('${dessert.gmdFgNm}'),onTap: (){}),
                          DataCell(Text('${dessert.gmdStatus}'),onTap: (){}),
                          DataCell(Text('${dessert.wifiFgNm}'),onTap: (){}),
                          DataCell(Text('${dessert.wifiStatus}'),onTap: (){}),
                          DataCell(Text('${dessert.mobileFgNm}'),onTap: (){}),
                          DataCell(Text('${dessert.mobileStatus}'),onTap: (){}),
                          DataCell(Text('${dessert.reqDate}'),onTap: (){}),
                          DataCell(Text('${dessert.reqUserNm}'),onTap: (){}),
                          DataCell(Text('${dessert.directorat}'),onTap: (){}),
                          DataCell(Text('${dessert.strCd}'),onTap: (){}),
                          DataCell(Text('${dessert.corpFg}'),onTap: (){}),
                        ]);
                  },
                  header: const Text('Data Management'),
                  sortColumnIndex: _sortColumnIndex,
                  sortAscending: _sortAscending,
                  onRefresh: () async {
                    pr.show();
                    await new Future.delayed(new Duration(seconds: 3));

                    requestStatusBloc.add(FirstLoadEventRS(
                        widget.jobCd,
                        widget.strCd,
                        widget.empNo,
                        widget.corpFg,
                        widget.directorat,
                        widget.allCorp));
                    return null;
                  },
                  onRowsPerPageChanged: (int value) {
                    _rowsPerPage = value;

                    print("New Rows: $value");
                  },
                  // mobileItemBuilder: (BuildContext context, int index) {
                  //   final i = _desserts[index];
                  //   return ListTile(
                  //     title: Text(i?.name),
                  //   );
                  // },
                  // onSelectAll: (bool value) {
                  //   for (var row in _items) {
                  //     row.selected = value;
                  //   }
                  // },
                  rowCountApproximate: true,
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.info_outline),
                      onPressed: () {},
                    ),
                  ],
                  // selectedActions: <Widget>[],
                  columns: <DataColumn>[
                    DataColumn(
                        label: const Text('Employee Name'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((RequestStatusDetail d) => d.empNm,
                                columnIndex, ascending)),
                    DataColumn(
                        label: const Text('Employee No'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((RequestStatusDetail d) => d.empNo,
                                columnIndex, ascending)),
                    DataColumn(
                        label: const Text('Date of Join'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((RequestStatusDetail d) => d.doj,
                                columnIndex, ascending)),
                    DataColumn(
                        label: const Text('Email Request'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (RequestStatusDetail d) => d.emailFgNm,
                                columnIndex,
                                ascending)),
                    DataColumn(
                        label: const Text('Email Request Status'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (RequestStatusDetail d) => d.emailStatus,
                                columnIndex,
                                ascending)),
                    DataColumn(
                        label: const Text('SAP Request'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((RequestStatusDetail d) => d.sapFgNm,
                                columnIndex, ascending)),
                    DataColumn(
                        label: const Text('SAP Request Status'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (RequestStatusDetail d) => d.sapStatus,
                                columnIndex,
                                ascending)),
                    DataColumn(
                        label: const Text('B2B Request'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((RequestStatusDetail d) => d.b2bFgNm,
                                columnIndex, ascending)),
                    DataColumn(
                        label: const Text('B2B Request Status'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (RequestStatusDetail d) => d.b2bStatus,
                                columnIndex,
                                ascending)),
                    DataColumn(
                        label: const Text('Internet Request'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((RequestStatusDetail d) => d.netFgNm,
                                columnIndex, ascending)),
                    DataColumn(
                        label: const Text('Internet Request Status'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (RequestStatusDetail d) => d.netStatus,
                                columnIndex,
                                ascending)),
                    DataColumn(
                        label: const Text('GMD Request'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((RequestStatusDetail d) => d.gmdFgNm,
                                columnIndex, ascending)),
                    DataColumn(
                        label: const Text('GMD Request Status'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (RequestStatusDetail d) => d.gmdStatus,
                                columnIndex,
                                ascending)),
                    DataColumn(
                        label: const Text('Wifi Request'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((RequestStatusDetail d) => d.wifiFgNm,
                                columnIndex, ascending)),
                    DataColumn(
                        label: const Text('Wifi Request Status'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (RequestStatusDetail d) => d.wifiStatus,
                                columnIndex,
                                ascending)),
                    DataColumn(
                        label: const Text('Mobile Request'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (RequestStatusDetail d) => d.mobileFgNm,
                                columnIndex,
                                ascending)),
                    DataColumn(
                        label: const Text('Mobile Request Status'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (RequestStatusDetail d) => d.mobileStatus,
                                columnIndex,
                                ascending)),
                    DataColumn(
                        label: const Text('Request Date'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((RequestStatusDetail d) => d.reqDate,
                                columnIndex, ascending)),
                    DataColumn(
                        label: const Text('Request By'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (RequestStatusDetail d) => d.reqUserNm,
                                columnIndex,
                                ascending)),
                    DataColumn(
                        label: const Text('Directorat'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (RequestStatusDetail d) => d.directorat,
                                columnIndex,
                                ascending)),
                    DataColumn(
                        label: const Text('Store'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((RequestStatusDetail d) => d.strCd,
                                columnIndex, ascending)),
                    DataColumn(
                        label: const Text('Comp'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((RequestStatusDetail d) => d.corpFg,
                                columnIndex, ascending)),
                  ],
                );
              }
            },
          )),
    );
  }
}
