import 'package:citizens/bloc/newUser/bottomSheet/bottomBloc.dart';
import 'package:citizens/bloc/newUser/bottomSheet/bottomEvent.dart';
import 'package:citizens/bloc/newUser/bottomSheet/bottomState.dart';
import 'package:citizens/bloc/newUser/newUserBloc.dart';
import 'package:citizens/bloc/newUser/newUserEvents.dart';
import 'package:citizens/models/newUser/division.dart';
import 'package:citizens/models/newUser/divisionFeed.dart';
import 'package:citizens/models/newUser/newUserFeed.dart';
import 'package:citizens/models/newUser/store.dart';
import 'package:citizens/models/newUser/storeFeed.dart';
import 'package:citizens/models/responseDio/responseDio.dart';
import 'package:citizens/utils/mainUtils.dart';
import 'package:dio/dio.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewUserBottom extends StatefulWidget {
  final String jobCd;
  final String strCd;
  final String empNo;
  final String empNm;
  final String doj;
  final String level;
  final String corpFg;
  final String directorat;
  final String allCorp;
  final int totalData;
  final int maxMove;

  NewUserBottom(
      {Key key,
      this.jobCd,
      this.strCd,
      this.empNo,
      this.corpFg,
      this.directorat,
      this.totalData,
      this.maxMove,
      this.allCorp, this.empNm, this.doj, this.level})
      : super(key: key);

  @override
  _NewUserBottomState createState() => _NewUserBottomState();
}

class _NewUserBottomState extends State<NewUserBottom> {
  final TextEditingController employeeNo = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool sap = false;
  bool gmd = false;
  bool b2b = false;
  bool inet = false;
  bool email = false;
  bool wifi = false;
  bool mEmail = false;
  String _groupValue = "";
  List<DropdownMenuItem<Division>> _dropdownMenuItems;
  final List<Division> lstDivision = [];
  List<DropdownMenuItem<Stores>> _dropdownMenuItemsStores;
  final List<Stores> lstStores = [];
  NewUserBloc _newUserBloc;
  BottomBloc _bottomBloc;
  ResponseDio _responseDio;
  DivisionFeed _divisionFeed;
  StoreFeed _storeFeed;
  String directorat;

  Division _selected;
  Stores _selectedStore;

