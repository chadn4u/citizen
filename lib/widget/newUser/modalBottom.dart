import 'package:citizens/models/newUser/division.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class NewUserBottom extends StatefulWidget {
  @override
  _NewUserBottomState createState() => _NewUserBottomState();

  final List<Division> lstDivision = [
    Division('04', '(HQ) Customer Development'),
    Division('04', '(HQ) Customer Development'),
    Division('04', '(HQ) Customer Development'),
    Division('04', '(HQ) Customer Development'),
    Division('04', '(HQ) Customer Development'),
    Division('04', '(HQ) Customer Development'),
    Division('04', '(HQ) Customer Development'),
    Division('04', '(HQ) Customer Development'),
    Division('04', '(HQ) Customer Development'),
    Division('04', '(HQ) Customer Development'),
    Division('04', '(HQ) Customer Development'),
    Division('04', '(HQ) Customer Development'),
    Division('04', '(HQ) Customer Development'),
    Division('04', '(HQ) Customer Development'),
    Division('04', '(HQ) Customer Development'),
    Division('04', '(HQ) Customer Development'),
    Division('04', '(HQ) Customer Development'),
    Division('04', '(HQ) Customer Development'),
    Division('04', '(HQ) Customer Development'),
    Division('04', '(HQ) Customer Development'),
    Division('04', '(HQ) Customer Development'),
    Division('04', '(HQ) Customer Development'),
    Division('04', '(HQ) Customer Development'),
    Division('04', '(HQ) Customer Development'),
    Division('04', '(HQ) Customer Development'),
    Division('04', '(HQ) Customer Development'),
    Division('04', '(HQ) Customer Development'),
    Division('04', '(HQ) Customer Development'),
  ];
}

class _NewUserBottomState extends State<NewUserBottom> {
  final TextEditingController employeeNo = TextEditingController();
  bool sap = false;
  bool gmd = false;
  bool b2b = false;
  bool inet = false;
  bool email = false;
  bool wifi = false;
  bool mEmail = false;
  String _groupValue = "";
  List<DropdownMenuItem<Division>> _dropdownMenuItems;

  Division _selected;

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

  Widget _checkbox(String title, bool boolValue) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 10, color: Colors.blue[900]),
        ),
        Theme(
          data: ThemeData(
            unselectedWidgetColor: Colors.blue[900]
          ),
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
                        value: _selected,
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
                    child: DropdownButton<Division>(
                        isExpanded: false,
                        value: _selected,
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

  @override
  void initState() {
    super.initState();
    _selected = widget.lstDivision[0];
    _dropdownMenuItems = buildDropdownMenuItems(widget.lstDivision);
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
          ),
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
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
                          style:
                              TextStyle(color: Colors.blue[900], fontSize: 24),
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
                            border:
                                Border.all(color: Colors.blue[900], width: 1)),
                        child: ExpandablePanel(
                          header: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Request Information',
                              style: TextStyle(color: Colors.blue[900]),
                            ),
                          ),
                          expanded: Text('tar aja dirumah'),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(3, 3, 3, 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(width: 1, color: Colors.blue[900])),
                        child: ExpandablePanel(
                          header: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Employee Information',
                              style: TextStyle(color: Colors.blue[900]),
                            ),
                          ),
                          hasIcon: true,
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
                        ),
                      ),
                    ],
                  )
                ],
              )),
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