  //input widget
  Widget _input(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: TextField(
        showCursor: false,
        decoration:
            InputDecoration(labelText: label, hoverColor: Colors.blue[900]),
        controller: controller,
        //  controller: amountController,
        //  onSubmitted: (_) => submitData(),
      ),
    );
  }

  Widget _checkbox(String title, bool boolValue) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 10, color: Colors.blue[900]),
        ),
        Theme(
          data: ThemeData(unselectedWidgetColor: Colors.blue[900]),
          child: Checkbox(
            activeColor: Colors.blue[900],
            value: boolValue,
            onChanged: (bool value) {
              setState(() {
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
          ),
        )
      ],
    );
  }

  _company() {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Company :',
              style: TextStyle(color: Colors.blue[900]),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Theme(
                        data:
                            ThemeData(unselectedWidgetColor: Colors.blue[900]),
                        child: Radio(
                          value: '04',
                          groupValue: _groupValue,
                          onChanged: (value) {
                            setState(() {
                              _groupValue = value;
                            });
                          },
                        ),
                      ),
                      Text(
                        'LMI',
                        style: TextStyle(color: Colors.blue[900]),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Theme(
                        data:
                            ThemeData(unselectedWidgetColor: Colors.blue[900]),
                        child: Radio(
                          value: '06',
                          groupValue: _groupValue,
                          onChanged: (value) {
                            setState(() {
                              _groupValue = value;
                            });
                          },
                        ),
                      ),
                      Text(
                        'LSI',
                        style: TextStyle(color: Colors.blue[900]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _division() {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Division :', style: TextStyle(color: Colors.blue[900])),
                Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[100]))),
                    child: DropdownButton<Division>(
                        isExpanded: false,
                        value: _selected != null ? _selected : null,
                        items: _dropdownMenuItems,
                        onChanged: (Division selected) {
                          setState(() {
                            _selected = selected;
                          });
                        }))
              ],
            ),
          ],
        ),
      ),
    );
  }

  _store() {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Store :', style: TextStyle(color: Colors.blue[900])),
                Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[100]))),
                    child: DropdownButton<Stores>(
                        isExpanded: false,
                        value: _selectedStore != null ? _selectedStore : null,
                        items: _dropdownMenuItemsStores,
                        onChanged: (Stores selected) {
                          setState(() {
                            _selectedStore = selected;
                          });
                        }))
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    directorat = widget.directorat == null? "Tidak Tahu":widget.directorat;
    _bottomBloc = BottomBloc();
    _bottomBloc.add(GetDivisionEvent(widget.jobCd, widget.strCd));
    _bottomBloc.add(GetStoreEvent(widget.strCd, widget.jobCd, widget.allCorp));

    
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<DropdownMenuItem<Division>> buildDropdownMenuItems(List divisionList) {
    List<DropdownMenuItem<Division>> items = List();
    for (Division divisionLists in divisionList) {
      items.add(
        DropdownMenuItem(
          value: divisionLists,
          child: Text(
            divisionLists.detailNm,
            style: TextStyle(color: Colors.blue[900]),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }

    return items;
  }

  List<DropdownMenuItem<Stores>> buildDropdownMenuItemsStores(List storeList) {
    List<DropdownMenuItem<Stores>> items = List();
    for (Stores storeLists in storeList) {
      items.add(
        DropdownMenuItem(
          value: storeLists,
          child: Text(
            "${storeLists.strCd} - ${storeLists.strNm}",
            style: TextStyle(color: Colors.blue[900], fontSize: 10),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      key: _scaffoldKey,
      create: (BuildContext ctx) => _bottomBloc,
      child: DecoratedBox(
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
                                color: Colors.blue[900],
                              ),
                              child: Icon(Icons.close,color: Colors.white,),
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
                            style: TextStyle(
                                color: Colors.blue[900], fontSize: 24),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(3, 3, 3, 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: Colors.blue[900], width: 1)),
                          child: ExpandablePanel(
                            header: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Employee Information',
                                style: TextStyle(color: Colors.blue[900]),
                              ),
                            ),
                            expanded: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Employee Id',style: TextStyle(color:Colors.blue[900]),),
                                        Text('Employee Name',style: TextStyle(color:Colors.blue[900])),
                                        Text('Directorat',style: TextStyle(color:Colors.blue[900])),
                                        Text('Date of Join',style: TextStyle(color:Colors.blue[900])),
                                        Text('Level',style: TextStyle(color:Colors.blue[900])),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(': ${widget.empNo}',style: TextStyle(color:Colors.blue[900])),
                                        Text(': ${widget.empNm}',style: TextStyle(color:Colors.blue[900])),
                                        Text(': $directorat',style: TextStyle(color:Colors.blue[900])),
                                        Text(': ${widget.doj}',style: TextStyle(color:Colors.blue[900])),
                                        Text(': ${widget.level == null?0:widget.level}',style: TextStyle(color:Colors.blue[900])),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(3, 3, 3, 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  width: 1, color: Colors.blue[900])),
                          child: BlocBuilder<BottomBloc, BottomState>(
                            condition:
                                (BottomState previous, BottomState current) =>
                                    previous is DataFetched !=
                                    current is DataFetched,
                            builder: (ctx, state) {
                              if (state is BottomUninitialized) {
                                return Center(child: Text('Initializing...'));
                              } else if (state is ErrorFetching) {
                                final stateError = state;
                                DioError dioError = stateError.dioError;
                                Utils()
                                    .onError(_scaffoldKey, dioError, context);
                                return Center(
                                  child: Text(dioError.error),
                                );
                              } else if (state is DataFetched) {
                                final stateAsListFetched = state as DataFetched;
                                _responseDio = stateAsListFetched.responsedio;
                                _divisionFeed = _responseDio.data;

                                if (lstDivision != null) lstDivision.clear();
                                lstDivision.addAll(_divisionFeed.data);
                                if (_selected == null)
                                  _selected = lstDivision[0];
                                _dropdownMenuItems =
                                    buildDropdownMenuItems(lstDivision);
                              } else if (state is DataFetchedStores) {
                                final stateAsListFetched =
                                    state as DataFetchedStores;
                                _responseDio = stateAsListFetched.responsedio;
                                _storeFeed = _responseDio.data;

                                if (lstStores != null) lstStores.clear();
                                lstStores.addAll(_storeFeed.data);
                                if (_selectedStore == null)
                                  _selectedStore = lstStores[0];
                                _dropdownMenuItemsStores =
                                    buildDropdownMenuItemsStores(lstStores);
                              }
                              return ExpandablePanel(
                                header: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Request Information',
                                    style: TextStyle(color: Colors.blue[900]),
                                  ),
                                ),
                                expanded: Column(
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
                                        _checkbox('SAP', sap),
                                        _checkbox('GMD', gmd),
                                        _checkbox('B2B', b2b),
                                        _checkbox('INTERNET', inet),
                                        _checkbox('Email', email),
                                        _checkbox('Wi-Fi', wifi),
                                        _checkbox('Mobile Email', mEmail),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 14,
                                    ),
                                    _division(),
                                    _company(),
                                    _store(),
                                    _buttonSave()
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }

  _buttonSave() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.blue[900]),
          width: double.infinity,
          child: FlatButton(
              onPressed: () {
                _newUserBloc = BlocProvider.of<NewUserBloc>(context);
                _newUserBloc.add(RefreshEvent(
                    widget.jobCd,
                    widget.strCd,
                    widget.empNo,
                    widget.corpFg,
                    widget.directorat,
                    0,
                    widget.maxMove,
                    widget.totalData));
                Navigator.pop(context);
              },
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              )),
        )
      ],
    );
  }
}
